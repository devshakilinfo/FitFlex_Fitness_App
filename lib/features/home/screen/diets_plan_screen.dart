import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/home/controller/favorites_controller.dart'
    show FavoritesController;
import 'package:fit_flex3/features/home/widget/custm_set_info_button.dart'
    show CustmSetInfoButton;

import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
// import '../controller/diets_plan_controller.dart';
import '../controller/weight_range_controller.dart';
import '../widget/all_meal_plan.dart';
import '../widget/favorites_meal_plan.dart';
import '../widget/suggeste_meal_plan.dart';

class DietsPlanScreen extends StatelessWidget {
  DietsPlanScreen({super.key});

  final WeightRangeController weightRangeController = Get.put(
    WeightRangeController(),
  );
  final FavoritesController favoriteController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color:  Color(0xFF0057FF),
        onRefresh: ()async {
          favoriteController.onInit();
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustmSetInfoButton(screenWidth: screenWidth),
              SizedBox(height: 14.0),
              Expanded(
                child: ListView(
                  children: [
                    FavoritesMealPlan(),
                    SuggestedMealPlan(),
                    AllMealPlan(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
