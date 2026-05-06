import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/core/utils/auth_utils.dart' show AuthUtils;
import 'package:fit_flex3/core/utils/constants/colors.dart';
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/features/auth/foget_password/controllers/forgot_password_controller.dart';
import 'package:fit_flex3/features/auth/screen/log_in_screen.dart';
import 'package:fit_flex3/features/auth/widget/coustm_buttom.dart';
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';




class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
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
                    "Your Email Address",
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "A 6 digit verification pin will be sent to your email address",
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: AppColors.listTileColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff050505),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color(0xffEDF1F3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color(0xffEDF1F3)),
                      ),
                      errorStyle: const TextStyle(fontSize: 12),
                    ),
                    validator: AuthUtils.validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  CustomButton(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    text: "Next",
                    buttonColor: AppColors.buttonBlueTextColor,
                    textColor: Colors.white,
                    onTap: (){
                      controller.sendOtp();
                    } 
                  ),
                  SizedBox(height: screenHeight * 0.03),
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
                          Get.off(() => const LogInScreen());
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