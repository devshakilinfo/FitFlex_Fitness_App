import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/core/utils/constants/image_path.dart' show ImagePath;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/constants/icon_path.dart';
import '../../medals/genart_model.dart';
import '../controller/leaderboard_controller.dart';

class StackPositionWidget extends StatelessWidget {
  const StackPositionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final leaderboardController = Get.put(LeaderboardController());

    return Obx(() {
      List<GetLeaderBoard> data = leaderboardController.leaderboardData;

      if (data.isEmpty) {
        return Text('Loading...');
      }

      return Stack(
        clipBehavior: Clip.none,
        children: [
          if (data.isNotEmpty)
            Positioned(
              top: screenHeight * -0.16,
              right: screenWidth * 0.42,
              child: CircleAvatar(
                radius: screenWidth * 0.07,
                backgroundImage:
                    data[0].img == null
                        ? AssetImage(IconPath.sharefemale)
                        : NetworkImage(data[0].img!),
              ),
            ),
          if (data.isNotEmpty)
            Positioned(
              top: screenHeight * -0.088,
              right: screenWidth * 0.37,
              child: Text(
                data[0].name ?? 'Person 1',
                style: globalTextStyle(
                  fontSize: screenHeight < 620 ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (data.isNotEmpty)
            Positioned(
              top: screenHeight * -0.057,
              right: screenWidth * 0.38,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.textColor1, AppColors.containerColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Obx(() {
                    return Text(
                      leaderboardController.convertToKilometers(
                        data[0].totalDistanceCrossed,
                        decimalPlaces: 0,
                      ),

                      style: globalTextStyle(
                        color: AppColors.primaryBackground,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                ),
              ),
            ),
          if (data.length > 1)
            Positioned(
              top: screenHeight * -0.12,
              left: screenWidth * 0.13,
              child: CircleAvatar(
                radius: screenWidth * 0.07,
                backgroundImage:
                    data[1].img == null
                        ? AssetImage(IconPath.sharefemale)
                        : NetworkImage(data[1].img!),
              ),
            ),
          if (data.length > 1)
            Positioned(
              top: screenHeight * -0.05,
              left: screenWidth * 0.13,
              child: Text(
                data[1].name ?? 'Person 2',
                style: globalTextStyle(
                  fontSize: screenHeight < 620 ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (data.length > 1)
            Positioned(
              top: screenHeight * -0.015,
              left: screenWidth * 0.11,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.textColor1, AppColors.containerColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    // '${data[1].totalDistanceCrossed} Km',
                    leaderboardController.convertToKilometers(
                      data[1].totalDistanceCrossed,
                      decimalPlaces: 0,
                    ),
                    style: globalTextStyle(
                      color: AppColors.primaryBackground,
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

          // Position for Person 3
          if (data.length > 2)
            Positioned(
              top: screenHeight * -0.085,
              right: screenWidth * 0.14,
              child: CircleAvatar(
                radius: screenWidth * 0.07,
                backgroundImage:
                    data[2].img == null
                        ? AssetImage(IconPath.sharefemale)
                        : NetworkImage(data[2].img!),
              ),
            ),
          if (data.length > 2)
            Positioned(
              top: screenHeight * -0.013,
              right: screenWidth * 0.08,
              child: Text(
                data[2].name ?? 'Person 3',
                style: globalTextStyle(
                  fontSize: screenHeight < 620 ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (data.length > 2)
            Positioned(
              top: screenHeight * 0.02,
              right: screenWidth * 0.11,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.textColor1, AppColors.containerColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    leaderboardController.convertToKilometers(
                      data[2].totalDistanceCrossed,
                      decimalPlaces: 0,
                    ),
                    style: globalTextStyle(
                      color: AppColors.primaryBackground,
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

          Image.asset(ImagePath.leaderScore),

          // Position for ranks
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.15,
            child: Text(
              '2',
              style: globalTextStyle(
                fontSize: screenWidth * 0.16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBackground,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.015,
            left: screenWidth * 0.43,
            child: Text(
              '1',
              style: globalTextStyle(
                fontSize: screenWidth * 0.2,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBackground,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.073,
            left: screenWidth * 0.70,
            child: Column(
              children: [
                Text(
                  '3',
                  style: globalTextStyle(
                    fontSize: screenWidth * 0.16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
