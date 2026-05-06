
// import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
// import 'package:fit_flex3/features/auth/screen/sing_up_screen.dart' show SignUpScreen;
// import 'package:fit_flex3/features/home/widget/text.dart' show GradientText;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../core/common/styles/global_text_style.dart';
// import '../../../core/utils/constants/colors.dart';
// import '../../../core/utils/validators/app_validator.dart';
// import '../../auth/widget/coustm_buttom.dart';
// import '../../navigationber/screen/navigation_ber.dart';
// import '../controller/forgot_password_controller.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ForgotPasswordController controller = Get.put(
//       ForgotPasswordController(),
//     );
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(IconPath.logo1, height: 22, width: 22),
//             SizedBox(width: 8),
//             GradientText(
//               text: 'FitFlex',
//               gradient: LinearGradient(
//                 colors: [Color(0xFF0057FF), Color(0xFF3B7EFC)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               style: GoogleFonts.montserrat(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Update new \npassword",
//                       textAlign: TextAlign.left,
//                       style: GoogleFonts.montserrat(
//                         fontSize: screenWidth * 0.07,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.04),
//                     Text(
//                       "Enter your email and new password to update password ",
//                       style: GoogleFonts.montserrat(
//                         fontSize: screenWidth * 0.035,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.03),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Email",
//                       style: GoogleFonts.montserrat(
//                         fontSize: screenWidth * 0.035,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.005),
//                     TextFormField(
//                       controller: controller.emailController,
//                       decoration: InputDecoration(
//                         hintText: 'Loisbecket@gmail.com',
//                         hintStyle: GoogleFonts.montserrat(fontSize: 14.0),
//                         contentPadding: EdgeInsets.only(left: 10.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                       ),
//                       validator: (value) => AppValidator.validateEmail(value),
//                     ),
//                     SizedBox(height: screenHeight * 0.02),

//                     Text(
//                       "New Password",
//                       style: GoogleFonts.montserrat(
//                         fontSize: screenWidth * 0.035,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.005),
//                     Obx(
//                       () => TextFormField(
//                         controller: controller.passwordController,
//                         obscureText: !controller.isPasswordVisible.value,

//                         decoration: InputDecoration(
//                           hintText: '******',
//                           hintStyle: GoogleFonts.montserrat(fontSize: 14.0),
//                           contentPadding: EdgeInsets.only(left: 10.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide(color: Colors.blue),
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               controller.isPasswordVisible.value
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               size: screenWidth * 0.045,
//                             ),
//                             onPressed: () {
//                               controller.isPasswordVisible.value =
//                                   !controller.isPasswordVisible.value;
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.02),

//                     Text(
//                       "Confirm Password",
//                       style: GoogleFonts.montserrat(
//                         fontSize: screenWidth * 0.035,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.005),
//                     Obx(
//                       () => TextFormField(
//                         controller: controller.confirmPasswordController,
//                         obscureText: !controller.isConfirmPasswordVisible.value,
//                         decoration: InputDecoration(
//                           hintText: '******',
//                           hintStyle: GoogleFonts.montserrat(fontSize: 14.0),
//                           contentPadding: EdgeInsets.only(left: 10.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide(color: Colors.blue),
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               controller.isConfirmPasswordVisible.value
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               size: screenWidth * 0.045,
//                             ),
//                             onPressed: () {
//                               controller.isConfirmPasswordVisible.value =
//                                   !controller.isConfirmPasswordVisible.value;
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: screenHeight * 0.02),

//                 SizedBox(
//                   width: double.infinity,
//                   child: CustomButton(
//                     width: screenWidth * 0.4,
//                     height: screenHeight * 0.06,
//                     text: "Update Password",
//                     buttonColor: AppColors.buttonBlueTextColor,
//                     textColor: Colors.white,
//                     onTap: () {
//                       Get.to(BottomNavbar());
//                     },
//                   ),
//                 ),

//                 SizedBox(height: screenHeight * 0.02),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Don’t have an account?',
//                       style: TextStyle(fontSize: screenWidth * 0.035),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(SignUpScreen());
//                       },
//                       child: Text(
//                         "Sign Up",
//                         style: globalTextStyle(
//                           fontSize: screenWidth * 0.035,
//                           color: AppColors.buttonBlueTextColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
