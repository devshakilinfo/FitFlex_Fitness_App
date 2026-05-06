import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/core/utils/constants/colors.dart';
import 'package:fit_flex3/core/utils/constants/icon_path.dart';
import 'package:fit_flex3/features/auth/foget_password/controllers/reset_password_controller.dart';
import 'package:fit_flex3/features/auth/screen/log_in_screen.dart';
import 'package:fit_flex3/features/auth/widget/coustm_buttom.dart';
import 'package:fit_flex3/features/home/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class VerifyAndSetPasswordScreen extends StatelessWidget {
  final String email;

  const VerifyAndSetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ResetPasswordController>(
     
      builder: (controller) {
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reset Password",
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Enter the 6-digit OTP sent to your email",
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: AppColors.listTileColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor: AppColors.buttonBlueTextColor,
                      inactiveColor: AppColors.listTileColor,
                      selectedColor: AppColors.buttonBlueTextColor,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                   
                  ),
                  SizedBox(height: screenHeight * 0.04),
                
              
                  CustomButton(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    text: "Submit",
                    buttonColor: AppColors.buttonBlueTextColor,
                    textColor: Colors.white,
                    onTap: (){}, 
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have account?",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.listTileColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => const LogInScreen());
                        },
                        child: Text(
                          "Sign in",
                          style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonBlueTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}