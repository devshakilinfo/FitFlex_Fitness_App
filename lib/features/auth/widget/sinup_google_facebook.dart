import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';

class SinupGoogleFacebook extends StatelessWidget {
  final String logPath;
  final VoidCallback? onTab;

  const SinupGoogleFacebook({super.key, required this.logPath, this.onTab});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Adjust width, height, and padding based on screen size
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: screenHeight * 0.05, // Height as a percentage of screen height
        width: screenWidth * 0.2, // Width as a percentage of screen width
        padding: EdgeInsets.all(
          screenWidth * 0.02,
        ), // Padding as a percentage of screen width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.backdownColor,
        ),
        child: Image.asset(
          logPath,
          width: screenWidth * 0.1, // Adjust image width based on screen width
          height:
              screenHeight * 0.03, // Adjust image height based on screen height
        ),
      ),
    );
  }
}
