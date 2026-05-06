import 'package:dotted_border/dotted_border.dart';
import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/colors.dart' show AppColors;
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/core/utils/constants/image_path.dart' show ImagePath;
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:fit_flex3/features/ongoing/widget/custom_widget.dart'
    show CustomButton;
import 'package:fit_flex3/features/profile/controller/profile_controller.dart'
    show ProfileController;
import 'package:fit_flex3/features/profile/model/profile_model.dart'
    show UserProfile;
import 'package:fit_flex3/features/profile/widget/chang_pass_pop_up.dart';
import 'package:fit_flex3/features/profile/widget/custom_dropdown.dart';
import 'package:fit_flex3/features/profile/widget/custom_widget.dart'
    show CustomProfileTextField;
import 'package:fit_flex3/features/share_screen/widget/custom_header.dart'
    show CustomHeader;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(
      ProfileController(),
      permanent: true,
    );
    return Scaffold(
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
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: const Color(0xFF0057FF),
        onRefresh: () async {
          return profileController.onInit();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37),
            child: Column(
              children: [
                const SizedBox(height: 24),
                const CustomHeader(title: "Profile"),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(ImagePath.profileimage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Personal Info:',
                      style: globalTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                    Obx(() {
                      return InkWell(
                        onTap: () async {
                          if (profileController.isEditing.value) {
                            UserProfile updatedUserProfile = UserProfile(
                              id: 'user-id',
                              name: profileController.userNameController.text,
                              email: profileController.emailController.text,
                              lbPosition: 1,
                              totalDistanceCrossed: 100,
                              age: int.tryParse(
                                profileController.ageController.text,
                              ),
                              gender:
                              profileController.genderController.text.isEmpty
                                  ? null
                                  : profileController.genderController.text,
                              height: double.tryParse(
                                profileController.heightController.text,
                              ),
                              weight: double.tryParse(
                                profileController.weightController.text,
                              ),
                              residenceArea:
                              profileController.residencyAreaController.text,
                            );

                            bool success = await profileController.updateProfile(
                              updatedUserProfile,
                            );

                            if (success) {
                              profileController.toggleEditing();
                            }
                          } else {
                            profileController.toggleEditing();
                          }
                        },
                        child: Row(
                          children: [
                            if (!profileController.isEditing.value)
                              Image.asset(
                                IconPath.editprofileicon,
                                width: 18,
                                height: 18,
                              ),
                            if (profileController.isEditing.value)
                              Text(
                                'Save',
                                style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor1,
                                ),
                              ),
                            const SizedBox(width: 5),
                            if (!profileController.isEditing.value)
                              Text(
                                'Edit',
                                style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor1,
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffffffff),
                    border: Border.all(width: 1, color: const Color(0xffB3BAC5)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffDFE1E6).withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Obx(() {
                          return CustomProfileTextField(
                            label: 'User Name:',
                            controller: profileController.userNameController,
                            hintText: 'Not Set',
                            enabled: profileController.isEditing.value,
                          );
                        }),
                        Obx(() {
                          return CustomProfileTextField(
                            label: "Age",
                            controller: profileController.ageController,
                            hintText: "Not Set",
                            enabled: profileController.isEditing.value,
                          );
                        }),
                        SizedBox(height: 10),
                        Obx(() {
                          if (profileController.isEditing.value) {
                            return CustomProfileDropdown(
                              label: "Gender",
                              controller: profileController.genderController,
                              hintText: "Select Gender",
                              enabled: true,
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gender",
                                  style: globalTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    profileController
                                        .genderController
                                        .text
                                        .isEmpty
                                        ? "Not set"
                                        : profileController
                                        .genderController
                                        .text
                                        .capitalizeFirst!,
                                    style: globalTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor1,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                        DottedBorder(
                          color: Colors.blue,
                          strokeWidth: 1,
                          dashPattern: [4, 2],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(0),
                          padding: EdgeInsets.zero,
                          customPath:
                              (size) =>
                          Path()
                            ..moveTo(0, size.height)
                            ..lineTo(size.width, size.height),
                          child: Container(),
                        ),
                        Obx(() {
                          return CustomProfileTextField(
                            label: "Height",
                            controller: profileController.heightController,
                            hintText: "Not Set",
                            enabled: profileController.isEditing.value,
                          );
                        }),
                        Obx(() {
                          return CustomProfileTextField(
                            label: "Weight",
                            controller: profileController.weightController,
                            hintText: "Not Set",
                            enabled: profileController.isEditing.value,
                          );
                        }),
                        Obx(() {
                          return CustomProfileTextField(
                            label: "Residency Area",
                            controller: profileController.residencyAreaController,
                            hintText: "Not Set",
                            enabled: profileController.isEditing.value,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    profileController.toggleExpanded();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Account Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Obx(() {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 800),
                            transitionBuilder: (
                                Widget child,
                                Animation<double> animation,
                                ) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Image.asset(
                              profileController.isExpanded.value
                                  ? IconPath.arrowdown
                                  : IconPath.arrowright,
                              width: 24,
                              height: 24,
                              key: ValueKey<bool>(
                                profileController.isExpanded.value,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Obx(() {
                  if (profileController.isExpanded.value) {
                    return ChangePasswordPopUp(
                      profileController: profileController,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD80017), Color(0xFFFF394F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      profileController.logout();
                    },
                    child: Text(
                      'Log Out',
                      style: globalTextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.zero,
                          titlePadding: EdgeInsets.zero,
                          title: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF394F),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Confirm Deletion',
                                  style: globalTextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Color(0xFFFF394F),
                                  size: 40,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Are you sure you want to delete your account?',
                                  textAlign: TextAlign.center,
                                  style: globalTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'This action cannot be undone.',
                                  textAlign: TextAlign.center,
                                  style: globalTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.close, color: Colors.grey, size: 18),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Cancel',
                                    style: globalTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                profileController.selfDestructAccount();
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFFF394F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.delete, color: Colors.white, size: 18),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Delete',
                                    style: globalTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CustomButton(
                    text: "Delete My Account",
                    backgroundColor: const Color(0xff5A5C5F),
                    textStyle: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}