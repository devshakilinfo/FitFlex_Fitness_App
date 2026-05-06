import 'dart:convert';
import 'package:fit_flex3/core/endPoint/urls.dart';
import 'package:fit_flex3/features/statistic/model/graph_data_model.dart';
import 'package:fit_flex3/features/statistic/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StaticController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getHistory();
    // getThisWeek();
    fetchPersonalGrowthData();
  }

  var focusedButtonIndex = 0.obs;
  void changeButton(int index) {
    focusedButtonIndex.value = index;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  var historyModel = <Data>[].obs;
  //=====================================================================
  void getHistory() async {
    try {
      String? token = await getToken();
      if (token == null) {
        debugPrint('Token is missing');
        return;
      }
      EasyLoading.show(status: "Loading...");
      Map<String, String> headers = {'Authorization': token};
      debugPrint(token);
      final response = await http.get(
        Uri.parse(Urls.history),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final HistoryModel jsonData = HistoryModel.fromJson(decodedData);
        debugPrint("Body 1 ${response.body}");
        if (jsonData.success == true) {
          historyModel.clear();
          historyModel.addAll(jsonData.data!);
          List<dynamic> oneDistanceCoveredList = [];
          for (var data in historyModel) {
            oneDistanceCoveredList.add(data.distanceCovered ?? 0.0);
          }
          debugPrint("One Distance Covered List: $oneDistanceCoveredList");
          EasyLoading.dismiss();
        } else {
          EasyLoading.showError('No project data found');
          EasyLoading.dismiss();
        }
      }
    } catch (e) {
      EasyLoading.showError('error occurred: $e');
      EasyLoading.dismiss();
    }
  }

  var graphData = <GraphData>[].obs;
  var totalRuns = 0.obs;
  var totalDistance = 0.0.obs;
  var totalDuration = "".obs;
  var avgLBPosition = 0.obs;
  var daysOfWeek = <String>[].obs;
  var lbPositions = <int>[].obs;
  var dates = <String>[].obs;
  var distances = <double>[].obs;
  Future<void> fetchPersonalGrowthData() async {
    try {
      EasyLoading.show(status: 'Fetching personal growth data...');
      debugPrint('Starting the fetch process for personal growth data...');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');

      if (approvalToken == null) {
        EasyLoading.showError('Authentication token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(Urls.grothgraph),
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final graphResponse = GraphResponse.fromJson(jsonData);

        if (graphResponse.success) {
          if (graphResponse.graphData.isNotEmpty) {
            graphData.value = graphResponse.graphData;
            dates.value = graphData.map((e) => e.date).toList();
            distances.value = graphData.map((e) => e.distance).toList();
          }
          final metaData = graphResponse.meta;
          totalRuns.value = metaData.totalRuns;
          totalDistance.value = metaData.totalDistance;
          totalDuration.value = metaData.totalDuration;
          avgLBPosition.value = metaData.avgLbPosition;

          EasyLoading.showSuccess('Personal growth data fetched successfully!');
        } else {
          EasyLoading.showError(
            'Failed to fetch data: ${graphResponse.message}',
          );
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  //========================================================================================
  String getLBGrowthStatus() {
    if (graphData.length < 2) {
      return 'Equal'; // Not enough data to compare
    }

    // Get present and previous entries
    final present =
        graphData[graphData.length - 1]; // Last entry (e.g., April 11)
    final previous =
        graphData[graphData.length - 2]; // Second-to-last (e.g., April 10)

    // Handle null LB_position values
    final presentLB = present.lbPosition;
    final previousLB = previous.lbPosition;

    if (presentLB == null && previousLB == null) {
      return 'Equal'; // Both null, no change
    } else if (presentLB == null) {
      return 'Negative'; // Present null, previous not null (drop in ranking)
    } else if (previousLB == null) {
      return 'Positive'; // Previous null, present not null (improvement)
    } else if (presentLB < previousLB) {
      return 'Positive'; // Lower position number is better (e.g., 1 vs 2)
    } else if (presentLB > previousLB) {
      return 'Negative'; // Higher position number is worse (e.g., 3 vs 2)
    } else {
      return 'Equal'; // Same position
    }
  }
}
