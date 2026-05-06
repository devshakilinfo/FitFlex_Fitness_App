import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/leaderboard/controller/leaderboard_controller.dart'
    show LeaderboardController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaderBoardList extends StatelessWidget {
  const LeaderBoardList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final leaderboardController = Get.put(LeaderboardController());
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffF2F7FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffCCDDFF), width: 1.5),
            ),
            child: Obx(() {
              return leaderboardController.leaderboardData.isEmpty
                  ? ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 16, left: 8, right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            border: Border.all(
                              color: Color(0xffDFE1E6),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: screenWidth * 0.03,
                                  backgroundColor: Color(0xFFCCDDFF),
                                  child: Text(
                                    "1",
                                    style: globalTextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor1,
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Container(
                                  height: 40,
                                  width: 2,
                                  color: Color(0xffCCDDFF),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                CircleAvatar(
                                  radius: screenWidth * 0.04,
                                  backgroundImage: AssetImage(
                                    IconPath.sharefemale,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  'Theresa N. Maki',
                                  style: globalTextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 40,
                                  width: 2,
                                  color: Color(0xffCCDDFF),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  '3478/M',
                                  style: globalTextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  : ListView.builder(
                    itemCount: leaderboardController.allData.length,
                    itemBuilder: (context, index) {
                      final data = leaderboardController.allData[index];

                      // Skip the entries with lBPosition 1, 2, or 3
                      if (data.lBPosition == "1" ||
                          data.lBPosition == "2" ||
                          data.lBPosition == "3") {
                        return SizedBox(); // Return nothing for these entries
                      } else {
                        // Render the card for all other positions
                        return Padding(
                          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              border: Border.all(
                                color: Color(0xffDFE1E6),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  // Position Avatar (show lBPosition for positions other than 1, 2, or 3)
                                  CircleAvatar(
                                    radius: screenWidth * 0.03,
                                    backgroundColor: Color(0xFFCCDDFF),
                                    child: Text(
                                      "${data.lBPosition}",
                                      style: globalTextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Container(
                                    height: 40,
                                    width: 2,
                                    color: Color(0xffCCDDFF),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  CircleAvatar(
                                    radius: screenWidth * 0.04,
                                    backgroundImage:
                                        data.img == null
                                            ? AssetImage(IconPath.sharefemale)
                                            : NetworkImage("${data.img}"),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Text(
                                    data.name?.isEmpty ?? true
                                        ? "N/A"
                                        : data.name ?? 'N/A',
                                    style: globalTextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 40,
                                    width: 2,
                                    color: Color(0xffCCDDFF),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),

                                  Text(
                                    leaderboardController.convertToKilometers(
                                      data.totalDistanceCrossed,
                                    ),
                                    style: globalTextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
            }),
          ),
        ),
      ),
    );
  }
}
