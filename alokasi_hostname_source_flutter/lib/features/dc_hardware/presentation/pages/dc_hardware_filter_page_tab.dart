import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_hardware_ploc.dart';
import '../widgets/dc_hardware_filter_additional.dart';
import '../widgets/dc_hardware_filter_basic.dart';
import '../widgets/dc_hardware_filter_dependencies.dart';

class DcHardwareFilterPageTab extends StatefulWidget {
  @override
  _DcHardwareFilterPageTabState createState() => _DcHardwareFilterPageTabState();
}

class _DcHardwareFilterPageTabState extends State<DcHardwareFilterPageTab>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHardwarePloc>(
      builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text('Filter ' + _.pageName),
              bottom: TabBar(
                controller: controller,
                tabs: [
                  Tab(
                    text: 'Basic',
                  ),
                  Tab(
                    text: 'Dependencies',
                  ),
                  Tab(
                    text: 'Additional',
                  ),
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: DcHardwareFilterBasic(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: DcHardwareFilterDependencies(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: DcHardwareFilterAdditional(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Get.back(),
              child: Icon(Icons.filter_list),
              tooltip: 'Filter',
              backgroundColor: Colors.pink,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
    );
  }
}
