import 'package:fit_flex3/core/endPoint/urls.dart';
import 'package:fit_flex3/features/auth/screen/log_in_screen.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, GoogleAuthProvider, OAuthCredential, User, UserCredential;
import 'package:fit_flex3/features/navigationber/screen/navigation_ber.dart';
import 'package:fit_flex3/routes/app_routes.dart' show AppRoute;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
import 'dart:convert';


class SignUpController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isTermsAccepted = false.obs;

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;

  // Create an instance of Logger
  var logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _checkIfUserIsSignedIn();
  }

  void _checkIfUserIsSignedIn() async {
    User? user = auth.currentUser;
    if (user != null) {
      // If the user is already signed in, navigate to the BottomNavbar
      Get.offAll(BottomNavbar());
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Show loading indicator
      EasyLoading.show(status: 'Signing in with Google...');
      logger.d("Starting Google Sign-In process");

      // Trigger Google Sign-In flow
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        EasyLoading.dismiss();
        EasyLoading.showError('Sign-In canceled');
        logger.w("Google sign-in was canceled by the user");
        return null; // User canceled the sign-in
      }

      logger.d("Google user signed in: ${googleUser.email}");

      // Get Google authentication credentials
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      logger.d("Google Authentication obtained");

      OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Log the credentials
      logger.d("Google ID Token: ${googleAuth.idToken}");
      logger.d("Google Access Token: ${googleAuth.accessToken}");

      // Sign in to Firebase with the obtained credentials
      UserCredential userCredential = await auth.signInWithCredential(credential);

      // Log user email
      logger.d("User email: ${userCredential.user?.email}");

      if (userCredential.user == null) {
        // If user is null after sign-in, display error
        EasyLoading.dismiss();
        EasyLoading.showError('Sign-In failed');
        logger.e("User is null after sign-in.");
        return null;
      }

      // Log the user in with your API (social login)
      socialLogIn(email: userCredential.user?.email, method: "google");

      // Hide loading and show success message
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Google Sign-In successful!');
      logger.d("Google Sign-In successful, redirecting...");

      return userCredential.user;
    } catch (e) {
      // In case of error, hide loading and show error message
      EasyLoading.dismiss();
      EasyLoading.showError('Error: $e');
      logger.e("Error signing in with Google: $e");
      return null;
    }
  }

  // Function to handle social login logic (API interaction)
  void socialLogIn({required String? email, required String? method}) async {
    final response = await http.post(
      Uri.parse(Urls.login),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({"email": email, "method": method}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      final String approvalToken = data['approvalToken'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', approvalToken);

      EasyLoading.showSuccess('Login successful!');
      Get.offAll(BottomNavbar());
    } else {
      EasyLoading.showError('Api Error');
      logger.e('API call failed with status code: ${response.statusCode}');
    }
  }

  Future<void> register() async {
    try {
      EasyLoading.show(status: "Loading...");
      final url = Urls.register;
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "aggriedToterms": isTermsAccepted.value,
        }),
      );
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Register successful!');
        Get.offAllNamed(AppRoute.loginScreen);
      } else {
        EasyLoading.showError('Registration failed. Please try again.');
      }
    } catch (e) {
      EasyLoading.showError('An error occurred. Please try again.');
      logger.e("Registration failed: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
    Get.to(LogInScreen());
  }
}
