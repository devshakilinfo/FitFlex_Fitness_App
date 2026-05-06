import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = (-1).obs;
  void selectIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Map<String, dynamic>> gridItems = [
    {'icon': IconPath.activerun, 'label': 'Run'},
    {'icon': IconPath.disablestatus, 'label': 'Stats'},
    {'icon': IconPath.disablediets, 'label': 'Diets'},
    {'icon': IconPath.disableleaderboard, 'label': 'Leaderboard'},
    {'icon': IconPath.disablemedal, 'label': 'Medal'},
    {'icon': IconPath.disableshare, 'label': 'Share'},
  ];
}
