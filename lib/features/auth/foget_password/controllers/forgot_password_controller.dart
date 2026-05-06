import 'dart:convert';

import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:fit_flex3/features/auth/foget_password/screens/pin_verification_screen.dart'
    show PinVerificationScreen;
import 'package:fit_flex3/features/auth/foget_password/screens/set_password_screen.dart' show SetPasswordScreen;
import 'package:fit_flex3/features/auth/screen/log_in_screen.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http show post;

class ForgotPasswordController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController(); 
  var confirmPasswordController = TextEditingController();

  Future<void> sendOtp() async {
    try {
      EasyLoading.show(status: 'Loading...');
      String email = emailController.text.toString().trim();
      if (email.isEmpty) {
        Get.snackbar("Error", "Please enter your email");
        return;
      }
      final response = await http.post(
        Uri.parse('${Urls.baseUrl}/auth/forgetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (kDebugMode) {
        print("The url is: ${Urls.baseUrl}/auth/forgetPassword");
      }
     
      if (kDebugMode) {
        print("The email is: $email");
      }

      if (kDebugMode) {
        print("Response status: ${response.body}");
      }

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('OTP sent successfully');
        Get.to(() => PinVerificationScreen());
      } else {
        EasyLoading.showError('Failed to send OTP');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }


  Future<void> verifyOtp(String otp) async {
    try {
      EasyLoading.show(status: 'Loading...');
      String email = emailController.text.toString().trim();
      if (otp.isEmpty) {
        Get.snackbar("Error", "Please enter the OTP");
        return;
      }
      final response = await http.post(
        Uri.parse('${Urls.baseUrl}/auth/checkOTP'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'OTP': otp}),
      );

      if (kDebugMode) {
        print("Response status: ${response.body}");
      }

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('OTP verified successfully');
        Get.to(() => SetPasswordScreen());
      } else {
        EasyLoading.showError('Failed to verify OTP');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future <void> resetPassword() async {
    try {
      EasyLoading.show(status: 'Loading...');
      String email = emailController.text.toString().trim();
      String password = passwordController.text.toString().trim();
      String confirmPassword = confirmPasswordController.text.toString().trim();

      if (password != confirmPassword) {
        Get.snackbar("Error", "Passwords do not match");
        return;
      }


      if (password.isEmpty || confirmPassword.isEmpty) {
        Get.snackbar("Error", "Please enter your password");
        return;
      }

      if (password != confirmPassword) {
        Get.snackbar("Error", "Passwords do not match");
        return;
      }

      final response = await http.post(
        Uri.parse('${Urls.baseUrl}/auth/setPasswordAfrerOTPmatched'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'newPassword': password}),
      );

      if (kDebugMode) {
        print("Response status: ${response.body}");
      }

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Password reset successfully');
        Get.offAll(() => LogInScreen());
      } else {
        EasyLoading.showError('Failed to reset password');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      EasyLoading.dismiss();
    } 
  }



}
