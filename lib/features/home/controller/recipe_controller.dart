import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController
        // ignore: deprecated_member_use
        with
        GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
