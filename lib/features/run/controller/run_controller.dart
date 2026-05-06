import 'dart:async';
import 'dart:convert';
import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http show post;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class TrackingController extends GetxController {
  var elapsedTime = '00:00:00'.obs; // Timer display
  var distanceCovered = 0.0.obs; // Distance in meters
  var isTracking = false.obs; // Tracking state
  var isPaused = false.obs; // Pause state
  var destination = 6.0.obs;
  var finalDestination = 0.0.obs;
  var remainingDistance = 0.0.obs;

  Timer? _timer;
  int _seconds = 0;
  Position? _previousPosition;
  StreamSubscription<Position>? _positionStream;

  @override
  void onInit() {
    super.onInit();
    _checkLocationPermission();
    final arg = Get.arguments;

    if (kDebugMode) {
      print("//////////The argument is $arg");
    }
    destination.value = double.parse(arg);
    finalDestination.value = destination.value * 1000;
    if (kDebugMode) {
      print("//////////The destination is ${destination.value}");
      print("//////////The final destination is ${finalDestination.value}");
    }
    remainingDistance.value = finalDestination.value;
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied.');
      return;
    }
  }

  void startTracking() async {
    if (!isTracking.value) {
      isTracking.value = true;
      isPaused.value = false;
      _seconds = 0;
      distanceCovered.value = 0.0;
      _previousPosition = null;

      _startTimer();
      _startPositionStream();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      int hours = _seconds ~/ 3600;
      int minutes = (_seconds % 3600) ~/ 60;
      int seconds = _seconds % 60;
      elapsedTime.value =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    });
  }

  void _startPositionStream() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // Update every 5 meters
      ),
    ).listen((Position position) {
      if (isPaused.value) return;  
      if (_previousPosition != null) {
        double distance = Geolocator.distanceBetween(
          _previousPosition!.latitude,
          _previousPosition!.longitude,
          position.latitude,
          position.longitude,
        );
        distanceCovered.value += distance;
        remainingDistance.value =
            finalDestination.value - distanceCovered.value;
      }
      _previousPosition = position;
    });
  }

  void pauseTracking() {
    if (isTracking.value && !isPaused.value) {
      _timer?.cancel();
      _positionStream?.pause();
      isPaused.value = true;
    }
  }

  void resumeTracking() {
    if (isTracking.value && isPaused.value) {
      _startTimer();
      _positionStream?.resume();
      isPaused.value = false;
    }
  }

  void finishTracking() {
    if (isTracking.value) {
      _timer?.cancel();
      _positionStream?.cancel();
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (kDebugMode) {
      print('Retrieved Token: $token');
    }
    return token;
  }

  final logger = Logger();
  Future<void> sendRunData() async {
    try {
      EasyLoading.show(status: 'Sending run data...');
      String? token = await _getToken();
      if (token == null) {
        logger.d('Token is null');
        return;
      }

      final parts = elapsedTime.value.split(':');
      String formattedTime = '00h 00m 00s';
      if (parts.length == 3) {
        final hours = parts[0].padLeft(2, '0');
        final minutes = parts[1].padLeft(2, '0');
        final seconds = parts[2].padLeft(2, '0');
        formattedTime = '${hours}h ${minutes}m ${seconds}s';
      }

      logger.d('Formatted Time: $formattedTime'); // Log as debug message

      final response = await http.post(
        Uri.parse('${Urls.baseUrl}/running/postFinalRunData'),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode({
          "running_Goal": finalDestination.value,
          "timeDuration": formattedTime,
          "distance_covered": distanceCovered.value,
          "distance_ramaining": remainingDistance.value,
        }),
      );

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Run data sent successfully');
        logger.i('Run data sent successfully: ${response.body}'); // Log as info message
        resetTracking();
        Get.back();
      } else {
        EasyLoading.showError('Failed to send run data');
        resetTracking();
        Get.back();
        logger.e('Failed to send run data: ${response.body}'); // Log as error message
      }
    } catch (e) {
      logger.e('Error sending run data: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }


  void resetTracking() {
    isTracking.value = false;
    isPaused.value = false;
    elapsedTime.value = '00:00:00';
    distanceCovered.value = 0.0;
    remainingDistance.value = finalDestination.value;
    _seconds = 0;
    _previousPosition = null;
  }

  @override
  void onClose() {
    _timer?.cancel();
    _positionStream?.cancel();
    super.onClose();
  }
}
