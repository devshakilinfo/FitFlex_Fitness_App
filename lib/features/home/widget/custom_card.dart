// import 'package:fit_flex/features/home/model/all_meal_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../core/common/styles/global_text_style.dart';
// import '../../../core/utils/constants/colors.dart';
// import '../screen/reciplen_card.dart';

// class CustomCard extends StatelessWidget {
//   final List<Map<String, String>> mealPlans;
//   final RxList<bool> selectedFavorites;
//   final Function(int) onToggleFavorite;
//   final int crossAxisCount;

//   const CustomCard({
//     super.key,
//     required this.mealPlans,
//     required this.selectedFavorites,
//     required this.onToggleFavorite,
//     required this.crossAxisCount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8.0,
//         childAspectRatio: 158 / 156,
//       ),
//       itemCount: 50,
//       padding: EdgeInsets.zero,
//       itemBuilder: (context, index) {
//         final mealPlan = mealPlans[index];
//         return GestureDetector(
//           onTap: () {
//             // Get.to(ReciplenCard(mealPlans: mealPlans,));
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Color.fromRGBO(0, 87, 255, 0.10),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage(mealPlan['image']!),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         mealPlan['title']!,
//                         style: globalTextStyle(
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff333333),
//                           fontSize:
//                               MediaQuery.of(context).size.width > 600 ? 16 : 14,
//                         ),
//                       ),
//                       Obx(() {
//                         return IconButton(
//                           onPressed: () {
//                             onToggleFavorite(index);
//                           },
//                           icon: Icon(
//                             selectedFavorites[index]
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             color:
//                                 selectedFavorites[index]
//                                     ? AppColors.buttonBlueTextColor
//                                     : Color(0xff333333),
//                           ),
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
