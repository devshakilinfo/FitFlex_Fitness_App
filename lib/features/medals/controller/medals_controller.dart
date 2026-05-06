// medals_controller.dart
import 'dart:convert';
import 'package:fit_flex3/core/endPoint/urls.dart';
import 'package:fit_flex3/features/share_screen/models/all_madels_model.dart';
import 'package:fit_flex3/features/share_screen/models/current_run_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MedalsController extends GetxController {
  var isUnlockedSelected = true.obs;
  var profiledata = <Data>[].obs;
  var allMadels = <AllMadels>[].obs;

  @override
  void onInit() {
    fetchAllMadels();
    getcurrentProfile();
    super.onInit();
  }

  void toggleSelection(bool isUnlocked) {
    isUnlockedSelected.value = isUnlocked;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> fetchAllMadels({int retryCount = 0}) async {
    const maxRetries = 2;
    try {
      EasyLoading.show(status: "Loading medals...");
      final response = await http.get(Uri.parse(Urls.allMadels));
      debugPrint('AllMadels Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        final AllMadelsData fetchedData = AllMadelsData.fromJson(decodedJson);

        if (fetchedData.success == true && fetchedData.data != null && fetchedData.data!.isNotEmpty) {
          allMadels.clear();
          allMadels.addAll(fetchedData.data!);
          // Log AllMadels fields for debugging
          for (var i = 0; i < allMadels.length; i++) {
            final medal = allMadels[i];
            debugPrint(
                "AllMadels[$i]: ID=${medal.sId}, Title=${medal.title}, Domain=${medal.domain ?? 'null'}, Distance=${medal.maxDistance ?? 'null'}, Time=${medal.maxTime ?? 'null'}, Days=${medal.daysInRow ?? 'null'}");
          }
          allMadels.refresh();
          debugPrint("Loaded ${allMadels.length} medals from allMadels");
        } else {
          EasyLoading.showError('No medal data found');
        }
      } else {
        throw Exception('Failed to fetch medals: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching medals (Retry $retryCount/$maxRetries): $e');
      if (retryCount < maxRetries) {
        await Future.delayed(Duration(seconds: 1));
        return fetchAllMadels(retryCount: retryCount + 1);
      }
      EasyLoading.showError('Failed to load medals: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getcurrentProfile({int retryCount = 0}) async {
    const maxRetries = 2;
    try {
      EasyLoading.show(status: 'Fetching profile...');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');
      debugPrint('Fetched authentication token: $approvalToken');

      if (approvalToken == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse(Urls.getprofile),
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      debugPrint('Profile Response Status: ${response.statusCode}');
      debugPrint('Profile Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final CurrentRun fetchedData = CurrentRun.fromJson(jsonData);
        if (fetchedData.success == true && fetchedData.data != null) {
          if (fetchedData.data!.medalAchieved != null) {
            profiledata.clear();
            profiledata.add(fetchedData.data!);
            profiledata.refresh();
            debugPrint("Profile Data Loaded: ${profiledata.first.name}, Medals: ${profiledata.first.medalAchieved?.length}");
          } else {
            EasyLoading.showError("No medals found in profile");
          }
        } else {
          EasyLoading.showError("No profile data found");
        }
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching profile (Retry $retryCount/$maxRetries): $e');
      if (retryCount < maxRetries) {
        await Future.delayed(Duration(seconds: 1));
        return getcurrentProfile(retryCount: retryCount + 1);
      }
      EasyLoading.showError('Failed to load profile: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
