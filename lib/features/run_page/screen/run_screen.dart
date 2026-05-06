import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/core/utils/constants/icon_path.dart';
import 'package:fit_flex3/features/home/widget/text.dart';
import 'package:fit_flex3/features/run_page/controller/run_controller.dart';
import 'package:fit_flex3/features/run_page/widgets/current_leaderboard.dart';
import 'package:fit_flex3/features/run_page/widgets/previous_run_recap_container.dart';
import 'package:fit_flex3/features/run_page/widgets/select_distance_containers.dart';
import 'package:fit_flex3/features/share_screen/widget/custom_header.dart';
import 'package:fit_flex3/features/run/view/run_view.dart' show RunView;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RunScreen extends StatelessWidget {
  RunScreen({super.key});
  final RunController controller = Get.put(RunController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IconPath.logo1, height: 22, width: 22),
            SizedBox(width: screenWidth * 0.02),
            GradientText(
              text: 'FitFlex',
              gradient: LinearGradient(
                colors: [Color(0xFF0057FF), Color(0xFF3B7EFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              style: GoogleFonts.montserrat(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        backgroundColor:  Colors.white,
        color:  Color(0xFF0057FF),
        onRefresh: () async{ return controller.onInit(); },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.005),
                CustomHeader(title: "Run"),
                SizedBox(height: screenHeight * 0.02),
                PreviousRunRecapContainer(),
                SizedBox(height: screenHeight * 0.033),
                CurrentLeaderboard(),
                SizedBox(height: screenHeight * 0.035),
                SelectDistanceContainers(),
                SizedBox(height: screenHeight * 0.020),
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      debugPrint(
                        "/////The value is: ${controller.distance.value}",
                      );
                    }
                    Get.to(
                      // "/ongoingScreen",
                      // arguments: controller.distance.value.toStringAsFixed(1),
                     () => RunView(),
                     arguments: controller.distance.value.toStringAsFixed(1),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.25,
                    height: screenHeight * 0.05,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Color(0xff0057FF), Color(0xff3B7EFC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Start Run',
                          style: globalTextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
