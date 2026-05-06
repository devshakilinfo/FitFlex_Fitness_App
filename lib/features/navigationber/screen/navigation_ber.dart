import 'package:fit_flex3/features/run_page/screen/run_screen.dart' show RunScreen;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../home/screen/home_screen.dart' show HomeScreen;
import '../../../core/utils/constants/icon_path.dart' show IconPath;
import '../../profile/screen/favorite_screen.dart';
import '../../profile/screen/profile_screen.dart' show ProfileScreen;
import '../controller/navigation_ber_controller.dart'
    show BottomNavbarController;

// ignore: must_be_immutable
class BottomNavbar extends StatelessWidget {
  BottomNavbar({super.key});

  String planName =
      Get.arguments != null ? Get.arguments as String : 'No plan selected';

  final BottomNavbarController controller = Get.put(BottomNavbarController());

  final List<Widget> pages = [
    HomeScreen(),
     Builder(builder: (_) => RunScreen()),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                passiveImage: IconPath.disablehome,
                activeImage: IconPath.activehome,
                text: 'Home',
                index: 0,
              ),
              _buildNavItem(
                passiveImage: IconPath.disableongoing,
                activeImage: IconPath.activeongoing,
                text: 'Ongoing',
                index: 1,
              ),
              _buildNavItem(
                passiveImage: IconPath.disablefavorite,
                activeImage: IconPath.activefavorite,
                text: 'Favorite',
                index: 2,
              ),
              _buildNavItem(
                passiveImage: IconPath.disableprofile,
                activeImage: IconPath.activeprofile,
                text: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required String text,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
        return SizedBox(
          height: 55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                isSelected ? activeImage : passiveImage,
                height: 24,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: GoogleFonts.inter(
                  color: isSelected ? Color(0xFF0057FF) : Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
