import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/ongoing/widget/custom_widget.dart' show InfoCardCustom;
import 'package:fit_flex3/features/run/controller/run_controller.dart' show TrackingController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RunLeaderboard extends StatelessWidget {
   RunLeaderboard({super.key});

  final TrackingController controller = Get.find<TrackingController>();

  @override
  Widget build(BuildContext context) {
    return Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => InfoCardCustom(
                          title: "Time Elapsed",
                          value:
                              controller.elapsedTime.value, // You might want to make this dynamic too
                          iconPath: IconPath.smalltime,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Obx(
                        () => InfoCardCustom(
                          title: "Distance Traversed",
                          value:
                              "${controller.distanceCovered.value.toStringAsFixed(2)} m",
                          iconPath: IconPath.vector2,
                        ),
                      ),
                    ),
                  ],
                );
  }
}