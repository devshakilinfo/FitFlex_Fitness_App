import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' show FacebookAuthProvider, FirebaseAuth, GoogleAuthProvider, OAuthCredential, User, UserCredential;
import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:fit_flex3/features/auth/screen/log_in_screen.dart' show LogInScreen;
import 'package:fit_flex3/features/navigationber/screen/navigation_ber.dart' show BottomNavbar;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn, GoogleSignInAccount, GoogleSignInAuthentication;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 500), () {
    _checkIfUserIsSignedIn();
  });
  }

  void _checkIfUserIsSignedIn() async {
    User? user = auth.currentUser;
    if (user != null) {
      // If the user is already signed in, navigate to the BottomNavbar
      Get.offAll(
        BottomNavbar(),
      ); // Using Get.offAll to clear the previous screen stack
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      // Print the email here

      debugPrint("User email: ${userCredential.user?.email}");
      socialLogIn(email: userCredential.user?.email, method: "google");

      return userCredential.user;
  
    } catch (e) {
      debugPrint("Error signing in with Google: $e");
      return null;
    }
  }

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
    }
  }

  Future<User?> signInWithFacehook() async {
    try {
      await FacebookAuth.instance.login();

      final result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final UserCredential userCredential = await auth.signInWithCredential(
          facebookAuthCredential,
        );
        debugPrint("***************************${userCredential.user?.email}");
        socialLogIn(email: userCredential.user?.email, method: "facebook");
        Get.offAll(BottomNavbar());
        return userCredential.user;
      } else {
        EasyLoading.showError('Facebook login failed. Please try again.');
        return null;
      }
    } catch (e) {
      debugPrint("Error signing in with Facebook: $e");
      return null;
    }
  }

  Future<void> login() async {
    try {
      EasyLoading.show(status: "Loading...");
      final url = Urls.login;
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Login successful!');
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final String approvalToken = responseData['approvalToken'];
        await prefs.setString('auth_token', approvalToken);
        emailController.clear();
        passwordController.clear();
        Get.offAll(BottomNavbar());
      } else if (response.statusCode == 400) {
        EasyLoading.showError('Incorrect email or password.');
      } else if (response.statusCode == 404) {
        EasyLoading.showError('Server not found. Please try again later.');
      } else if (response.statusCode == 500) {
        EasyLoading.showError('No user found with this email');
      } else {
        EasyLoading.showError('Login failed. Please try again.');
      }
    } on SocketException {
      EasyLoading.showError(
        'No internet connection. Please check your network.',
      );
    } on TimeoutException {
      EasyLoading.showError('The connection has timed out. Please try again.');
    } catch (e) {
      EasyLoading.showError('An unexpected error occurred. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> signOut() async {
    try{
      await googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    await auth.signOut();
    Get.to(LogInScreen());
    }catch(e){
      debugPrint("Error signing out: $e");
    EasyLoading.showError('Error signing out.');
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
