import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:fit_flex3/features/leaderboard/controller/leaderboard_controller.dart'
    show LeaderboardController;
import 'package:fit_flex3/features/leaderboard/widget/area_widget.dart'
    show AreaWidget;
import 'package:fit_flex3/features/leaderboard/widget/leaderboard_list_widget.dart'
    show LeaderBoardList;
import 'package:fit_flex3/features/leaderboard/widget/social_widget.dart'
    show SocialWidget;
import 'package:fit_flex3/features/leaderboard/widget/stack_position_widget.dart'
    show StackPositionWidget;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});
  LeaderboardController leaderboardController = Get.put(
    LeaderboardController(),
  );

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
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Leaderboard",
                style: globalTextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Container(
                height: screenHeight * 0.08,
                width: screenWidth * 0.8,
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffffffff),
                  border: Border.all(width: 1, color: AppColors.textColor1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        leaderboardController.changeButton(0);
                      },
                      child: SocialWidget(
                        leaderboardController: leaderboardController,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.001),
                    VerticalDivider(
                      width: 1,
                      color: AppColors.textColor1,
                      thickness: 0.7,
                    ),
                    SizedBox(width: screenWidth * 0.001),
                    GestureDetector(
                      onTap: () {
                        leaderboardController.focusedButtonIndex(1);
                      },
                      child: AreaWidget(
                        leaderboardController: leaderboardController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.18),
            StackPositionWidget(),
            LeaderBoardList(),
          ],
        ),
      ),
    );
  }
}
