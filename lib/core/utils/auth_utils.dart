import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'validators/app_validator.dart';

class AuthUtils {
  // Use AppValidator for email validation
  static String? validateEmail(String? value) => AppValidator.validateEmail(value);

  // Use AppValidator for password validation
  static String? validatePassword(String? value) => AppValidator.validatePassword(value);

  // Use AppValidator for phone number validation
  static String? validatePhoneNumber(String? value) => AppValidator.validatePhoneNumber(value);

  // Password match validation
  static String? validatePasswordMatch(String? password, String? retypePassword) {
    if (password != retypePassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Save auth token
  static Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Get auth token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Clear auth token
  static Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Generic API call handler
  static Future<Map<String, dynamic>?> makeApiCall(
      String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw _getApiError(response.statusCode);
      }
    } on SocketException {
      throw 'No internet connection. Please check your network.';
    } on TimeoutException {
      throw 'The connection has timed out. Please try again.';
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  static String _getApiError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Incorrect email or password.';
      case 404:
        return 'Server not found. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Request failed. Please try again.';
    }
  }
}