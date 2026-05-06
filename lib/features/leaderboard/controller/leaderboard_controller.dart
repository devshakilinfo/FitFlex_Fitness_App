import 'dart:convert';
import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../medals/genart_model.dart';

class LeaderboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchLeaderboardData();
  }

  var focusedButtonIndex = 0.obs;
  var leaderboardData = <GetLeaderBoard>[].obs;
  var allData = <GetLeaderBoard>[].obs;

  void changeButton(int index) {
    focusedButtonIndex.value = index;
  }

  // Fetch leaderboard data from the API
  void fetchLeaderboardData() async {
    try {
      final response = await http.get(Uri.parse(Urls.getLeaderBoard));

      // If the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Parse the response into a list of GetLeaderBoard objects
        List<GetLeaderBoard> parsedData = List<GetLeaderBoard>.from(
          jsonResponse['data'].map(
            (entryJson) => GetLeaderBoard.fromJson(entryJson),
          ),
        );

        // Store the full data in allData
        allData.value = parsedData;

        // Filter the data to include only leaderboard entries with lBPosition 1, 2, or 3
        leaderboardData.value =
            parsedData.where((entry) {
              return entry.lBPosition == "1" ||
                  entry.lBPosition == "2" ||
                  entry.lBPosition == "3";
            }).toList();

        // Optionally print the filtered data for debugging

        // ignore: avoid_print
        print('All Data: $allData');
        // ignore: avoid_print
        print('Filtered Data: $leaderboardData');
      } else {
        // Handle unsuccessful request
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error fetching leaderboard data: $e');
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
          return '${kilometers.toStringAsFixed(decimalPlaces)} Km'; // Format the number with the specified decimal places in Km
        } else {
          return '${meters.toStringAsFixed(decimalPlaces)} M'; // Return the value in meters
        }
      } catch (e) {
        // Handle the case where parsing fails (e.g., if the value is not a valid number)
        return 'Invalid data';
      }
    } else {
      // Return fallback if totalDistanceCrossed is null or empty
      return '3478/M';
    }
  }
}
