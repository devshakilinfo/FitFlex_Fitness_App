import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/home/controller/home_controller.dart'
    show HomeController;
import 'package:fit_flex3/features/home/screen/diets_plan_screen.dart'
    show DietsPlanScreen;
import 'package:fit_flex3/features/leaderboard/screen/leaderboard_screen.dart'
    show LeaderboardScreen;
import 'package:fit_flex3/features/medals/screen/medals_screen.dart'
    show MedalsScreen;
import 'package:fit_flex3/features/run_page/screen/run_screen.dart'
    show RunScreen;
import 'package:fit_flex3/features/share_screen/screen/share_screen.dart'
    show ShareScreen;
import 'package:fit_flex3/features/statistic/screen/statistic_screen.dart'
    show StatisticScreen;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/text.dart' show GradientText;

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IconPath.logo1, height: 22, width: 22),
            SizedBox(width: 8),
            GradientText(
              text: 'FitFlex',
              gradient: LinearGradient(
                colors: [Color(0xFF0057FF), Color(0xFF3B7EFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              'Choose your Goal',
              style: globalTextStyle(
                color: Color(0xFF333333),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 19,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.30,
                ),
                itemCount: homeController.gridItems.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    bool isSelected =
                        homeController.selectedIndex.value == index;
                    return GestureDetector(
                      onTap: () {
                        homeController.selectIndex(index);
                        switch (index) {
                          case 0:
                            Get.to(RunScreen());
                            break;
                          case 1:
                            Get.to(StatisticScreen());
                            break;
                          case 2:
                            Get.to(
                              () => DietsPlanScreen(),
                              transition: Transition.rightToLeft,
                            );
                            break;
                          case 3:
                            Get.to(LeaderboardScreen());
                            break;
                          case 4:
                            Get.to(MedalsScreen());
                            break;
                          case 5:
                            Get.to(ShareScreen());
                            break;
                          default:
                            Get.to(
                              () => Container(color: Colors.white),
                              transition: Transition.rightToLeft,
                            );
                            break;
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFD4D4D4)),
                          gradient:
                              isSelected
                                  ? LinearGradient(
                                    colors: [
                                      Color(0xff0057FF),
                                      Color(0xff3B7EFC),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                  : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              homeController.gridItems[index]['icon'],
                              height: 40,
                              width: 40,
                              color:
                                  isSelected ? Colors.white : Color(0xFF2A6AE8),
                            ),
                            SizedBox(height: 14),
                            Text(
                              homeController.gridItems[index]['label'],
                              style: globalTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    isSelected
                                        ? Colors.white
                                        : Color(0xFF2A6AE8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
