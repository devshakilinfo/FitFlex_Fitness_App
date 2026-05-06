

import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class CustomPauseResumeFinishButton extends StatelessWidget {
  final String text; 
  final VoidCallback ontap;
  final Color? buttonColor;
  final Color? textColor;
  const CustomPauseResumeFinishButton({super.key,
  required this.ontap,
  required this.text,
  this.buttonColor = const Color(0xFF333333),
  this.textColor = Colors.white,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: buttonColor, 
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12), 
          child: Center(
            child: Text(
              text, 
              style: globalTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.white,
              ),
          ),
          ),
      ),
    ));
    
  }
}