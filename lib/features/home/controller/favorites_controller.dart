import 'dart:convert';
import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:fit_flex3/features/home/model/all_meal_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/favorites_model.dart';
import '../model/suggest_meal_plans.dart';

class FavoritesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getFavoriteMeal();
    fetchMealPlans();
    getSuggestMealPlansMeal();
  }

  // Use a single getFavoriteModel with FavoritesData type
  var getFavoriteModel = <FavoritesData>[].obs;
  var getSuggestMealData = <SuggestMealData>[].obs;
  var isLoading = false.obs;

  RxString favoriteTitle = "".obs;
  RxString suggestMealPlans = "".obs;

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  final List<Map<String, String>> favorites = [
    {"title": 'MEAL PLAN A', 'image': "assets/images/food_image1.png"},
    {"title": 'MEAL PLAN B', 'image': "assets/images/food_image2.png"},
    {"title": 'MEAL PLAN A', 'image': "assets/images/food_image3.png"},
    {"title": 'MEAL PLAN B', 'image': "assets/images/food_image4.png"},
  ];

  var selectedIndex = RxInt(-1);
  void toggleFavorite(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = -1;
    } else {
      selectedIndex.value = index;
    }
  }

  var isFavoriteselectedIndex = RxInt(-1);
  void isToggleFavorite(int index) {
    if (isFavoriteselectedIndex.value == index) {
      isFavoriteselectedIndex.value = -1;
    } else {
      isFavoriteselectedIndex.value = index;
    }
  }

  var issuggestMealSeletedIndex = RxInt(-1);
  void isTogglesuggestMealPlans(int index) {
    if (issuggestMealSeletedIndex.value == index) {
      issuggestMealSeletedIndex.value = -1;
    } else {
      issuggestMealSeletedIndex.value = index;
    }
  }

  var mealPlans = <AllMealModels>[].obs;
  var isLoadingMealPlans = true.obs;
  var errorMessage = ''.obs;
  RxString title = "".obs;

  final List<Map<String, String>> allMealPlanList = [
    {"title": 'MEAL PLAN A', 'image': "assets/images/food_image5.png"},
    {"title": 'MEAL PLAN B', 'image': "assets/images/food_image6.png"},
  ];

  RxBool isAllMealPlan = false.obs;
  void toggleAllMealPlan() {
    isAllMealPlan.value = !isAllMealPlan.value;
  }

  var isIconSeleted = <bool>[].obs;

  // Initialize isIconSeleted based on mealPlans and getFavoriteModel
  void initializeIconSelection() {
    isIconSeleted.assignAll(
      mealPlans.map((meal) =>
          getFavoriteModel.any((fav) => fav.sId == meal.sId)).toList(),
    );
  }

  // Toggle favorite status and update UI immediately
  Future<void> toggleFavoriteMeal(int index, String mealId) async {
    if (index >= mealPlans.length) return;

    // Update UI immediately for instant feedback
    isIconSeleted[index] = !isIconSeleted[index];
    isIconSeleted.refresh();

    if (isIconSeleted[index]) {
      await postFavoriteMeal(mealId: mealId);
    } else {
      await removeFavoriteMeal(mealId: mealId);
    }
  }

  Future<void> fetchMealPlans() async {
    try {
      isLoadingMealPlans.value = true;
      EasyLoading.show(status: "Loading...");

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('auth_token');

      if (authToken == null) {
        errorMessage.value = 'No authorization token found';
        debugPrint("fetchMealPlans: No auth token");
        return;
      }

      final response = await http.get(
        Uri.parse(Urls.allMealPlan),
        headers: {'Authorization': authToken},
      );

      debugPrint(
        "fetchMealPlans response: ${response.statusCode}, body: ${response.body}",
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];

        mealPlans.assignAll(
          data.map((meal) => AllMealModels.fromJson(meal)).toList(),
        );

        title.value = mealPlans.isNotEmpty ? "All Meal Plan" : "";
        initializeIconSelection(); // Sync isIconSeleted after fetching meals
        debugPrint(
          "Updated mealPlans: ${mealPlans.map((meal) => meal.sId).toList()}",
        );
      } else {
        errorMessage.value =
        'Failed to load meal plans: ${response.statusCode}';
        debugPrint("fetchMealPlans failed: ${response.body}");
      }
    } catch (e) {
      errorMessage.value = 'Error occurred: $e';
      debugPrint("Error in fetchMealPlans: $e");
    } finally {
      isLoadingMealPlans.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> postFavoriteMeal({required String mealId}) async {
    isLoading.value = true;
    EasyLoading.show(status: "Adding to favorites...");

    try {
      final String? token = await getToken();
      if (token == null) {
        debugPrint('Token is missing');
        EasyLoading.showError('Authentication token missing');
        return;
      }

      final response = await http.post(
        Uri.parse(Urls.postFavotiteMeal),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({"mealId": mealId}),
      );
      final decodedResponse = json.decode(response.body);
      debugPrint(
          "postFavoriteMeal status: ${response.statusCode}, body: $decodedResponse");

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("Added to favorites");
        await getFavoriteMeal();
        initializeIconSelection(); // Re-sync isIconSeleted after API call
      } else if (response.statusCode == 409) {
        EasyLoading.showInfo("Meal already in favorites");
        // Revert local change if already favorited
        final index = mealPlans.indexWhere((meal) => meal.sId == mealId);
        if (index != -1) {
          isIconSeleted[index] = true;
          isIconSeleted.refresh();
        }
      } else {
        final String message =
            decodedResponse['message'] ?? 'Failed to add to favorites';
        EasyLoading.showError(message);
        // Revert local change on failure
        final index = mealPlans.indexWhere((meal) => meal.sId == mealId);
        if (index != -1) {
          isIconSeleted[index] = false;
          isIconSeleted.refresh();
        }
        debugPrint("Add to favorite failed: $message");
      }
    } catch (e) {
      debugPrint("Exception in postFavoriteMeal: $e");
      EasyLoading.showError("Something went wrong. Please try again.");
      // Revert local change on error
      final index = mealPlans.indexWhere((meal) => meal.sId == mealId);
      if (index != -1) {
        isIconSeleted[index] = false;
        isIconSeleted.refresh();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFavoriteMeal({required String mealId}) async {
    isLoading.value = true;
    EasyLoading.show(status: "Removing from favorites...");

    try {
      String? token = await getToken();
      if (token == null) {
        debugPrint('Token is missing');
        EasyLoading.showError('Authentication token missing');
        return;
      }

      final response = await http.post(
        Uri.parse(Urls.removeFavotiteMeal),
        headers: {'content-type': 'application/json', 'Authorization': token},
        body: jsonEncode({"mealId": mealId}),
      );

      debugPrint("removeFavoriteMeal response: ${response.statusCode}");
      if (response.statusCode == 200) {
        EasyLoading.showSuccess("Unfavorited successfully");
        await getFavoriteMeal();
        initializeIconSelection(); // Re-sync isIconSeleted after API call
      } else {
        EasyLoading.showError('Failed to remove favorite meal');
        // Revert local change on failure
        final index = mealPlans.indexWhere((meal) => meal.sId == mealId);
        if (index != -1) {
          isIconSeleted[index] = true;
          isIconSeleted.refresh();
        }
      }
    } catch (e) {
      debugPrint("Error in removeFavoriteMeal: $e");
      EasyLoading.showError('Error occurred: $e');
      // Revert local change on error
      final index = mealPlans.indexWhere((meal) => meal.sId == mealId);
      if (index != -1) {
        isIconSeleted[index] = true;
        isIconSeleted.refresh();
      }
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> getFavoriteMeal() async {
    debugPrint('Fetching favorite meals');
    try {
      String? token = await getToken();
      if (token == null) {
        debugPrint('Token is missing');
        return;
      }
      final response = await http.get(
        Uri.parse(Urls.getFavotiteMeal),
        headers: {'Authorization': token},
      );

      debugPrint("getFavoriteMeal response: ${response.statusCode}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];

        getFavoriteModel.assignAll(
          data.map((meal) => FavoritesData.fromJson(meal)).toList(),
        );

        if (getFavoriteModel.isNotEmpty) {
          favoriteTitle.value = "Favorites Meal Plan";
        } else {
          favoriteTitle.value = "";
        }
        initializeIconSelection(); // Sync isIconSeleted after fetching favorites
        debugPrint(
          "Updated getFavoriteModel: ${getFavoriteModel.map((fav) => fav.sId).toList()}",
        );
      } else {
        debugPrint("Failed to fetch favorites: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in getFavoriteMeal: $e");
      EasyLoading.showError('Error occurred: $e');
    }
  }

  Future<void> getSuggestMealPlansMeal() async {
    debugPrint('Fetching suggested meal plans');
    try {
      String? token = await getToken();
      if (token == null) {
        debugPrint('Token is missing');
        return;
      }
      final response = await http.get(
        Uri.parse(Urls.suggestMealPlans),
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];

        getSuggestMealData.assignAll(
          data.map((meal) => SuggestMealData.fromJson(meal)).toList(),
        );

        if (getSuggestMealData.isNotEmpty) {
          suggestMealPlans.value = "Suggested Meal Plan";
        }
      } else {
        debugPrint("Failed to fetch suggested meals: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in getSuggestMealPlansMeal: $e");
      EasyLoading.showError('Error occurred: $e');
    }
  }
}