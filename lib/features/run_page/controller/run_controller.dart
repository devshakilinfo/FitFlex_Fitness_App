import 'package:fit_flex3/core/endPoint/urls.dart';
import 'package:fit_flex3/features/run_page/models/leaderboard_positon_model.dart';
import 'package:fit_flex3/features/run_page/models/previous_run_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RunController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchPreviousRunData();
    getLeaderBoardPosition();
  }

  var position = Rx<Position?>(null);
  var isLoading = false.obs;

  var previousRunData = Rx<PreviousRunModel?>(null);
  var errorMessage = ''.obs;

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> fetchPreviousRunData() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      String? token = await getToken();

      if (token == null) {
        errorMessage.value = 'No token available';
        isLoading.value = false;
        return;
      }

      final url = '${Urls.baseUrl}/running/getPreviousRun';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        previousRunData.value = PreviousRunModel.fromJson(
          json.decode(response.body),
        );
        isLoading.value = false;
      } else {
        errorMessage.value =
            'Failed to load data. Status code: ${response.statusCode}';
        isLoading.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      isLoading.value = false;
    }
  }

  var leaderBoardPosition = Rx<LeaderBoardPositionModel?>(null);

  Future<void> getLeaderBoardPosition() async {
    isLoading(true);

    try {
      String? token = await getToken();

      if (token == null) {
        debugPrint('Token is null');
        isLoading(false);
        return;
      }

      final url = Uri.parse("${Urls.baseUrl}/users/leadarBoardPosition");

      final response = await http.get(
        url,
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        leaderBoardPosition.value = LeaderBoardPositionModel.fromJson(
          json.decode(response.body),
        );
      } else {
        debugPrint('Failed to load leaderboard: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> requestLocationPermission() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    return locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse;
  }

  Future<bool> checkGPSServiceEnable() async {
    return Geolocator.isLocationServiceEnabled();
  }

  var distance = 6.0.obs;

  void increaseDistance() {
    distance.value += 1.0;
  }

  void decreaseDistance() {
    if (distance.value > 1.0) {
      distance.value -= 1.0;
    }
  }

  String convertToKilometers(
    String? totalDistanceCrossed, {
    int decimalPlaces = 2,
    bool inKilometers = true,
  }) {
    if (totalDistanceCrossed != null && totalDistanceCrossed.isNotEmpty) {
      try {
        double meters = double.parse(totalDistanceCrossed);
        if (inKilometers) {
          double kilometers = meters / 1000;
          return '${kilometers.toStringAsFixed(decimalPlaces)} Km';
        } else {
          return '${meters.toStringAsFixed(decimalPlaces)} M';
        }
      } catch (e) {
        return 'Invalid data';
      }
    } else {
      return '0.0';
    }
  }
}
