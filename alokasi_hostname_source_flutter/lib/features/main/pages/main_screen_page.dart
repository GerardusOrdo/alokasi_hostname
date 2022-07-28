import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/homepage_ploc.dart';

class MainScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePagePloc>(
      builder: (_) => Scaffold(
        // backgroundColor: Colors.,
        appBar: AppBar(
          title: Text('Server (VM) Data'),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _.zoomDrawerController.toggle(),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
