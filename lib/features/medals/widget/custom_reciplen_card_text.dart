import 'package:flutter/material.dart';

import '../../../core/common/styles/global_text_style.dart';

class CustomReciplenCardText extends StatelessWidget {
  final String imagePath;
  final String text;

  const CustomReciplenCardText({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.028,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(width: screenWidth * 0.035),
          Expanded(
            child: Text(
              text,
              maxLines: 5,
              style: globalTextStyle(
                color: Color(0xff5A5C5F),
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
