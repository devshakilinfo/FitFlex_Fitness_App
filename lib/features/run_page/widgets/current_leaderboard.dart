import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/features/run_page/controller/run_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CurrentLeaderboard extends StatelessWidget {
  CurrentLeaderboard({super.key});
  final RunController controller = Get.find<RunController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffffffff),
        border: Border.all(width: 1, color: Color(0xffB3BAC5)),
        boxShadow: [
          BoxShadow(
            color: Color(0xffDFE1E6),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Current Leaderboard Position",
                  style: globalTextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5A5C5F),
                  ),
                ),
                Spacer(),
                Obx(
                  () => Text(
                    "${controller.leaderBoardPosition.value?.data.position ?? 0}th",
                    style: globalTextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff0057FF),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Obx(
                  () => Text(
                    "Distance between ${controller.leaderBoardPosition.value?.data.nextPosition ?? 0}th:",
                    style: globalTextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff5A5C5F),
                    ),
                  ),
                ),

                Spacer(),
                Obx(
                  () => Text(
                    controller.convertToKilometers(
                      controller.leaderBoardPosition.value?.data.distanceToNext
                          .toString(),
                    ),
                    style: globalTextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff0057FF),
                    ),
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
