import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/home/widget/custm_set_info_button.dart'
    show CustmSetInfoButton;
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/controller/favorites_controller.dart';
import '../../home/widget/favorites_meal_plan.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final favoritesController = Get.put(FavoritesController());

    Get.put(FavoritesController());

    double screenWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    int crossAxisCount =
        screenWidth > 600 ? 3 : 2; // Switch to 3 columns on larger screens

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustmSetInfoButton(screenWidth: screenWidth),
            SizedBox(height: 14.0),
            Expanded(child: ListView(children: [FavoritesMealPlan()])),
          ],
        ),
      ),
    );
  }
}
