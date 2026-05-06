import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/core/utils/constants/image_path.dart' show ImagePath;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../medals/widget/custom_reciplen_card_text.dart';
import '../controller/recipe_controller.dart';
import '../model/all_meal_model.dart';
import '../model/favorites_model.dart';
import '../model/suggest_meal_plans.dart';
import 'reciplen_card_edit_screen.dart';

class ReciplenCard extends StatelessWidget {
  final AllMealModels? allMealModels;
  final SuggestMealData? suggestMealData;
  final FavoritesData? favoritesData;

  const ReciplenCard({
    super.key,
    this.allMealModels,
    this.suggestMealData,
    this.favoritesData,
  });

  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.put(RecipeController());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight =
        screenHeight < 650 ? screenHeight * 0.70 : screenHeight * 0.57;

    // Check if `allMealModels`, `suggestMealData`, or `favoritesData` are null
    final mealData = allMealModels ?? suggestMealData ?? favoritesData;

    // If all models are null, show default text or placeholder content
    if (mealData == null) {
      return Scaffold(
        body: Center(
          child: Text("No meal data available", style: TextStyle(fontSize: 18)),
        ),
      );
    }

    // Use `allMealModels` if available, otherwise fallback to `suggestMealData` or `favoritesData`
    final image =
        allMealModels?.image ??
        suggestMealData?.image ??
        favoritesData?.image ??
        ImagePath.newFood;

    final title =
        allMealModels?.title ??
        suggestMealData?.title ??
        favoritesData?.title ??
        "Default Meal Title";

    final description =
        allMealModels?.description ??
        suggestMealData?.description ??
        favoritesData?.description ??
        "Default meal description";

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: containerHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        // Optimize memory usage by downscaling the image
                        memCacheHeight: (screenHeight * 0.3 * MediaQuery.of(context).devicePixelRatio).toInt(),
                        memCacheWidth: (screenWidth * MediaQuery.of(context).devicePixelRatio).toInt(),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(), // Show a loading indicator
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          ImagePath.newFood,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.05,
                      left: screenWidth * 0.04,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(IconPath.backIcon),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.05,
                      right: screenWidth * 0.04,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(ReciplenCardEditScreen());
                        },
                        child: Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(IconPath.editIcon),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.07,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the title or default title if null
                      Text(
                        title,
                        style: globalTextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight * 0.025,
                          color: Color(0xff333333),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        "Description",

                        style: globalTextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff5A5C5F),
                        ),
                      ),
                      // Display description or default description if null
                      Text(
                        maxLines: 3,
                        description,

                        style: globalTextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5A5C5F),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // TabBar and TabBarView
          Expanded(
            flex: 4,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: const Color(0xff689BFD),
                  indicatorWeight: 0.1,
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: controller.tabController,
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xff5A5C5F),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  labelStyle: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  tabs: const [
                    Tab(text: "Breakfast"),
                    Tab(text: "Lunch"),
                    Tab(text: "Dinner"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      // Breakfast Tab
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        itemCount:
                            allMealModels?.breakfast?.length ??
                            suggestMealData?.breakfast?.length ??
                            favoritesData?.breakfast?.length ??
                            0,
                        itemBuilder: (context, index) {
                          final data =
                              allMealModels?.breakfast?[index] ??
                              suggestMealData?.breakfast?[index] ??
                              favoritesData?.breakfast?[index];
                          return CustomReciplenCardText(
                            imagePath: ImagePath.right,
                            text: "$data",
                          );
                        },
                      ),
                      // Lunch Tab
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        itemCount:
                            allMealModels?.lunch?.length ??
                            suggestMealData?.lunch?.length ??
                            favoritesData?.lunch?.length ??
                            0,
                        itemBuilder: (context, index) {
                          final data =
                              allMealModels?.lunch?[index] ??
                              suggestMealData?.lunch?[index] ??
                              favoritesData?.lunch?[index];
                          return CustomReciplenCardText(
                            imagePath: ImagePath.right,
                            text: "$data",
                          );
                        },
                      ),
                      // Dinner Tab
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        itemCount:
                            allMealModels?.dinner?.length ??
                            suggestMealData?.dinner?.length ??
                            favoritesData?.dinner?.length ??
                            0,
                        itemBuilder: (context, index) {
                          final data =
                              allMealModels?.dinner?[index] ??
                              suggestMealData?.dinner?[index] ??
                              favoritesData?.dinner?[index];
                          return CustomReciplenCardText(
                            imagePath: ImagePath.right,
                            text: "$data",
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
