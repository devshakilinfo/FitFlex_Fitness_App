import 'package:flutter/material.dart';
import '../../../core/common/styles/global_text_style.dart';

class CustmSetInfoButton extends StatelessWidget {
  const CustmSetInfoButton({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    // final SetInfoController controller = Get.put(SetInfoController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Diets",
          style: globalTextStyle(
            fontWeight: FontWeight.w700,
            fontSize: screenWidth > 600 ? 30 : 25,
          ),
        ),
      ],
    );
  }
}
