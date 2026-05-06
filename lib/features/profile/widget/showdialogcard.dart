import 'package:dotted_border/dotted_border.dart';
import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;

import 'package:flutter/material.dart';

class ShowDialogCard extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;


  const ShowDialogCard({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText, 
    
  }) ;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.blue,
      strokeWidth: 1,
      dashPattern: [4, 2],
      borderType: BorderType.RRect,
      radius: Radius.circular(0),
      padding: EdgeInsets.zero,
      customPath:
          (size) =>
              Path()
                ..moveTo(0, size.height)
                ..lineTo(size.width, size.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: globalTextStyle(
                fontSize: 14,
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              style: globalTextStyle(
                fontSize: 14,
                color: AppColors.textColor1,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: hintText,
                hintStyle: globalTextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
