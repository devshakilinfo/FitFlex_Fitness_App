import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:get/get.dart';
import 'dart:convert'; // for json decoding
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeightRangeController extends GetxController {
  // Private variables to hold the height and weight values as Strings
  String _height = '';
  String _weight = '';

  // Getter method for height

  // Setter method for height
  set height(String newHeight) {
    _height = newHeight;
  }

  // Getter method for weight

  // Setter method for weight
  set weight(String newWeight) {
    _weight = newWeight;
  }

  // Method to update weight range through API
  Future<void> updateWeightRange() async {
    // Validate user input
    if (_height.isEmpty || _weight.isEmpty) {
      return;
    }
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('auth_token');

      // Convert height and weight to strings explicitly
      final response = await http.post(
        Uri.parse(Urls.suggestMealPlans),
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
          'Authorization': "$authToken", // Authorization token
        },
        body: jsonEncode({
          "height": _height, // Send height as a string
          "weight": _weight, // Send weight as a string
        }),
      );

      if (response.statusCode == 200) {
        // Success
        // ignore: avoid_print
        print('Successfully updated weight range: ${response.body}');
      } else {
        // Error
        // ignore: avoid_print
        print('Failed to update weight range');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error occurred: $e');
    }
  }
}
