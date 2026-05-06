import 'dart:convert';
import 'package:fit_flex3/core/endPoint/urls.dart';
import 'package:fit_flex3/features/auth/controller/login_controller.dart';
import 'package:fit_flex3/features/auth/screen/log_in_screen.dart';
import 'package:fit_flex3/features/auth/screen/sing_up_screen.dart';
import 'package:fit_flex3/features/profile/model/profile_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  // Text controllers for profile fields
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController residencyAreaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Text controllers for change password
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // State for edit profile toggle
  var isEditing = false.obs;

  // State for change password expansion
  var isExpanded = false.obs;

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchprofile();
  }

  @override
  void onClose() {
    userNameController.dispose();
    ageController.dispose();
    genderController.dispose();
    heightController.dispose();
    weightController.dispose();
    residencyAreaController.dispose();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Fetch user profile
  Future<void> fetchprofile() async {
    try {
      if (EasyLoading.isShow) {
        EasyLoading.show(status: "Fetching Profile....");
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');

      debugPrint("Approval Token: $approvalToken");

      if (approvalToken == null) {
        EasyLoading.showError('Authentication token not found');
        debugPrint('Error: Authentication token not found');
        return;
      }

      debugPrint('Sending GET request to fetch profile...');
      final response = await http.get(
        Uri.parse(Urls.getprofile),
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
      );

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        debugPrint("Response is 200 OK, processing response...");
        final decodedJson = jsonDecode(response.body);

        debugPrint("Decoded JSON: $decodedJson");

        if (decodedJson['data'] != null) {
          final profileData = decodedJson['data'];

          debugPrint("Profile Data: $profileData");

          userNameController.text = profileData['name'] ?? '';
          ageController.text = profileData['age']?.toString() ?? '';
          genderController.text = profileData['gender'] ?? ''; // Set to empty string if null
          heightController.text = profileData['hight']?.toString() ?? '';
          weightController.text = profileData['weight']?.toString() ?? '';
          residencyAreaController.text = profileData['recidenceArea'] ?? '';
          emailController.text = profileData['email'] ?? '';

          debugPrint("Text fields updated with profile data.");
        } else {
          debugPrint("Error: Missing 'data' in response.");
          EasyLoading.showError('Invalid response format.');
        }
      } else if (response.statusCode == 403) {
        debugPrint("Unauthorized access. Please check your token.");
        EasyLoading.showError('Unauthorized access. Please log in again.');
      } else {
        debugPrint("Error fetching profile: ${response.statusCode}");
        EasyLoading.showError('Failed to fetch profile.');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      EasyLoading.showError('An unexpected error occurred.');
    } finally {
      EasyLoading.dismiss();
      debugPrint('Loading dismissed.');
    }
  }

  // Update user profile
  Future<bool> updateProfile(UserProfile userProfile) async {
    try {
      EasyLoading.show(status: 'Saving changes...');
      debugPrint('Starting the profile update process...');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');
      debugPrint('Fetched authentication token: $approvalToken');

      if (approvalToken == null) {
        EasyLoading.showError('Authentication token not found');
        debugPrint('Error: Authentication token not found');
        return false;
      }

      final Map<String, dynamic> requestBody = {
        'name': userProfile.name,
        'recidenceArea': userProfile.residenceArea,
        'age': userProfile.age?.toString(),
        'gender': userProfile.gender, // Send selected gender (Male, Female, or null)
        'height': userProfile.height?.toString(),
        'weight': userProfile.weight?.toString(),
      };

      debugPrint('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.patch(
        Uri.parse(Urls.updateprofile),
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Profile updated successfully');
        debugPrint('Profile updated successfully!');
        return true;
      } else {
        EasyLoading.showError('Failed to update profile: ${response.body}');
        debugPrint('Failed to update profile: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      EasyLoading.showError('An unexpected error occurred.');
      return false;
    } finally {
      EasyLoading.dismiss();
      debugPrint('Loading dismissed.');
    }
  }

  // Update user password
  Future<void> updatePassword(BuildContext context) async {
    try {
      EasyLoading.show(status: 'Changing password...');
      debugPrint('Starting the password change process...');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');
      debugPrint('Fetched authentication token: $approvalToken');

      if (approvalToken == null) {
        EasyLoading.showError('Authentication token not found');
        debugPrint('Error: Authentication token not found');
        return;
      }

      String oldPassword = currentPasswordController.text;
      String newPassword = newPasswordController.text;

      debugPrint('Old Password: $oldPassword');
      debugPrint('New Password: $newPassword');

      final Map<String, dynamic> requestBody = {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };

      debugPrint('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(Urls.changepassword),
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Password changed successfully');
        debugPrint('Password changed successfully!');
        // Clear the password fields
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        // Close the dialog
        Navigator.of(context).pop();
      } else {
        EasyLoading.showError('Failed to change password: ${response.body}');
        debugPrint('Failed to change password: ${response.body}');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      EasyLoading.showError('An unexpected error occurred.');
    } finally {
      EasyLoading.dismiss();
      debugPrint('Loading dismissed.');
    }
  }

  // Self-destruct account
  Future<void> selfDestructAccount() async {
    try {
      EasyLoading.show(status: 'Self destructing account...');
      debugPrint('Starting the account self-destruct process...');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');
      debugPrint('Fetched authentication token: $approvalToken');

      if (approvalToken == null) {
        EasyLoading.showError('Authentication token not found');
        debugPrint('Error: Authentication token not found');
        return;
      }

      final url = Uri.parse(Urls.selfdistuct);
      debugPrint('Sending DELETE request to URL: $url');

      final response = await http.delete(
        url,
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Account self-destructed successfully');
        debugPrint('Account self-destructed successfully!');
        Get.to(() => const SignUpScreen());
      } else {
        EasyLoading.showError('Failed to self-destruct account: ${response.body}');
        debugPrint('Failed to self-destruct account: ${response.body}');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      EasyLoading.showError('An unexpected error occurred.');
    } finally {
      EasyLoading.dismiss();
      debugPrint('Loading dismissed.');
    }
  }

  // Logout user
  Future<void> logout() async {
    debugPrint('Starting logout process...');
    try {
      debugPrint('Showing EasyLoading with status "Logging out..."');
      EasyLoading.show(status: "Logging out...");

      debugPrint('Attempting to get LoginController instance using Get.find');
      final LoginController loginController = Get.find<LoginController>();
      debugPrint('LoginController instance obtained successfully');

      debugPrint('Calling signOut on LoginController to sign out from Google/Firebase');
      await loginController.signOut();
      debugPrint('signOut completed successfully');

      debugPrint('Fetching SharedPreferences instance');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint('SharedPreferences instance obtained');

      debugPrint('Retrieving auth_token from SharedPreferences');
      String? approvalToken = prefs.getString('auth_token');
      debugPrint('auth_token value: $approvalToken');

      if (approvalToken != null) {
        debugPrint('auth_token is not null, preparing to call backend logout API');
        debugPrint('API URL: ${Urls.logOut}');
        debugPrint('Headers: Authorization: $approvalToken, Content-Type: application/json');

        try {
          final response = await http.post(
            Uri.parse(Urls.logOut),
            headers: {
              'Authorization': approvalToken,
              'Content-Type': 'application/json',
            },
          );
          debugPrint('Backend logout API called');
          debugPrint('Response status code: ${response.statusCode}');
          debugPrint('Response body: ${response.body}');

          if (response.statusCode == 200 || response.statusCode == 204) {
            debugPrint('Backend logout successful');
          } else {
            debugPrint('Backend logout failed with status: ${response.statusCode}');
            debugPrint('Backend logout error response: ${response.body}');
            EasyLoading.showError('Failed to logout from server.');
            return;
          }
        } catch (apiError) {
          debugPrint('Error calling backend logout API: $apiError');
          EasyLoading.showError('Failed to communicate with server during logout.');
          return;
        }
      } else {
        debugPrint('auth_token is null, skipping backend logout API call');
      }

      debugPrint('Clearing auth_token from SharedPreferences');
      bool isRemoved = await prefs.remove('auth_token');
      debugPrint('auth_token removal result: ${isRemoved ? 'Success' : 'Failed'}');

      // Verify the token is actually removed
      String? tokenAfterRemoval = prefs.getString('auth_token');
      debugPrint('auth_token after removal: $tokenAfterRemoval');
      if (tokenAfterRemoval != null) {
        debugPrint('Warning: auth_token was not cleared properly from SharedPreferences');
        EasyLoading.showError('Failed to clear authentication data.');
        return;
      }

      debugPrint('Navigating to LogInScreen with Get.offAll');
      Get.offAll(() => const LogInScreen());
      debugPrint('Navigation to LogInScreen completed');

      debugPrint('Showing EasyLoading success message');
      EasyLoading.showSuccess('Logged out successfully');
    } catch (e, stackTrace) {
      debugPrint('Exception caught during logout: $e');
      debugPrint('Stack trace: $stackTrace');
      EasyLoading.showError('An error occurred while logging out: $e');
      debugPrint('Error logged to console: $e');
    } finally {
      debugPrint('Executing finally block');
      EasyLoading.dismiss();
      debugPrint('EasyLoading dismissed');
    }
    debugPrint('Logout process completed');
  }
}