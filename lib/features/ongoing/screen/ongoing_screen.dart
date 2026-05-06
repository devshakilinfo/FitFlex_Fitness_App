import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:fit_flex3/features/ongoing/controller/controller.dart'
    show OngoingController;
import 'package:fit_flex3/features/ongoing/widget/custom_widget.dart'
    show CustomButton, InfoCardCustom;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OngoingScreen extends StatelessWidget {
  OngoingScreen({super.key});

  final OngoingController ongoingController = Get.put(OngoingController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingHorizontal = screenWidth * 0.08;

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
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.008),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Ongoing",
                  style: globalTextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: Obx(() {
                  // Calculate percentage (distanceCovered / finalDestination)
                  double progressPercent =
                      ongoingController.finalDestination.value > 0
                          ? (ongoingController.distanceCovered.value /
                              ongoingController.finalDestination.value)
                          : 0.0;
                  // Ensure percentage doesn't exceed 1.0
                  progressPercent = progressPercent.clamp(0.0, 1.0);

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: screenWidth * 0.29,
                        lineWidth: 10.0,
                        percent: progressPercent,
                        backgroundColor: Color(0xffCCDDFF),
                        progressColor: Color(0xff0057FF),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                      CircularPercentIndicator(
                        radius: screenWidth * 0.23,
                        lineWidth: 7,
                        percent: progressPercent,
                        backgroundColor: Color(0xffCCF2F5),
                        progressColor: Color(0xff00C0CE),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                      Image.asset(IconPath.vector2, width: 59, height: 80),
                    ],
                  );
                }),
              ),
              SizedBox(height: screenHeight * 0.068),
              Row(
                children: [
                  Expanded(
                    child: InfoCardCustom(
                      title: "Time Elapsed",
                      value:
                          "22:10:45", // You might want to make this dynamic too
                      iconPath: IconPath.smalltime,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.028),
                  Expanded(
                    child: Obx(
                      () => InfoCardCustom(
                        title: "Distance Traversed",
                        value:
                            "${ongoingController.distanceCovered.value.toStringAsFixed(0)}m",
                        iconPath: IconPath.vector2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Obx(
                () => Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffffffff),
                    border: Border.all(width: 1, color: Color(0xffB3BAC5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(IconPath.stairs, width: 16, height: 16),
                      SizedBox(width: 10),
                      Text(
                        "Flights Climbed",
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5A5C5F),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        ongoingController.flightClimed.value.toStringAsFixed(0),
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0057FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Obx(
                      () =>
                          ongoingController.isPaused.value
                              ? CustomButton(
                                onTap: () {
                                  ongoingController.resumeRunning();
                                },
                                text: "Resume Run",
                                backgroundColor: Color(0xff363739),
                                textStyle: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              )
                              : CustomButton(
                                onTap: () {
                                  ongoingController.pauseRunning();
                                },
                                text: "Pause Run",
                                backgroundColor: Color(0xff363739),
                                textStyle: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        ongoingController.finish();
                      },
                      text: "Finish Run",
                      backgroundColor: Color(0xffDF051C),
                      textStyle: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
