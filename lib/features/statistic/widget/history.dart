
import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/statistic/controller/static_controller.dart' show StaticController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    StaticController staticController = Get.put(StaticController());

    String getRunType(DateTime dateTime) {
      int hour = dateTime.hour;
      if (hour >= 5 && hour < 12) {
        return "Morning Run";
      } else if (hour >= 12 && hour < 18) {
        return "Afternoon Run";
      } else {
        return "Evening Run";
      }
    }

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.9,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(color: AppColors.deviderColor, thickness: 1.4);
        },
        itemCount: staticController.historyModel.length,
        itemBuilder: (context, index) {
          var historyData = staticController.historyModel[index];

          var formattedDate =
              DateTime.parse(historyData.createdAt ?? "2025-04-07").toLocal();
          String formattedDateString =
              "${formattedDate.day}/${formattedDate.month}/${formattedDate.year}";

          String runType = getRunType(formattedDate);

          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 4),
            leading: Text(
              formattedDateString,
              style: globalTextStyle(
                color: AppColors.listTileColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),

            title: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              child: Text(
                runType,
                style: globalTextStyle(
                  color: AppColors.listTileColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    historyData.timeDuration ?? '0 hr 0 mins',
                    style: globalTextStyle(
                      color: AppColors.listTileColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        IconPath.iconperson,
                        height: 14,
                        width: 10,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 6),
                      Text(
                        historyData.distanceCovered != null
                            ? '${(historyData.distanceCovered! / 1000).toStringAsFixed(1)} KM' // Convert double to string and format it
                            : '0 KM',
                        style: globalTextStyle(
                          color: AppColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
