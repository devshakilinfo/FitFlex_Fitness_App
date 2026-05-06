// medals_screen.dart
import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/core/utils/constants/colors.dart';
import 'package:fit_flex3/core/utils/constants/icon_path.dart';
import 'package:fit_flex3/features/home/widget/text.dart';
import 'package:fit_flex3/features/medals/controller/medals_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MedalsScreen extends StatelessWidget {
  MedalsScreen({super.key});

  final MedalsController medalsController = Get.put(MedalsController());

  String getMedalCriteria(dynamic medal) {
    final domain = medal.domain as String?;
    if (domain == 'speed_Domain' && medal.maxTime != null) {
      return medal.maxTime!;
    } else if (domain == 'consistency_Domain' && medal.daysInRow != null) {
      return "${medal.daysInRow} Days";
    } else if (domain == 'totalDistance') {
      return "Leaderboard";
    } else if (domain == 'recordBreak_Domain') {
      return "Record";
    } else if (domain == 'distance_Domain' && medal.maxDistance != null) {
      return "${(medal.maxDistance / 1000).toStringAsFixed(2)} km";
    } else {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: const Color(0xFF0057FF),
      onRefresh: () async {
        medalsController.onInit();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Medals",
                    style: globalTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 80,
                  width: 320,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffffffff),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff0057FF),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => medalsController.toggleSelection(true),
                        child: Obx(() {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient:
                                  medalsController.isUnlockedSelected.value
                                      ? const LinearGradient(
                                        colors: [
                                          Color(0xff0057FF),
                                          Color(0xff3B7EFC),
                                        ],
                                      )
                                      : null,
                              color:
                                  !medalsController.isUnlockedSelected.value
                                      ? const Color(0xffF2F7FF)
                                      : null,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Achievement\nUnlocked",
                                style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      medalsController.isUnlockedSelected.value
                                          ? Colors.white
                                          : const Color(0xff333333),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }),
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: AppColors.textColor1,
                      ),
                      GestureDetector(
                        onTap: () => medalsController.toggleSelection(false),
                        child: Obx(() {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient:
                                  !medalsController.isUnlockedSelected.value
                                      ? const LinearGradient(
                                        colors: [
                                          Color(0xff0057FF),
                                          Color(0xff3B7EFC),
                                        ],
                                      )
                                      : null,
                              color:
                                  medalsController.isUnlockedSelected.value
                                      ? const Color(0xffF2F7FF)
                                      : null,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Achievement\nLocked",
                                style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      !medalsController.isUnlockedSelected.value
                                          ? Colors.white
                                          : const Color(0xff333333),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (medalsController.isUnlockedSelected.value) {
                    // Unlocked Medals Section
                    if (medalsController.profiledata.isEmpty) {
                      return const Center(
                        child: Text("No medals achieved yet"),
                      );
                    }

                    final medalAchieved =
                        medalsController.profiledata.first.medalAchieved;
                    if (medalAchieved == null || medalAchieved.isEmpty) {
                      return const Center(
                        child: Text("No medals achieved yet"),
                      );
                    }

                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 500,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xffF2F7FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Positioned(
                          top: 1,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            child: Image.asset(
                              IconPath.medalscontainerhead,
                              width: 360,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: double.infinity,
                              height: 450,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFCCDDFF),
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: medalAchieved.length,
                                        itemBuilder: (context, index) {
                                          final medal = medalAchieved[index];
                                          final medalId = medal.medalId;
                                          if (medalId == null) {
                                            return const SizedBox.shrink();
                                          }
                                          debugPrint(
                                            "Unlocked Medal $index: ID=${medalId.sId}, Title=${medalId.title}, Domain=${medalId.domain ?? 'null'}, Distance=${medalId.maxDistance ?? 'null'}, Time=${medalId.maxTime ?? 'null'}, Days=${medalId.daysInRow ?? 'null'}",
                                          );
                                          return Container(
                                            width: double.infinity,
                                            height: 50,
                                            margin: const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  medalId.isDeleted == true
                                                      ? Colors.grey[200]
                                                      : const Color(0xFFFFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: const Color(0xFFB3BAC5),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8.0,
                                                        ),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                            border: Border(
                                                              right: BorderSide(
                                                                color: Color(
                                                                  0xFFB3BAC5,
                                                                ),
                                                                width: 2,
                                                              ),
                                                            ),
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              right: 10.0,
                                                            ),
                                                        child:
                                                            medalId.img !=
                                                                        null &&
                                                                    medalId
                                                                        .img!
                                                                        .isNotEmpty
                                                                ? Image.network(
                                                                  medalId.img!,
                                                                  width: 20,
                                                                  height: 20,
                                                                  errorBuilder:
                                                                      (
                                                                        context,
                                                                        error,
                                                                        stackTrace,
                                                                      ) => const Icon(
                                                                        Icons
                                                                            .error,
                                                                      ),
                                                                )
                                                                : const Icon(
                                                                  Icons
                                                                      .image_not_supported,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      medalId.title ??
                                                          "Unknown Medal",
                                                      style: globalTextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            medalId.isDeleted ==
                                                                    true
                                                                ? Colors.grey
                                                                : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          left: 2,
                                                        ),
                                                    decoration:
                                                        const BoxDecoration(
                                                          border: Border(
                                                            left: BorderSide(
                                                              color: Color(
                                                                0xFFB3BAC5,
                                                              ),
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child: Text(
                                                        getMedalCriteria(
                                                          medalId,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalTextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              medalId.isDeleted ==
                                                                      true
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Locked Medals Section
                    if (medalsController.allMadels.isEmpty) {
                      return const Center(child: Text("Loading medals..."));
                    }

                    final achievedMedalIds =
                        (medalsController.profiledata.isNotEmpty &&
                                medalsController
                                        .profiledata
                                        .first
                                        .medalAchieved !=
                                    null)
                            ? medalsController.profiledata.first.medalAchieved!
                                .map((medal) => medal.medalId?.sId)
                                .where((id) => id != null)
                                .toSet()
                            : <String>{};

                    final lockedMedals =
                        medalsController.allMadels
                            .where(
                              (medal) => !achievedMedalIds.contains(medal.sId),
                            )
                            .toList();

                    if (lockedMedals.isEmpty) {
                      return const Center(
                        child: Text("All medals are achieved!"),
                      );
                    }

                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 500,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xffF2F7FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Positioned(
                          top: 1,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            child: Image.asset(
                              IconPath.medalscontainerhead,
                              width: 360,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: double.infinity,
                              height: 450,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFCCDDFF),
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: lockedMedals.length,
                                        itemBuilder: (context, index) {
                                          final medal = lockedMedals[index];
                                          debugPrint(
                                            "Locked Medal $index: ID=${medal.sId}, Title=${medal.title}, Domain=${medal.domain ?? 'null'}, Distance=${medal.maxDistance ?? 'null'}, Time=${medal.maxTime ?? 'null'}, Days=${medal.daysInRow ?? 'null'}",
                                          );
                                          return Container(
                                            width: double.infinity,
                                            height: 50,
                                            margin: const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  medal.isDeleted == true
                                                      ? Colors.grey[200]
                                                      : const Color(0xFFFFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: const Color(0xFFB3BAC5),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8.0,
                                                        ),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                            border: Border(
                                                              right: BorderSide(
                                                                color: Color(
                                                                  0xFFB3BAC5,
                                                                ),
                                                                width: 2,
                                                              ),
                                                            ),
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              right: 10.0,
                                                            ),
                                                        child:
                                                            medal.img != null &&
                                                                    medal
                                                                        .img!
                                                                        .isNotEmpty
                                                                ? Image.network(
                                                                  medal.img!,
                                                                  width: 20,
                                                                  height: 20,
                                                                  errorBuilder:
                                                                      (
                                                                        context,
                                                                        error,
                                                                        stackTrace,
                                                                      ) => const Icon(
                                                                        Icons
                                                                            .error,
                                                                      ),
                                                                )
                                                                : const Icon(
                                                                  Icons
                                                                      .image_not_supported,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      medal.title ??
                                                          "Unknown Medal",
                                                      style: globalTextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            medal.isDeleted ==
                                                                    true
                                                                ? Colors.grey
                                                                : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          left: 2,
                                                        ),
                                                    decoration:
                                                        const BoxDecoration(
                                                          border: Border(
                                                            left: BorderSide(
                                                              color: Color(
                                                                0xFFB3BAC5,
                                                              ),
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child: Text(
                                                        getMedalCriteria(medal),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: globalTextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              medal.isDeleted ==
                                                                      true
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
