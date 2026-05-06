import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:fit_flex3/features/run_page/controller/run_controller.dart' show RunController;
import 'package:flutter/material.dart' show Colors, Icons;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SelectDistanceContainers extends StatelessWidget {
   SelectDistanceContainers({super.key});

  final RunController controller = Get.find<RunController>(); 
  
  

  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
                "Select Distance Goal: ",
                style: globalTextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(height: screenHeight * 0.013),
              Obx(
                () =>  Container(
                      height: screenWidth * 0.24,
                      width: screenWidth * 0.24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48),
                          border: Border.all(color: Color(0xFF0057FF), width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                Icons.directions_run,
                color: Color(0xff0057FF),
                size: screenWidth * 0.062,
                            ),
                            Text(
                '${controller.distance.value.toStringAsFixed(1)} km', // Use the observable value
                style: globalTextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0057FF),
                ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
              SizedBox(height: screenHeight * 0.018),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.decreaseDistance(); 
                    },
                    child: Container(
                      width: screenWidth * 0.09,
                      height: screenWidth * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Color(0xff0057FF), Color(0xff3B7EFC)],
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.027),
                  GestureDetector(
                    onTap: () {
                      controller.increaseDistance();
                    },
                    child: Container(
                      width: screenWidth * 0.09,
                      height: screenWidth * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Color(0xff0057FF), Color(0xff4B89FF)],
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}