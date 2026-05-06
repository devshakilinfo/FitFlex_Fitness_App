import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:flutter/foundation.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart'
    show
        Geolocator,
        LocationAccuracy,
        LocationPermission,
        Position,
        LocationSettings;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../navigationber/screen/navigation_ber.dart';

class OngoingController extends GetxController {
  var distance = 0.0.obs;
  var userLatitude = 0.0.obs;
  var userLongitude = 0.0.obs;
  var isPaused = false.obs;
  var destination = 6.0.obs;
  var finalDestination = 0.0.obs;
  var distanceCovered = 0.0.obs;
  var flightClimed = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
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

    getCurrentLocation();
    startRunning();
    updateLocationRecursively();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (kDebugMode) {
          print('Location services are disabled');
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (kDebugMode) {
            print('Location permissions are denied');
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (kDebugMode) {
          print('Location permissions are permanently denied');
        }
        return;
      }

      final locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      userLatitude.value = position.latitude;
      userLongitude.value = position.longitude;

      if (kDebugMode) {
        print(
          'Initial Location: Lat: ${userLatitude.value}, Long: ${userLongitude.value}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
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

  Future<void> startRunning() async {
    try {
      await getCurrentLocation();
      final token = await _getToken();
      if (token == null) {
        if (kDebugMode) {
          print('No token found');
        }
        return;
      }

      final response = await http.post(
        Uri.parse(
          '${Urls.baseUrl}/running/startRunOrChangeStatus?status=startRun&runningGoal=${finalDestination.value}&lon=${userLongitude.value}&lat=${userLatitude.value}',
        ),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      if (kDebugMode) {
        print('Start Running Response: ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Start Running Error: $e');
      }
    }
  }

  Future<void> updateLocationRecursively() async {
    try {
      await getCurrentLocation();
      final token = await _getToken();
      if (token == null) {
        if (kDebugMode) {
          print('No token found');
        }
        return;
      }

      final response = await http.post(
        Uri.parse(
          '${Urls.baseUrl}/running/updateLongAndLat?lon=${userLongitude.value}&lat=${userLatitude.value}',
        ),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      if (kDebugMode) {
        print("Raw API Response: ${response.body}");
        print("The latitude is ${userLatitude.value}");
        print("The longitude is ${userLongitude.value}");
        print("The distance before update is ${distance.value}");
      }

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 500 &&
          jsonResponse['message'] == 'No ongoing run found') {
        if (kDebugMode) {
          print('No ongoing run found, stopping updates');
        }
        return;
      }

      if (jsonResponse['success'] == true) {
        // Handle runningStatus regardless of whether data is null
        final runningStatus = jsonResponse['data']?['runningStatus'];
        if (runningStatus == 'pause') {
          isPaused.value = true;
        } else if (runningStatus == 'running') {
          isPaused.value = false;
        }

        // Only process data if it exists
        if (jsonResponse['data']?['data'] != null) {
          final data = jsonResponse['data']['data'];

          double remainingDistance =
              (data['distance_remaining'] as num?)?.toDouble() ?? 0.0;
          distance.value = remainingDistance < 0 ? 0 : remainingDistance;
          double coveredDistance =
              (data['distance_covered'] as num?)?.toDouble() ?? 0.0;
          distanceCovered.value = coveredDistance < 0 ? 0 : coveredDistance;
          double climedFlight =
              (data['flight_climed'] as num?)?.toDouble() ?? 0.0;
          flightClimed.value = climedFlight < 0 ? 0 : climedFlight;

          if (kDebugMode) {
            print("Distance Remaining from API: $remainingDistance");
            print("Distance Covered from API: ${distanceCovered.value}");
            print("Flight Climbed from API: ${flightClimed.value}");
            print("Final Distance value: ${distance.value}");
          }
        }
      }

      // Continue recursion even if paused, to keep syncing with backend
      Future.delayed(Duration(seconds: 5), updateLocationRecursively);
    } catch (e) {
      if (kDebugMode) {
        print('Update Location Error: $e');
      }
      Future.delayed(Duration(seconds: 5), updateLocationRecursively);
    }
  }

  Future<void> pauseRunning() async {
    // Update local state immediately for responsive UI
    isPaused.value = true;
    if (kDebugMode) {
      print('Local isPaused set to true');
    }

    try {
      final token = await _getToken();
      if (token == null) {
        if (kDebugMode) {
          print('No token found');
        }
        // Revert local state if token is missing
        isPaused.value = false;
        return;
      }

      final response = await http.post(
        Uri.parse(
          '${Urls.baseUrl}/running/startRunOrChangeStatus?status=pause',
        ),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      if (kDebugMode) {
        print('Pause Response: ${response.body}');
      }

      // Check backend response
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] != true) {
        // Revert local state if backend fails
        isPaused.value = false;
        if (kDebugMode) {
          print('Pause failed, reverting isPaused to false');
        }
      }
    } catch (e) {
      // Revert local state on error
      isPaused.value = false;
      if (kDebugMode) {
        print('Pause Error: $e, reverting isPaused to false');
      }
    }
  }

  Future<void> resumeRunning() async {
    // Update local state immediately for responsive UI
    isPaused.value = false;
    if (kDebugMode) {
      print('Local isPaused set to false');
    }

    try {
      final token = await _getToken();
      if (token == null) {
        if (kDebugMode) {
          print('No token found');
        }
        // Revert local state if token is missing
        isPaused.value = true;
        return;
      }

      final response = await http.post(
        Uri.parse(
          '${Urls.baseUrl}/running/startRunOrChangeStatus?status=resume&lon=${userLongitude.value}&lat=${userLatitude.value}',
        ),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      if (kDebugMode) {
        print('Resume Response: ${response.body}');
      }

      // Check backend response
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] != true) {
        // Revert local state if backend fails
        isPaused.value = true;
        if (kDebugMode) {
          print('Resume failed, reverting isPaused to true');
        }
      }
    } catch (e) {
      // Revert local state on error
      isPaused.value = true;
      if (kDebugMode) {
        print('Resume Error: $e, reverting isPaused to true');
      }
    }
  }

  Future<void> finish() async {
    EasyLoading.show(status: 'Loading...');
    try {
      final token = await _getToken();
      if (token == null) {
        if (kDebugMode) {
          print('No token found');
        }
        return;
      }

      final response = await http.post(
        Uri.parse(
          '${Urls.baseUrl}/running/startRunOrChangeStatus?status=finish',
        ),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );
      EasyLoading.showSuccess('Your run finish Successfully');
      Get.to(BottomNavbar());
      if (kDebugMode) {
        print('Finish Response: ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Finish Error: $e');
      }
    }
  }
}
