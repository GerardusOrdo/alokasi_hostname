import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../bloc/homepage_ploc.dart';
import 'main_screen_page.dart';
import 'menu_screen_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePagePloc>(
      // initState: (_) => Get.find<AuthPloc>().authenticate(),
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        mainScreen: MainScreenPage(),
        menuScreen: MenuScreenPage(),
        showShadow: true,
        backgroundColor: Colors.blue[200] ?? Colors.white,
        closeCurve: Curves.easeInOut,
        openCurve: Curves.easeOut,
        angle: 0.0,
        borderRadius: 50.0,
        slideWidth: 350.0,
      ),
    );
  }
}
