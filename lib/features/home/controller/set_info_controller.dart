
import 'package:fit_flex3/features/home/widget/custm_textfromfrield.dart' show CustomTextField;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/styles/global_text_style.dart';
import '../../../core/utils/constants/colors.dart';
import '../../auth/widget/coustm_buttom.dart';
import 'weight_range_controller.dart';

class SetInfoController extends GetxController {
  var isSelezcted = false.obs;

  // List of fitness levels
  final List<String> fitnessLevels = [
    'Underweight',
    'Normal',
    'Overweight',
    'Obese',
  ];

  var selectedFitnessLevel = Rx<String?>(null);

  void toggleSelection() {
    isSelezcted.value = !isSelezcted.value;
  }

  void updateFitnessLevel(String level) {
    selectedFitnessLevel.value = level;
  }
}

void showCustomAlertDialog(BuildContext context) {
  // final SetInfoController controller = Get.find();
  final WeightRangeController weightRangeController = Get.find();

  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(13),
          content: Container(
            height: 550,
            padding: EdgeInsets.all(24),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Want a personalized diet ?",
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.006),
                Text(
                  "Fill out this form and receive your very own meal plan",
                  style: globalTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                CustomTextField(
                  titleText: "Height",

                  hintText: 'Height (cm)',
                  onChanged: (value) {
                    // Update weight in the controller (using setter)
                    weightRangeController.height =
                        value; // Set weight as a string
                  },
                ),
                CustomTextField(
                  titleText: "Weight",
                  hintText: 'Weight (kg)',
                  onChanged: (value) {
                    // Update height in the controller (using setter)
                    weightRangeController.weight =
                        value; // Set height as a string
                  },
                ),
                // SizedBox(height: screenHeight * 0.06),
                Spacer(),

                Row(
                  children: [
                    CustomButton(
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.06,
                      text: "Submit",
                      buttonColor: AppColors.buttonBlueTextColor,
                      onTap: () async {
                        debugPrint("Form Submitted!");
                        await weightRangeController.updateWeightRange();
                        Get.back();
                      },
                    ),
                    SizedBox(width: 10.0),
                    CustomButton(
                      isBorder: true,
                      textColor: AppColors.buttonBlueTextColor,
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.06,
                      text: "Cancel",
                      buttonColor: Colors.white,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      );
    },
  );
}
