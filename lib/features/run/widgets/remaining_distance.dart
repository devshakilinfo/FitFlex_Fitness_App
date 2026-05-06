import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/run/controller/run_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemainingDistance extends StatelessWidget {
  RemainingDistance({super.key});

  final TrackingController controller = Get.find<TrackingController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(
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
              "Remaining Distance",
              style: globalTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff5A5C5F),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "${controller.remainingDistance.value.toStringAsFixed(0)} m",
              style: globalTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff0057FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
