import 'dart:convert';

import 'package:fit_flex3/core/endPoint/urls.dart' show Urls;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/share_screen/models/all_user_model.dart' show AllData, AllUser;
import 'package:fit_flex3/features/share_screen/models/current_run_model.dart' show CurrentRun, Data;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;

class SharePageController extends GetxController {
  var selectedIndexes = <int>[].obs;
  var profiledata = <Data>[].obs;
  var alluserdata = <AllData>[].obs;

  TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    getcurrentProfile();
    getalluser();
    super.onInit();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  // share friend list
  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }

  void selectAll(int totleItems) {
    selectedIndexes.clear();
    for (int i = 0; i < totleItems; i++) {
      selectedIndexes.add(i);
    }
  }

  void deselectAll() {
    selectedIndexes.clear();
  }

  //===============================================
  void generatePdf(BuildContext context) async {
    // Create a PDF document
    final pdf = pw.Document();
    final sharePageController = Get.find<SharePageController>();

    // Add a page to the document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Title
              pw.Container(
                padding: pw.EdgeInsets.symmetric(vertical: 10),
                child: pw.Text(
                  'Current Run Recap',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#0057FF'),
                  ),
                ),
              ),
              pw.Text(
                'See How You Did Today',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColor.fromHex('#0057FF'),
                ),
              ),
              pw.SizedBox(height: 20),

              // Distance Traveled
              _buildInfoRow(
                label: 'Distance Traveled',
                value:
                    '${sharePageController.profiledata.isEmpty ? "3.2 km" : (sharePageController.profiledata.last.runAttemptedId!.last.distanceCovered! / 1000).toStringAsFixed(2)} km',
                icon:
                    IconPath.distancelogo, // Replace with your actual icon path
              ),
              pw.SizedBox(height: 10),

              // Time Elapsed
              _buildInfoRow(
                label: 'Time Elapsed',
                value:
                    sharePageController.profiledata.isEmpty
                        ? "55:24 min"
                        : sharePageController
                            .profiledata
                            .last
                            .runAttemptedId!
                            .last
                            .timeDuration
                            .toString(),
                icon: IconPath.recaptime, // Replace with your actual icon path
              ),
              pw.SizedBox(height: 10),

              // Distance Remaining
              _buildInfoRow(
                label: 'Distance Remaining',
                value:
                    '${sharePageController.profiledata.isEmpty ? "3.2 km" : (sharePageController.profiledata.last.runAttemptedId!.last.distanceRemaining! / 1000).toStringAsFixed(2)} km',
                icon:
                    IconPath.stairsFrame, // Replace with your actual icon path
              ),
              pw.SizedBox(height: 10),

              // Leaderboard Position
              _buildInfoRow(
                label: 'Leaderboard Position',
                value:
                    '${sharePageController.profiledata.isEmpty ? "2nd" : sharePageController.profiledata.first.lbPosition}',
                icon: IconPath.leaderlogo, // Replace with your actual icon path
              ),
              pw.SizedBox(height: 20),

              // Message (if any)
              if (sharePageController.messageController.text.isNotEmpty)
                pw.Container(
                  padding: pw.EdgeInsets.symmetric(vertical: 10),
                  child: pw.Text(
                    'Message: ${sharePageController.messageController.text}',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontStyle: pw.FontStyle.italic,
                      color: PdfColor.fromHex('#555555'),
                    ),
                  ),
                ),

              // Footer (add some extra info or signature)
              pw.SizedBox(height: 20),
              pw.Container(
                padding: pw.EdgeInsets.all(10),
                color: PdfColor.fromHex('#F0F0F0'),
                child: pw.Text(
                  'FitFlex - Empowering Your Fitness Journey',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColor.fromHex('#888888'),
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );

    // ignore: unused_local_variable
    final file = await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _buildInfoRow({
    required String label,
    required String value,
    required String icon,
  }) {
    return pw.Row(
      children: [
        pw.SizedBox(width: 10),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('#333333'),
              ),
            ),
            pw.Text(
              value,
              style: pw.TextStyle(
                fontSize: 14,
                color: PdfColor.fromHex('#000000'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //===============================================

  Future<void> getcurrentProfile() async {
    try {
      EasyLoading.show(status: 'Fetching profile...');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');
      debugPrint('Fetched authentication token: $approvalToken');

      if (approvalToken == null) {
        EasyLoading.showError('Authentication token not found');
        debugPrint('Error: Authentication token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(Urls.getprofile),
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final CurrentRun fetchedData = CurrentRun.fromJson(jsonData);
        if (fetchedData.success == true) {
          profiledata.add(fetchedData.data!);
          debugPrint("Profile Data:=======${profiledata.first.age}");
        } else {
          EasyLoading.showError("No Data Found");
        }
      } else {
        debugPrint('Failed to load profile: ${response.statusCode}');
        EasyLoading.showError('Failed to load profile');
      }
    } catch (e) {
      debugPrint('Error: $e');
      EasyLoading.showError('An error occurred: ${e.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }

  //======================================================================================
  Future<void> getalluser() async {
    try {
      EasyLoading.show(status: 'Fetching profile...');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');
      debugPrint('Fetched authentication token: $approvalToken'); // Print token

      if (approvalToken == null) {
        EasyLoading.showError('Authentication token not found');
        debugPrint('Error: Authentication token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(Urls.getalluser),
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
      );

      debugPrint(
        'Response Status Code: ${response.statusCode}',
      ); // Print status code
      debugPrint('Response Body: ${response.body}'); // Print response body

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        debugPrint('Decoded JSON Data: $jsonData'); // Print decoded JSON data

        final AllUser fetchedData1 = AllUser.fromJson(jsonData);
        debugPrint(
          'Success flag: ${fetchedData1.success}',
        ); // Print success flag
        debugPrint('Fetched Data: ${fetchedData1.data}'); // Print fetched data

        if (fetchedData1.success == true) {
          // Add each item in the data list to the alluserdata list
          alluserdata.addAll(
            fetchedData1.data!,
          ); // Use addAll to add all items in the list
        } else {
          EasyLoading.showError("No Data Found");
        }
      } else {
        debugPrint('Failed to load profile: ${response.statusCode}');
        EasyLoading.showError('Failed to load profile');
      }
    } catch (e) {
      debugPrint('Error: $e'); // Print the error message
      EasyLoading.showError('An error occurred: ${e.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }

  //=====================================================================

  Future<void> sendShareData() async {
    String runAttemptedId =
        profiledata.isEmpty
            ? ''
            : profiledata.last.runAttemptedId!.last.sId ?? '';
    debugPrint('Run Attempted ID: $runAttemptedId');

    String message = messageController.text;
    debugPrint('Message: $message');

    List<String> selectedUserIds =
        selectedIndexes.map((index) => alluserdata[index].sId ?? '').toList();
    debugPrint('Selected User IDs: $selectedUserIds');

    Map<String, dynamic> requestData = {
      "receiverUserIds": selectedUserIds,
      "runAttemptedId": runAttemptedId,
      "message": message,
    };
    debugPrint('Request Data: $requestData');
    try {
      EasyLoading.show(status: 'Sending share data...');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('auth_token');
      debugPrint('Fetched authentication token: $approvalToken');

      if (approvalToken == null) {
        EasyLoading.showError('Authentication token not found');
        debugPrint('Error: Authentication token not found');
        return;
      }

      var response = await http.post(
        Uri.parse(Urls.sharehistory),
        headers: {
          'Authorization': approvalToken,
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Share history sent successfully!');
        debugPrint('Share history sent successfully!');
      } else {
        EasyLoading.showError(
          'Failed to send share history: ${response.statusCode}',
        );
        debugPrint('Failed to send share history: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.showError('Error occurred: $e');
      debugPrint('Error occurred: $e');
    } finally {
      EasyLoading.dismiss();
      debugPrint('Request completed');
    }
  }
}
