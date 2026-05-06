import 'package:flutter/material.dart';

import '../../../core/common/styles/global_text_style.dart';

class CustomTitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  const CustomTitleText({super.key, required this.text, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: globalTextStyle(fontWeight: FontWeight.w700, fontSize: fontSize),
    );
  }
}
