import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/run/controller/run_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart' show CircularPercentIndicator, CircularStrokeCap;

class TrackingCircle extends StatelessWidget {
   TrackingCircle({super.key});

  final TrackingController controller = Get.find<TrackingController>();

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    return Obx(() {
                var percent = ((controller.distanceCovered.value * 100)/controller.finalDestination.value)/100; 
                if (percent > 1) {
                  percent = 1;
                }
               return Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: screenWidth * 0.29,
                          lineWidth: 10.0,
                          percent: percent,
                          backgroundColor: Color(0xffCCDDFF),
                          progressColor: Color(0xff0057FF),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        CircularPercentIndicator(
                          radius: screenWidth * 0.23,
                          lineWidth: 7,
                          percent: percent,
                          backgroundColor: Color(0xffCCF2F5),
                          progressColor: Color(0xff00C0CE),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        Image.asset(IconPath.vector2, width: 59, height: 80),
                      ],
                    ); 
              });
  }
}