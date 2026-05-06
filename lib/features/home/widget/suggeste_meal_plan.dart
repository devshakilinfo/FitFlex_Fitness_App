import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/common/styles/global_text_style.dart';
import '../../../core/utils/constants/image_path.dart';
import '../controller/favorites_controller.dart';
import '../screen/reciplen_card.dart';

class SuggestedMealPlan extends StatelessWidget {
  const SuggestedMealPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoriteController = Get.find();
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Only show the title if the suggested meals list is not empty
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              favoriteController.suggestMealPlans.value,
              style: globalTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: const Color(0xff333333),
              ),
            ),
          ),
          const SizedBox(height: 8.0),

          SizedBox(height: 8.0),

          GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8.0,
              childAspectRatio: 158 / 156,
            ),
            itemCount: favoriteController.getSuggestMealData.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final suggestMealData =
                  favoriteController.getSuggestMealData[index];
              // ignore: unused_local_variable

              return GestureDetector(
                onTap: () {
                  Get.to(ReciplenCard(suggestMealData: suggestMealData));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(0, 87, 255, 0.10),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  suggestMealData.image != null
                                      ? CachedNetworkImageProvider(
                                        suggestMealData.image ?? "",
                                      )
                                      : AssetImage(ImagePath.foodImage)
                                          as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                suggestMealData.title ?? "",
                                style: globalTextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff333333),
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 16
                                          : 14,
                                ),
                              ),
                            ),
                            Obx(
                              () => IconButton(
                                onPressed: () {
                                  // favoriteController.isToggleFavorite(
                                  //   index,
                                  // );
                                  final mealId =
                                      suggestMealData.sId?.toString();
                                  if (mealId != null && mealId.isNotEmpty) {
                                    debugPrint(suggestMealData.sId);
                                    favoriteController.postFavoriteMeal(
                                      mealId: mealId,
                                    );
                                    favoriteController.isTogglesuggestMealPlans(
                                      index,
                                    );
                                  } else {
                                    debugPrint('Invalid meal ID');
                                  }
                                },
                                icon: Icon(
                                  favoriteController
                                              .issuggestMealSeletedIndex
                                              .value ==
                                          index
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      favoriteController
                                                  .issuggestMealSeletedIndex
                                                  .value ==
                                              index
                                          ? AppColors.buttonBlueTextColor
                                          : AppColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 14.0),
        ],
      );
    });
  }
}
