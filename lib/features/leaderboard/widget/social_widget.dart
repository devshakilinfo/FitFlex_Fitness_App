

import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/features/leaderboard/controller/leaderboard_controller.dart' show LeaderboardController;
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key, required this.leaderboardController});

  final LeaderboardController leaderboardController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.12,
          vertical: screenHeight * 0.015,
        ),
        decoration: BoxDecoration(
          gradient:
              leaderboardController.focusedButtonIndex.value == 0
                  ? LinearGradient(
                    colors: [AppColors.textColor1, Color(0xff3B7EFC)],
                  )
                  : null,
          color:
              leaderboardController.focusedButtonIndex.value == 1
                  ? Color(0xffF2F7FF)
                  : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Social',
            style: globalTextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
              color:
                  leaderboardController.focusedButtonIndex.value == 0
                      ? Colors.white
                      : AppColors.textColor1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }
}
