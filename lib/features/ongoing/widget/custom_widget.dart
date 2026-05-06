import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:flutter/material.dart';

class InfoCardCustom extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;

  const InfoCardCustom({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth = screenWidth * 0.30;
    double containerHeight = screenHeight * 0.13;

    double titleFontSize = screenWidth < 400 ? 12 : 14;
    double valueFontSize = screenWidth < 400 ? 14 : 16;
    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffffffff),
        border: Border.all(width: 1, color: Color(0xffB3BAC5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 16, height: 16),
          SizedBox(height: 8),
          Text(
            title,
            style: globalTextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w600,
              color: Color(0xff5A5C5F),
            ),
          ),
          Text(
            value,
            style: globalTextStyle(
              fontSize: valueFontSize,
              fontWeight: FontWeight.w600,
              color: Color(0xff0057FF),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final TextStyle textStyle;
  final void Function()? onTap;

  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
