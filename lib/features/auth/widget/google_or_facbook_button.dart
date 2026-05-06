import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';

class GoogleOrFacBookButton extends StatelessWidget {
  final String imageLog;
  final String text;
  final VoidCallback? onTap;

  const GoogleOrFacBookButton({
    super.key,
    required this.imageLog,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonHeight = screenWidth * 0.12; // Responsive height
    final double imageSize = screenWidth * 0.04; // Responsive image size
    final double fontSize = screenWidth * 0.035; // Responsive text size

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: buttonHeight.clamp(45, 55), // Clamping to maintain usability
        width: screenWidth * 0.9, // 90% of screen width
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.buttonBoderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageLog,
                width: imageSize.clamp(12, 16),
              ), // Clamp for minimum/maximum size
              SizedBox(width: screenWidth * 0.03), // Responsive spacing
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize.clamp(
                    12,
                    16,
                  ), // Clamp to prevent extreme changes
                  fontWeight: FontWeight.w600,
                  color: Color(0xff050505),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
