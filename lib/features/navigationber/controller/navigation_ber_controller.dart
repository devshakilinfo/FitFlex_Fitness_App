import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class BottomNavbarController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? approvalToken = prefs.getString('auth_token');

    // Print the approvalToken
    if (approvalToken != null) {
      if (kDebugMode) {
        print("Approval Token: $approvalToken");
      }
    } else {
      if (kDebugMode) {
        print("No approval token found.");
      }
    }
  }
}
