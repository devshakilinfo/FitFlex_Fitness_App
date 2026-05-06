import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/image_path.dart';
import '../controller/favorites_controller.dart';
import '../screen/reciplen_card.dart';

class AllMealPlan extends StatelessWidget {
  const AllMealPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoriteController = Get.put(FavoritesController());

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              favoriteController.title.value,
              style: globalTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: const Color(0xff333333),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          favoriteController.isLoadingMealPlans.value
              ? const Center()
              : favoriteController.mealPlans.isEmpty
              ? const Center(child: Text('No meal plans available'))
              : GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8.0,
              childAspectRatio: 158 / 156,
            ),
            itemCount: favoriteController.mealPlans.length,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, index) {
              final meal = favoriteController.mealPlans[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => ReciplenCard(allMealModels: meal));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(0, 87, 255, 0.10),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: meal.image != null &&
                                  meal.image!.isNotEmpty
                                  ? CachedNetworkImageProvider(
                                  meal.image!)
                                  : const AssetImage(
                                ImagePath.foodImage,
                              ) as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                meal.title ?? "Unnamed Meal",
                                overflow: TextOverflow.ellipsis,
                                style: globalTextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff333333),
                                  fontSize: MediaQuery.of(context)
                                      .size
                                      .width >
                                      600
                                      ? 16
                                      : 14,
                                ),
                              ),
                            ),
                            Obx(() {
                              // Ensure isIconSeleted has enough length
                              if (index >=
                                  favoriteController
                                      .isIconSeleted.length) {
                                return const SizedBox.shrink();
                              }
                              return IconButton(
                                onPressed: () async {
                                  final mealId = meal.sId?.toString();
                                  if (mealId != null &&
                                      mealId.isNotEmpty) {
                                    debugPrint(
                                        "Toggling favorite for meal ID: $mealId");
                                    await favoriteController
                                        .toggleFavoriteMeal(
                                        index, mealId);
                                  } else {
                                    debugPrint("Invalid meal ID");
                                    Get.snackbar(
                                      "Error",
                                      "Invalid meal ID",
                                      snackPosition:
                                      SnackPosition.BOTTOM,
                                    );
                                  }
                                },
                                icon: Icon(
                                  favoriteController
                                      .isIconSeleted[index]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: favoriteController
                                      .isIconSeleted[index]
                                      ? AppColors.buttonBlueTextColor
                                      : AppColors.textColor,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}