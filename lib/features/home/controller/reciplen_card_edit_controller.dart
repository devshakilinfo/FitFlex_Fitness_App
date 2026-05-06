import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReciplenCardEditController extends GetxController with GetSingleTickerProviderStateMixin {
  // Form controllers
  final minimumController = TextEditingController();
  final maximumController = TextEditingController();
  final minWeightController = TextEditingController();
  final maxWeightController = TextEditingController();
  final foodTitleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable state
  var selectedFitnessLevel = Rx<String?>(null);
  var selectedImage = Rx<File?>(null);
  var breakfastFields = <Widget>[].obs;
  var lunchFields = <Widget>[].obs;
  var dinnerFields = <Widget>[].obs;
  var snacksFields = <Widget>[].obs;
  var selectedMeal = 'breakfast'.obs;

  // Meal controllers
  final breakfastControllers = <TextEditingController>[];
  final lunchControllers = <TextEditingController>[];
  final dinnerControllers = <TextEditingController>[];
  final snacksControllers = <TextEditingController>[];

  // Constants
  final List<String> fitnessLevels = ['Underweight', 'Normal', 'Overweight', 'Obese'];
  final _picker = ImagePicker();
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() => _updateMealBasedOnTab(tabController.index));
    _initializeMealFields();
  }

  @override
  void onClose() {
    tabController.dispose();
    _disposeControllers([minimumController, maximumController, minWeightController, maxWeightController, foodTitleController, descriptionController, ...breakfastControllers, ...lunchControllers, ...dinnerControllers, ...snacksControllers]);
    super.onClose();
  }

  // Image picker
  Future<void> pickImage(BuildContext context) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      selectedImage.value = pickedFile != null ? File(pickedFile.path) : null;
      _showSnackBar(context, pickedFile != null ? 'Image selected: ${pickedFile.path}' : 'No image selected');
    } catch (e) {
      debugPrint('Error picking image: $e');
      _showSnackBar(context, 'Failed to pick image');
    }
  }

  // Create meal plan
  Future<void> createPlan() async {
    final mealLists = _getMealLists();
    if (!_validateInputs(mealLists)) return;

    try {
      EasyLoading.show(status: 'Creating plan...');
      final authToken = await _getAuthToken();
      final requestBody = _buildRequestBody(mealLists);

      final response = await _sendRequest(authToken, requestBody);
      _handleResponse(response);
    } on SocketException {
      _handleError('No internet connection.');
    } on TimeoutException {
      _handleError('Request timed out.');
    } catch (e, stack) {
      _handleError('Unexpected error: $e', stack: stack);
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Clear form
  void clearForm() {
    [foodTitleController, descriptionController, minimumController, maximumController, minWeightController, maxWeightController].forEach((c) => c.clear());
    selectedFitnessLevel.value = null;
    selectedImage.value = null;
    [breakfastControllers, lunchControllers, dinnerControllers, snacksControllers].forEach((c) => c.clear());
    [breakfastFields, lunchFields, dinnerFields, snacksFields].forEach((f) => f.clear());
    _initializeMealFields();
  }

  // Helper methods
  void updateFitnessLevel(String level) => selectedFitnessLevel.value = level;

  void _updateMealBasedOnTab(int index) => selectedMeal.value = ['breakfast', 'lunch', 'dinner', 'snacks'][index];

  void _initializeMealFields() {
    _addMealTextField(breakfastControllers, breakfastFields, _addBreakfastTextField);
    _addMealTextField(lunchControllers, lunchFields, _addLunchTextField);
    _addMealTextField(dinnerControllers, dinnerFields, _addDinnerTextField);
    _addMealTextField(snacksControllers, snacksFields, _addSnacksTextField);
  }

  void _addBreakfastTextField() => _addMealTextField(breakfastControllers, breakfastFields, _addBreakfastTextField);
  void _addLunchTextField() => _addMealTextField(lunchControllers, lunchFields, _addLunchTextField);
  void _addDinnerTextField() => _addMealTextField(dinnerControllers, dinnerFields, _addDinnerTextField);
  void _addSnacksTextField() => _addMealTextField(snacksControllers, snacksFields, _addSnacksTextField);

  void _addMealTextField(List<TextEditingController> controllers, RxList<Widget> fields, VoidCallback onAdd) {
    final controller = TextEditingController();
    controllers.add(controller);
    fields.add(_buildMealField(controller, onAdd));
  }

  Widget _buildMealField(TextEditingController controller, VoidCallback onAdd) => Padding(
    padding: const EdgeInsets.only(top: 6),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Type here...',
        suffixIcon: IconButton(onPressed: onAdd, icon: const Icon(Icons.add_circle_outline, color: Color(0xff4081FF))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xffDFDFDF))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xffDFDFDF))),
      ),
    ),
  );

  Map<String, List<String>> _getMealLists() => {
    'breakfast': breakfastControllers.map((c) => c.text.trim()).toList(),
    'lunch': lunchControllers.map((c) => c.text.trim()).toList(),
    'dinner': dinnerControllers.map((c) => c.text.trim()).toList(),
    'snacks': snacksControllers.map((c) => c.text.trim()).toList(),
  };

  bool _validateInputs(Map<String, List<String>> mealLists) {
    if (foodTitleController.text.trim().isEmpty) return _showError('Please enter a title for the meal plan.');
    if (selectedFitnessLevel.value == null || selectedFitnessLevel.value!.trim().isEmpty) return _showError('Please select a fitness level.');
    if (mealLists.values.every((list) => list.every((e) => e.isEmpty))) return _showError('Please add at least one item for breakfast, lunch, dinner, and snacks.');

    final ranges = [
      double.tryParse(minimumController.text.trim()),
      double.tryParse(maximumController.text.trim()),
      double.tryParse(minWeightController.text.trim()),
      double.tryParse(maxWeightController.text.trim()),
    ];
    if (ranges.contains(null)) return _showError('Please enter valid numbers for height and weight ranges.');
    if (ranges[0]! < 100 || ranges[1]! > 250 || ranges[2]! < 30 || ranges[3]! > 200) return _showError('Please enter realistic height (100–250 cm) and weight (30–200 kg) ranges.');

    return true;
  }

  Future<String> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');
    if (authToken == null) throw Exception('Authentication token not found.');
    debugPrint('🔐 Auth token: $authToken');
    return authToken;
  }

  Map<String, dynamic> _buildRequestBody(Map<String, List<String>> mealLists) => {
    'title': foodTitleController.text.trim(),
    'description': descriptionController.text.trim(),
    'heightRange': {'min': double.parse(minimumController.text.trim()), 'max': double.parse(maximumController.text.trim())},
    'weightRange': {'min': double.parse(minWeightController.text.trim()), 'max': double.parse(maxWeightController.text.trim())},
    'fitnessLevel': selectedFitnessLevel.value!.trim(),
    'breakfast': mealLists['breakfast']!.where((e) => e.isNotEmpty).toList(),
    'lunch': mealLists['lunch']!.where((e) => e.isNotEmpty).toList(),
    'dinner': mealLists['dinner']!.where((e) => e.isNotEmpty).toList(),
    'snacks': mealLists['snacks']!.where((e) => e.isNotEmpty).toList(),
  };

  Future<http.Response> _sendRequest(String authToken, Map<String, dynamic> requestBody) async {
    debugPrint('📦 JSON body: ${jsonEncode(requestBody)}');

    if (selectedImage.value == null) {
      return await http.post(
        Uri.parse(Urls.createPlan),
        headers: {'Authorization': authToken, 'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
    }

    final request = http.MultipartRequest('POST', Uri.parse(Urls.createPlan))..headers['Authorization'] = authToken;

    // Use 'mealData' as the field name to match Postman
    request.fields['mealData'] = jsonEncode(requestBody);

    debugPrint('🖼️ Attaching image: ${selectedImage.value!.path}');
    request.files.add(await http.MultipartFile.fromPath('image', selectedImage.value!.path));

    debugPrint('📤 Request fields: ${request.fields}');
    return await http.Response.fromStream(await request.send());
  }

  void _handleResponse(http.Response response) {
    debugPrint('📨 Response status: ${response.statusCode}');
    debugPrint('📨 Response body: ${response.body}');

    if (response.statusCode == 201) {
      EasyLoading.showSuccess('Plan created successfully!');
      debugPrint('✅ Plan creation succeeded.');
      clearForm();
    } else {
      final decodedBody = jsonDecode(response.body);
      final errorMessage = decodedBody['message'] ?? 'Failed to create the plan';
      final errorDetails = decodedBody['errorSource']?.map((e) => '${e['path']}: ${e['message']}').join(', ') ?? '';
      EasyLoading.showError('$errorMessage${errorDetails.isNotEmpty ? ' ($errorDetails)' : ''}');
      debugPrint('❌ Error creating plan: $errorMessage ($errorDetails)');
    }
  }

  bool _showError(String message) {
    EasyLoading.showError(message);
    return false;
  }

  void _handleError(String message, {Object? stack}) {
    debugPrint('❗ $message');
    if (stack != null) debugPrint('📚 Stack trace: $stack');
    EasyLoading.showError(message);
  }

  void _showSnackBar(BuildContext context, String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  void _disposeControllers(List<TextEditingController> controllers) => controllers.forEach((c) => c.dispose());
}