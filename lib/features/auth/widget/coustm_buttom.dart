import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final bool? isBorder; // Corrected spelling of isBoder to isBorder
  final double? fontSize;
  const CustomButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    this.textColor,
    this.buttonColor,
    this.onTap,
    this.isBorder,
    this.fontSize, // Corrected spelling here as well
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            border:
                isBorder == true
                    ? Border.all(
                      color: AppColors.buttonBlueTextColor,
                    ) // Apply border conditionally
                    : null,
            borderRadius: BorderRadius.circular(10),
            color: buttonColor ?? Colors.white, // Default button color
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize, // Responsive font size
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
