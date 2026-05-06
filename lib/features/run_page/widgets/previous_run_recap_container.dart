import 'package:dotted_border/dotted_border.dart';
import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/core/utils/constants/icon_path.dart';
import 'package:fit_flex3/features/run_page/controller/run_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviousRunRecapContainer extends StatelessWidget {
  PreviousRunRecapContainer({super.key});

  final RunController controller = Get.find<RunController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffffffff),
        border: Border.all(width: 1, color: const Color(0xffB3BAC5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffDFE1E6),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: screenWidth * 0.037),
                SizedBox(
                  height: screenHeight * 0.04,
                  width: screenWidth * 0.05,
                  child: Image.asset(IconPath.vector2),
                ),
                SizedBox(width: screenWidth * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Previous Run Recap",
                      style: globalTextStyle(
                        fontSize: screenWidth * 0.041,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff0057FF),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.003),
                    Text(
                      "See How You Did Last Time",
                      style: globalTextStyle(
                        fontSize: screenWidth * 0.031,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff0057FF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.035),

            // ------------------------
            // Distance Traveled Section
            // ------------------------
            Row(
              children: [
                Image.asset(
                  IconPath.distancelogo,
                  height: screenWidth * 0.08,
                  width: screenWidth * 0.08,
                ),
                SizedBox(width: screenWidth * 0.03),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Distance Traveled",
                              style: globalTextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff5A5C5F),
                              ),
                            ),
                            Obx(
                              () {
                                final previousRun = controller.previousRunData.value;
                                final runData = previousRun?.data.data;

                                if (runData == null) {
                                  return Text(
                                    "No Data",
                                    style: globalTextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff0057FF),
                                    ),
                                  );
                                }

                                return Text(
                                  controller.convertToKilometers(
                                    runData.distanceCovered.toString(),
                                  ),
                                  style: globalTextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff0057FF),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      DottedBorder(
                        color: Colors.blue,
                        strokeWidth: 0.5,
                        dashPattern: [2, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(0),
                        padding: EdgeInsets.zero,
                        customPath: (size) => Path()
                          ..moveTo(0, size.height)
                          ..lineTo(size.width, size.height),
                        child: const SizedBox(width: double.infinity, height: 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.022),

            // ------------------------
            // Time Taken Section
            // ------------------------
            Row(
              children: [
                Image.asset(
                  IconPath.recaptime,
                  height: screenWidth * 0.08,
                  width: screenWidth * 0.08,
                ),
                SizedBox(width: screenWidth * 0.03),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Time Taken",
                              style: globalTextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff5A5C5F),
                              ),
                            ),
                            Obx(
                              () {
                                final previousRun = controller.previousRunData.value;
                                final runData = previousRun?.data.data;

                                if (runData == null) {
                                  return Text(
                                    "No Data",
                                    style: globalTextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff0057FF),
                                    ),
                                  );
                                }

                                return Text(
                                  runData.timeDuration,
                                  style: globalTextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff0057FF),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      DottedBorder(
                        color: Colors.blue,
                        strokeWidth: 0.5,
                        dashPattern: [2, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(0),
                        padding: EdgeInsets.zero,
                        customPath: (size) => Path()
                          ..moveTo(0, size.height)
                          ..lineTo(size.width, size.height),
                        child: const SizedBox(width: double.infinity, height: 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
