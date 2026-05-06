import 'package:fit_flex3/core/common/styles/global_text_style.dart'
    show globalTextStyle;
import 'package:fit_flex3/core/utils/constants/image_path.dart' show ImagePath;
import 'package:fit_flex3/features/auth/screen/log_in_screen.dart'
    show LogInScreen;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/auth_utils.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/icon_path.dart';
import '../../home/widget/text.dart' show GradientText;
import '../controller/login_controller.dart';
import '../controller/sinup_controller.dart';
import '../widget/coustm_buttom.dart';
import '../widget/sinup_google_facebook.dart' show SinupGoogleFacebook;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());
    final LoginController loginController = Get.put(
      LoginController(),
      permanent: true,
    );
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Function to validate fields before registration
    void validateAndRegister() {
      final email = controller.emailController.text.trim();
      final password = controller.passwordController.text.trim();
      final retypePassword = controller.retypePasswordController.text.trim();

      // Check for empty fields
      if (email.isEmpty || password.isEmpty || retypePassword.isEmpty) {
        EasyLoading.showError('Please fill in all fields.');
        return;
      }

      // Validate inputs using AuthUtils (which uses AppValidator)
      final emailError = AuthUtils.validateEmail(email);
      final passwordError = AuthUtils.validatePassword(password);
      final passwordMatchError = AuthUtils.validatePasswordMatch(
        password,
        retypePassword,
      );

      if (emailError != null) {
        EasyLoading.showError(emailError);
        return;
      }

      if (passwordError != null) {
        EasyLoading.showError(passwordError);
        return;
      }

      if (passwordMatchError != null) {
        EasyLoading.showError(passwordMatchError);
        return;
      }

      if (!controller.isTermsAccepted.value) {
        EasyLoading.showError('Please accept the terms & policy.');
        return;
      }

      // If validation passes, proceed with registration
      controller.register();
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
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign up",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  InkWell(
                    child: Text(
                      "Login",
                      style: globalTextStyle(
                        fontSize: 12.0,
                        color: AppColors.buttonBlueTextColor,
                      ),
                    ),
                    onTap: () {
                      Get.to(const LogInScreen());
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                "Email",
                style: GoogleFonts.montserrat(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.montserrat(fontSize: 14.0),
                  contentPadding: const EdgeInsets.only(left: 10.0),
                  hintText: 'Loisbecket@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  errorStyle: const TextStyle(fontSize: 12),
                ),
                validator: AuthUtils.validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Password",
                style: GoogleFonts.montserrat(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.montserrat(fontSize: 14.0,
                        color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    errorStyle: const TextStyle(fontSize: 12),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: screenWidth * 0.045,
                      ),
                      onPressed: () {
                        controller.isPasswordVisible.value =
                            !controller.isPasswordVisible.value;
                      },
                    ),
                  ),
                  validator: AuthUtils.validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Retype Password",
                style: GoogleFonts.montserrat(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Obx(
                () => TextFormField(
                  controller: controller.retypePasswordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    hintText: 'Re-type Password',
                    hintStyle: GoogleFonts.montserrat(fontSize: 14.0,
                        color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    errorStyle: const TextStyle(fontSize: 12),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: screenWidth * 0.045,
                      ),
                      onPressed: () {
                        controller.isPasswordVisible.value =
                            !controller.isPasswordVisible.value;
                      },
                    ),
                  ),
                  validator:
                      (value) => AuthUtils.validatePasswordMatch(
                        controller.passwordController.text,
                        value,
                      ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isTermsAccepted.value,
                      onChanged: (value) {
                        controller.isTermsAccepted.value = value!;
                      },
                    ),
                  ),
                  Text(
                    "I agree to the ",
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "terms & policy.",
                    style: globalTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.buttonBlueTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  width: screenWidth * 0.9,
                  // Aligned with login screen
                  height: screenHeight * 0.06,
                  text: "Register",
                  buttonColor: AppColors.buttonBlueTextColor,
                  textColor: Colors.white,
                  onTap: validateAndRegister,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Center(child: Text("or sign up with")),
              SizedBox(height: screenHeight * 0.02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SinupGoogleFacebook(
                    logPath: ImagePath.googleLog,
                    onTab: () async {
                      await controller.signInWithGoogle();
                    },
                  ),
                  const SizedBox(width: 8.0),
                  SinupGoogleFacebook(
                    logPath: ImagePath.facebookLog,
                    onTab: () async {
                      await loginController.signInWithFacehook();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
