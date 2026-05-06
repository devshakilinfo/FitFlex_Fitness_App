import 'package:fit_flex3/features/run/controller/run_controller.dart'
    show TrackingController;
import 'package:fit_flex3/features/run/widgets/custom_pause_resume_finish_button.dart';
import 'package:fit_flex3/features/run/widgets/custom_run_button.dart';
import 'package:fit_flex3/features/run/widgets/remaining_distance.dart' show RemainingDistance;
import 'package:fit_flex3/features/run/widgets/run_leaderboard.dart'
    show RunLeaderboard;
import 'package:fit_flex3/features/run/widgets/tracking_circle.dart'
    show TrackingCircle;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RunView extends StatelessWidget {
  RunView({super.key});

  final TrackingController controller = Get.put(TrackingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GPS Tracker')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              TrackingCircle(),
              SizedBox(height: 20),

              RunLeaderboard(),
              SizedBox(
                height: 20,
              ), 
              RemainingDistance(), 

              SizedBox(height: 40),
              Obx(() {
                if (!controller.isTracking.value) {
                  return CustomRunButton(
                    ontap: () {
                      controller.startTracking();
                    },
                    text: "Start",
                  );
                } else {
                  // Show Pause/Resume + Finish
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomPauseResumeFinishButton(
                        ontap: () {
                          if (controller.isPaused.value) {
                            controller.resumeTracking();
                          } else {
                            controller.pauseTracking();
                          }
                        },
                        text: controller.isPaused.value ? 'Resume' : 'Pause',
                      ),

                      CustomPauseResumeFinishButton(
                        buttonColor: Color(0xFFD80017),
                        ontap: () {
                          controller.finishTracking();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text('Run Summary'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Time: ${controller.elapsedTime.value}',
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Distance: ${controller.distanceCovered.value.toStringAsFixed(2)} meters',
                                    ),
                                  ],
                                ),
                                actions: [
                                  CustomRunButton(
                                    ontap: () {
                                      controller.sendRunData();
                                    },
                                    text: "Complete",
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        text: "Finish",
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
