
import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/core/utils/constants/image_path.dart' show ImagePath;
import 'package:fit_flex3/features/auth/screen/log_in_screen.dart' show LogInScreen;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/coustm_buttom.dart';
import 'sing_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Precache images to speed up the process
    precacheImage(AssetImage(ImagePath.vector), context);
    precacheImage(AssetImage(ImagePath.logo), context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImagePath.logo,
              fit: BoxFit.cover, // Ensures full-screen coverage
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              ImagePath.vector,
              fit: BoxFit.cover, // Ensures full-screen coverage
            ),
          ),
          // Two Buttons Positioned at Bottom
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.08),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        width: screenWidth * 0.4, // 90% of screen width
                        height: screenHeight * 0.06, // 6% of screen height
                        onTap: () {
                          Get.to(LogInScreen());
                        },
                        text: "Log In",
                        textColor: AppColors.buttonBlueTextColor,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomButton(
                        width: screenWidth * 0.4, // 90% of screen width
                        height: screenHeight * 0.06, // 6% of screen height
                        text: "Sign Up",
                        buttonColor: AppColors.buttonBlueTextColor,
                        onTap: () {
                          Get.to(SignUpScreen());
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        "The healthy winning cycle",
                        style: globalTextStyle(
                          color: Colors.white, // Adjust color if needed
                          fontSize: 14, // Responsive font size
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
