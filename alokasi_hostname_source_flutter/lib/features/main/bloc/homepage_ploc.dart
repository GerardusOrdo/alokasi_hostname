import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../../core/helper/helper.dart';
import 'main_menu_item.dart';

class HomePagePloc extends GetxController {
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  // GetStorage box;
  List<MenuItem> mainMenu = [];

  void onInit() {
    zoomDrawerController = ZoomDrawerController();
    mainMenu = [
      MenuItem("Server", Icons.payment, 0,
          () => onMenuSelected(GetRouteOf.serverRoute)),
      MenuItem("Owner", Icons.payment, 1,
          () => onMenuSelected(GetRouteOf.ownerRoute)),
      MenuItem("Email Schedule", Icons.payment, 2,
          () => onMenuSelected(GetRouteOf.emailScheduleRoute)),
    ];
    super.onInit();
    // box = GetStorage();
  }

  void onMenuSelected(String route) {
    zoomDrawerController.close();
    Get.toNamed(route);
  }
}
