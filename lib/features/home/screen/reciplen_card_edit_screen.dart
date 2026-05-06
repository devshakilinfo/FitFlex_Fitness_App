import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/home/widget/custom_drop_down_button.dart';
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/constants/colors.dart';
import '../controller/reciplen_card_edit_controller.dart';

class ReciplenCardEditScreen extends StatelessWidget {
  const ReciplenCardEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReciplenCardEditController controller = Get.put(ReciplenCardEditController());

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLargeScreen = screenWidth > 600;
    double paddingValue = isLargeScreen ? 30.0 : 20.0;
    double textFieldPadding = isLargeScreen ? 15.0 : 10.0;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IconPath.logo1, height: 22, width: 22),
            const SizedBox(width: 8),
            GradientText(
              text: 'FitFlex',
              gradient: const LinearGradient(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
              onPressed: () {
                controller.createPlan();
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: AppColors.buttonBlueTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(paddingValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit your meal plan",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.004),
            Text(
              "Customize your meals to match your goals.",
              style: const TextStyle(
                color: Color(0xff5A5C5F),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(
              "Height Range",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.minimumController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                      ),
                      contentPadding: EdgeInsets.all(textFieldPadding),
                      labelText: "Minimum",
                      hintText: "150 cm",
                      hintStyle: const TextStyle(
                        color: Color(0xff5A5C5F),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xffBEBEBE),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                const Text(
                  "to",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5A5C5F),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: TextFormField(
                    controller: controller.maximumController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                      ),
                      contentPadding: EdgeInsets.all(textFieldPadding),
                      labelText: "Maximum",
                      hintText: "170 cm",
                      hintStyle: const TextStyle(
                        color: Color(0xff5A5C5F),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xffBEBEBE),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(
              "Weight Range",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.minWeightController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                      ),
                      contentPadding: EdgeInsets.all(textFieldPadding),
                      labelText: "Minimum",
                      hintText: "60 kg",
                      hintStyle: const TextStyle(
                        color: Color(0xff5A5C5F),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xffBEBEBE),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                const Text(
                  "to",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5A5C5F),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: TextFormField(
                    controller: controller.maxWeightController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                      ),
                      contentPadding: EdgeInsets.all(textFieldPadding),
                      labelText: "Maximum",
                      hintText: "90 kg",
                      hintStyle: const TextStyle(
                        color: Color(0xff5A5C5F),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xffBEBEBE),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(
              "Body Fitness Level",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Obx(() => CustomPopupDropdown(
              options: controller.fitnessLevels,
              selectedValue: controller.selectedFitnessLevel.value ?? '',
              onSelected: (value) {
                controller.updateFitnessLevel(value);
              },
            )),

            SizedBox(height: screenHeight * 0.025),
            Text(
              "Attachment",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Obx(() => Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffDFDFDF)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      controller.selectedImage.value == null
                          ? "No file chosen"
                          : controller.selectedImage.value!.path.split('/').last,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5A5C5F),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        controller.pickImage(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xffF1EFF4),
                        ),
                        child: Text(
                          "Choose File",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(height: screenHeight * 0.025),
            Text(
              "Food Title",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            TextFormField(
              controller: controller.foodTitleController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                contentPadding: EdgeInsets.all(textFieldPadding),
                hintText: "Enter meal plan title",
                hintStyle: const TextStyle(
                  color: Color(0xff5A5C5F),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.013),
            TextFormField(
              controller: controller.descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                  borderRadius: BorderRadius.circular(6),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffDFDFDF)),
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: EdgeInsets.all(textFieldPadding),
                hintText: "Enter meal plan description",
                hintStyle: const TextStyle(
                  color: Color(0xff5A5C5F),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            DefaultTabController(
              length: 4, // Increased to 4 for snacks
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: const Color(0xff689BFD),
                    indicatorWeight: 0.1,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: controller.tabController,
                    unselectedLabelStyle: const TextStyle(
                      color: Color(0xff5A5C5F),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    tabs: const [
                      Tab(text: "Breakfast"),
                      Tab(text: "Lunch"),
                      Tab(text: "Dinner"),
                      Tab(text: "Snacks"),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.30,
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        Obx(() => ListView(children: controller.breakfastFields)),
                        Obx(() => ListView(children: controller.lunchFields)),
                        Obx(() => ListView(children: controller.dinnerFields)),
                        Obx(() => ListView(children: controller.snacksFields)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}