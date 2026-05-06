
import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:fit_flex3/features/share_screen/controller/share_page_controller.dart' show SharePageController;
import 'package:fit_flex3/features/share_screen/widget/custom_header.dart' show CustomHeader;
import 'package:fit_flex3/features/share_screen/widget/custom_row.dart' show DistanceInfoRow;
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareScreen extends StatelessWidget {
  ShareScreen({super.key});
  final SharePageController sharePageController = Get.put(
    SharePageController(),
  );

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IconPath.logo1, height: 22, width: 22),
            SizedBox(width: 8),
            GradientText(
              text: 'FitFlex',
              gradient: LinearGradient(
                colors: [Color(0xFF0057FF), Color(0xFF3B7EFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.01),
              CustomHeader(title: 'Share'),
              SizedBox(height: screenHeight * 0.025),
              Container(
                height: screenHeight * 0.36,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffffffff),
                  border: Border.all(width: 1, color: Color(0xffB3BAC5)),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Color(0xffDFE1E6).withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.022,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.02),
                          SizedBox(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.055,
                            child: Image.asset(IconPath.vector2),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Run Recap",
                                style: globalTextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff0057FF),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.001),
                              Text(
                                "See How You Did Today ",
                                style: globalTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff0057FF),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Obx(
                        () => DistanceInfoRow(
                          distanceLogoPath: IconPath.distancelogo,
                          distance:
                              sharePageController.profiledata.isEmpty
                                  ? "3.2 km"
                                  : "${(sharePageController.profiledata.last.runAttemptedId!.last.distanceCovered! / 1000).toStringAsFixed(2)} km ", // Convert to kilometers
                          label: "Distance Traveled",
                        ),
                      ),

                      SizedBox(height: 10),
                      Obx(
                        () => DistanceInfoRow(
                          distanceLogoPath: IconPath.recaptime,
                          distance:
                              sharePageController.profiledata.isEmpty
                                  ? "55:24 min"
                                  : "${(sharePageController.profiledata.last.runAttemptedId!.last.timeDuration.toString())} ",
                                 
                          label: "Time Elapsed",
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => DistanceInfoRow(
                          distanceLogoPath: IconPath.stairsFrame,
                          distance:
                              sharePageController.profiledata.isEmpty
                                  ? "3.2 km"
                                  : "${(sharePageController.profiledata.last.runAttemptedId!.last.distanceRemaining! / 1000).toStringAsFixed(2)} km ",
                          label: "Distance remaining",
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => DistanceInfoRow(
                          distanceLogoPath: IconPath.leaderlogo,
                          distance:
                              sharePageController.profiledata.isEmpty
                                  ? "2nd"
                                  : "${(sharePageController.profiledata.first.lbPosition)} ",
                          label: "Leaderboard Position ",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  // Call the function to generate the PDF when the button is pressed
                  sharePageController.generatePdf(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(IconPath.savelogo, width: 14, height: 14),
                    SizedBox(width: 8),
                    Text(
                      "Save as pdf/jpg",
                      style: globalTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              TextField(
                controller: sharePageController.messageController,
                textAlign: TextAlign.left,
                style: globalTextStyle(
                  fontSize: 14,
                  color: AppColors.textColor1,
                  fontWeight: FontWeight.w400,
                ),

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFCCDDFF), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFCCDDFF), width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFCCDDFF), width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFCCDDFF), width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFCCDDFF), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFCCDDFF), width: 1),
                  ),
                  hintText: "Say something......",
                  hintStyle: globalTextStyle(
                    fontSize: 12,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Share with",
                style: globalTextStyle(
                  fontSize: 14,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      sharePageController.selectAll(20);
                    },
                    child: Text(
                      "Select all",
                      style: globalTextStyle(
                        fontSize: 12,
                        color: AppColors.textColor1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.018),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                  reverse: true,
                  child: Obx(() {
                    // If alluserdata is empty, show EasyLoading
                    if (sharePageController.alluserdata.isEmpty) {
                      EasyLoading.show(
                        status: 'Loading...',
                      ); // Show loading indicator
                      return SizedBox.shrink(); // Return an empty widget while loading
                    } else {
                      EasyLoading.dismiss(); // Dismiss the loading indicator once data is available
                    }

                    return Row(
                      children: List.generate(
                        sharePageController.alluserdata.length,
                        (index) {
                          final user = sharePageController.alluserdata[index];
                          bool isSelected = sharePageController.selectedIndexes
                              .contains(index);
                          return GestureDetector(
                            onTap: () {
                              sharePageController.toggleSelection(index);
                              debugPrint('Index: $index, User ID: ${user.sId}');
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundImage: AssetImage(
                                      IconPath.sharemale,
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Image.asset(
                                        IconPath.selectedicon,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: screenHeight * 0.035),

              GestureDetector(
                onTap: () {
                  sharePageController.sendShareData();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Color(0xff0057FF), Color(0xff4B89FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Share now',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
