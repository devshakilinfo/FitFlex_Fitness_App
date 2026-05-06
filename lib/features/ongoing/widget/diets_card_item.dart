import 'package:flutter/material.dart';

import '../../../core/common/styles/global_text_style.dart';

class DietsCardItem extends StatelessWidget {
  final String assetName;
  final String mealPlanTitle;
  final int index; // Index to identify the specific meal plan

  // Constructor to accept dynamic parameters
  const DietsCardItem({
    super.key,
    required this.assetName,
    required this.mealPlanTitle,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(0, 87, 255, 0.10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(assetName), // Using the dynamic asset name
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mealPlanTitle, // Using the dynamic meal plan title
                    style: globalTextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff333333),
                    ),
                  ),

                  // Use GetX to listen to the favorite state and update UI
                  // GetX<DietsPlanController>(
                  //   builder: (controller) {
                  //     bool isFavorite = controller.favoriteStatus[index].value;
                  //     return IconButton(
                  //       onPressed: () {
                  //         // Toggle the favorite state
                  //         controller.favoriteStatus[index].value = !isFavorite;
                  //       },
                  //       icon: Icon(
                  //         isFavorite ? Icons.favorite : Icons.favorite_border,
                  //         color:
                  //             isFavorite
                  //                 ? AppColors.buttonBlueTextColor
                  //                 : Color(0xff333333),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
