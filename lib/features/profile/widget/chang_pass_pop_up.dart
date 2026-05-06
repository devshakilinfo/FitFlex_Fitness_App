import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/core/utils/constants/colors.dart';
import 'package:fit_flex3/features/profile/controller/profile_controller.dart';
import 'package:fit_flex3/features/profile/widget/custom_widget.dart';
import 'package:fit_flex3/features/profile/widget/showdialogcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPopUp extends StatelessWidget {
  const ChangePasswordPopUp({super.key, required this.profileController});

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize:  MainAxisSize.min,
        children: [
          CustomProfileTextField(
            label: "E-mail",
            controller: profileController.emailController,
            hintText:
            profileController.emailController.text.isNotEmpty
                ? profileController.emailController.text
                : "user@example.com",
            enabled: false,
          ),
          const SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Positioned(
                            bottom: Get.height * 0.2,
                            left: 0,
                            right: 0,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: AppColors.primaryBackground,
                              content: SizedBox(
                                width: double.infinity,
                                height: Get.height * 0.3,
                                child: Column(
                                  children: [
                                    ShowDialogCard(
                                      label: "Current Password",
                                      controller:
                                      profileController.currentPasswordController,
                                      hintText: "abcd123",
                                    ),
                                    ShowDialogCard(
                                      label: "New Password",
                                      controller:
                                      profileController.newPasswordController,
                                      hintText: "efgh456",
                                    ),
                                    ShowDialogCard(
                                      label: "Confirm Password",
                                      controller:
                                      profileController.confirmPasswordController,
                                      hintText: "efgh456",
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Expanded(
                                            child: Container(
                                              height: 45,
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFFD80017),
                                                    Color(0xFFFF394F),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                textAlign: TextAlign.center,
                                                style: globalTextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () async {
                                            await profileController.updatePassword(
                                              context,
                                            );
                                          },
                                          child: Expanded(
                                            child: Container(
                                              height: 45,
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xff0057FF),
                                                    Color(0xff4B89FF),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                              child: Text(
                                                'Change Password',
                                                textAlign: TextAlign.center,
                                                style: globalTextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Want to change password ? ",
                  style: globalTextStyle(
                    fontSize: 14,
                    color: const Color(0xff0057FF),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}