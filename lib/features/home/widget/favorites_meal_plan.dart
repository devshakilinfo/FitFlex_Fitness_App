import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/image_path.dart';
import '../controller/favorites_controller.dart';
import '../screen/reciplen_card.dart';

class FavoritesMealPlan extends StatelessWidget {
  const FavoritesMealPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoriteController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show GridView or empty state message
        Obx(() {
          if (favoriteController.getFavoriteModel.isEmpty) {
            return SizedBox(height: 0);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show title "Favorites" only if there are favorite items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  favoriteController.favoriteTitle.value,
                  style: globalTextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: const Color(0xff333333),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 158 / 156,
                ),
                itemCount: favoriteController.getFavoriteModel.length,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemBuilder: (context, index) {
                  final favoritesData =
                      favoriteController.getFavoriteModel[index];

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ReciplenCard(favoritesData: favoritesData));
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
                                  image:
                                      favoritesData.image != null &&
                                              favoritesData.image!.isNotEmpty
                                          ? CachedNetworkImageProvider(
                                            favoritesData.image!,
                                          )
                                          : const AssetImage(
                                                ImagePath.foodImage,
                                              )
                                              as ImageProvider,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    favoritesData.title ?? "Unnamed Meal",
                                    overflow: TextOverflow.ellipsis,
                                    style: globalTextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff333333),
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 16
                                              : 14,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final mealId =
                                        favoritesData.sId?.toString();
                                    if (mealId != null && mealId.isNotEmpty) {
                                      debugPrint("Removing meal ID: $mealId");
                                      favoriteController.removeFavoriteMeal(
                                        mealId: mealId,
                                      );
                                    } else {
                                      debugPrint('Invalid meal ID');
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: AppColors.buttonBlueTextColor,
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
            ],
          );
        }),
        const SizedBox(height: 14.0),
      ],
    );
  }
}
