import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/auth_utils.dart';
import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:fit_flex3/core/utils/constants/image_path.dart' show ImagePath;
import 'package:fit_flex3/features/auth/foget_password/screens/forgot_password_screen.dart';
import 'package:fit_flex3/features/auth/screen/sing_up_screen.dart'
    show SignUpScreen;
import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/constants/colors.dart';
import '../controller/login_controller.dart';
import '../widget/coustm_buttom.dart';
import '../widget/google_or_facbook_button.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController(), permanent: true);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Function to validate fields before login
    void validateAndLogin() {
      final email = loginController.emailController.text.trim();
      final password = loginController.passwordController.text.trim();

      // Check for empty fields
      if (email.isEmpty || password.isEmpty) {
        EasyLoading.showError('Please fill in both email and password fields.');
        return;
      }

      // Validate email using AuthUtils (which uses AppValidator)
      final emailError = AuthUtils.validateEmail(email);

      if (emailError != null) {
        EasyLoading.showError(emailError);
        return;
      }

      // No password validation; proceed with login if fields are not empty
      loginController.login();
    }

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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.015,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign in to your\nAccount",
                    style: globalTextStyle(
                      color: AppColors.textColor,
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Enter your email and password to log in",
                    style: globalTextStyle(
                      color: AppColors.listTileColor,
                      fontSize: screenWidth * 0.034,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: globalTextStyle(
                      color: AppColors.listTileColor,
                      fontSize: screenWidth * 0.034,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  TextFormField(
                    controller: loginController.emailController,
                    decoration: InputDecoration(
                      hintText: 'Loisbecket@gmail.com',
                      hintStyle: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
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
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Password",
                    style: globalTextStyle(
                      color: AppColors.listTileColor,
                      fontSize: screenWidth * 0.034,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Obx(
                        () => TextFormField(
                      controller: loginController.passwordController,
                      obscureText: !loginController.isPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            loginController.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: screenWidth * 0.042,
                          ),
                          onPressed: () {
                            loginController.isPasswordVisible.value =
                            !loginController.isPasswordVisible.value;
                          },
                        ),
                      ),
                      // No validator for password to avoid local validation
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.008),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.to( ForgotPasswordScreen());
                  },
                  child: Text(
                    "Forgot Password?",
                    style: globalTextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                      color: AppColors.buttonBlueTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.010),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.06,
                  text: "Login",
                  buttonColor: AppColors.buttonBlueTextColor,
                  textColor: Colors.white,
                  onTap: validateAndLogin,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 1,
                    width: screenWidth * 0.38,
                    color: AppColors.buttonBoderColor,
                  ),
                  Text(
                    'Or',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 1,
                    width: screenWidth * 0.38,
                    color: AppColors.buttonBoderColor,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () async {
                  await loginController.signInWithGoogle();
                },
                child: GoogleOrFacBookButton(
                  imageLog: ImagePath.googleLog,
                  text: "Continue with Google",
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              GestureDetector(
                onTap: () async {
                  await loginController.signInWithFacehook();
                },
                child: GoogleOrFacBookButton(
                  imageLog: ImagePath.facebookLog,
                  text: "Continue with Facebook",
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff5A5C5F),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const SignUpScreen());
                    },
                    child: Text(
                      "Sign Up",
                      style: globalTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonBlueTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}