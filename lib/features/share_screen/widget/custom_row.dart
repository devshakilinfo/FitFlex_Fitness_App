import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class DistanceInfoRow extends StatelessWidget {
  final String distanceLogoPath;
  final String distance;
  final String label;

  const DistanceInfoRow({
    super.key,
    required this.distanceLogoPath,
    required this.distance,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(
          distanceLogoPath,
          height: screenHeight * 0.04,
          width: screenWidth * 0.1,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.listTileColor,
                      ),
                    ),
                    Text(
                      distance,
                      style: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff0057FF),
                      ),
                    ),
                  ],
                ),
              ),
              DottedBorder(
                color: Colors.blue,
                strokeWidth: 0.5,
                dashPattern: [2, 2],
                borderType: BorderType.RRect,
                radius: Radius.circular(0),
                padding: EdgeInsets.zero,
                customPath:
                    (size) =>
                        Path()
                          ..moveTo(0, size.height)
                          ..lineTo(size.width, size.height),
                child: SizedBox(width: double.infinity, height: 0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
