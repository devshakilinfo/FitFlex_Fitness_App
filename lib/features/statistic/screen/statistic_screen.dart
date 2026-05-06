import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:fit_flex3/features/statistic/controller/static_controller.dart'
    show StaticController;
import 'package:fit_flex3/features/statistic/widget/history.dart' show History;
import 'package:fit_flex3/features/statistic/widget/this_week.dart'
    show ThisWeek;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/constants/icon_path.dart';

// ignore: must_be_immutable
class StatisticScreen extends StatelessWidget {
  StatisticScreen({super.key});
  StaticController staticController = Get.put(StaticController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFF0057FF),
        onRefresh: ()async { return staticController.onInit(); },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Statistic',
                      style: globalTextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => SizedBox(
                          height: screenHeight * 0.06,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color:
                                      staticController.focusedButtonIndex.value ==
                                              0
                                          ? AppColors.textColor1
                                          : Colors.black12,
                                ),
                                backgroundColor:
                                    staticController.focusedButtonIndex.value == 0
                                        ? AppColors.textColor1
                                        : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(),
                              ),
                              onPressed: () {
                                staticController.changeButton(0);
                              },
                              child: Text(
                                'This Week',
                                style: globalTextStyle(
                                  color:
                                      staticController.focusedButtonIndex.value ==
                                              0
                                          ? Colors.white
                                          : AppColors.textColor1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Obx(
                        () => SizedBox(
                          height: screenHeight * 0.06,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    staticController.focusedButtonIndex.value == 1
                                        ? AppColors.textColor1
                                        : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                side: BorderSide(
                                  color:
                                      staticController.focusedButtonIndex.value ==
                                              1
                                          ? AppColors.textColor1
                                          : Colors.black12,
                                ),
                                padding: const EdgeInsets.symmetric(),
                              ),
                              onPressed: () {
                                staticController.changeButton(1);
                              },
                              child: Text(
                                'History',
                                style: globalTextStyle(
                                  color:
                                      staticController.focusedButtonIndex.value ==
                                              1
                                          ? Colors.white
                                          : AppColors.textColor1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                Obx(() {
                  return staticController.focusedButtonIndex.value == 0
                      ? ThisWeek()
                      : History();
                }),
                SizedBox(height: screenHeight * 0.50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
