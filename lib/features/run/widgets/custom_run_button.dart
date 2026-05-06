import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class CustomRunButton extends StatelessWidget {
  final VoidCallback ontap; 
  final String text; 
  const CustomRunButton({super.key,
    required this.ontap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff0057FF), 
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12), 
          child: Center(
            child: Text(text, 
              style:globalTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),),
          )
        ),
      ),
    );
  }
}