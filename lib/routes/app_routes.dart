
import 'package:fit_flex3/features/auth/screen/sing_up_screen.dart' show SignUpScreen;
import 'package:fit_flex3/features/leaderboard/screen/leaderboard_screen.dart' show LeaderboardScreen;
import 'package:fit_flex3/features/ongoing/screen/ongoing_screen.dart' show OngoingScreen;
import 'package:fit_flex3/features/profile/screen/profile_screen.dart' show ProfileScreen;
import 'package:fit_flex3/features/run_page/screen/run_screen.dart' show RunScreen;
import 'package:fit_flex3/features/share_screen/screen/share_screen.dart' show ShareScreen;
import 'package:fit_flex3/features/statistic/screen/statistic_screen.dart' show StatisticScreen;
import 'package:get/get.dart';
import '../features/home/screen/diets_plan_screen.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';
import '../features/auth/screen/log_in_screen.dart' show LogInScreen;
import '../features/auth/screen/welcome_screen.dart' show WelcomeScreen;
import '../features/medals/screen/medals_screen.dart' show MedalsScreen;
import '../features/navigationber/screen/navigation_ber.dart' show BottomNavbar;
import '../features/home/screen/home_screen.dart' show HomeScreen;

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String welcomeScreen = '/welcomeScreen';
  static String sinupScreen = '/sinupScreen';
  static String dietsPlanScreen = '/DietsPlanScreen';
  static String bottomNavbar = "/bottomNavbar";
  static String homeScreen = "/homeScreen";
  static String medalsScreen = "/medalsScreen";
  static String singUpScreen = "/singUpScreen";
  static String runScreen = "/runScreen";
  static String shareScreen = "/shareScreen";
  static String profileScreen = "/profileScreen";
  static String statisticScreen = "/statisticScreen";
  static String ongoingScreen = "/ongoingScreen";
  static String leaderboardScreen = "/leaderboardScreen";

  static String getLoginScreen() => loginScreen;
  static String getWelcomeScreen() => welcomeScreen;
  static String getsinupeScreen() => sinupScreen;
  static String getDietsPlanScreen() => dietsPlanScreen;
  static String getBottomNavbar() => bottomNavbar;
  static String getHomeScreen() => homeScreen;
  static String getMedalsScreen() => medalsScreen;
  static String getSingUpScreen() => singUpScreen;
  static String getRunScreen() => runScreen;
  static String getShareScreen() => shareScreen;
  static String getProfileScreen() => profileScreen;
  static String getStatisticScreen() => statisticScreen;
  static String getOngoingScreen() => ongoingScreen;
  static String getLeaderboardScreen() => leaderboardScreen;

  static List<GetPage> routes = [
    GetPage(name: bottomNavbar, page: () => BottomNavbar()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: medalsScreen, page: () => MedalsScreen()),
    GetPage(name: loginScreen, page: () => LogInScreen()),
    GetPage(name: welcomeScreen, page: () => WelcomeScreen()),
    GetPage(name: welcomeScreen, page: () => SignUpScreen()),
    GetPage(name: welcomeScreen, page: () => DietsPlanScreen()),
    GetPage(name: runScreen, page: () => RunScreen()),
    GetPage(name: shareScreen, page: () => ShareScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: statisticScreen, page: () => StatisticScreen()),
    GetPage(name: ongoingScreen, page: () => OngoingScreen()),
    GetPage(name: leaderboardScreen, page: () => LeaderboardScreen()),
  ];
}
