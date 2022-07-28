import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_mounted_form_ploc.dart';
import '../widgets/dc_mounted_form_filter_additional.dart';
import '../widgets/dc_mounted_form_filter_basic.dart';
import '../widgets/dc_mounted_form_filter_dependencies.dart';

class DcMountedFormFilterPageTab extends StatefulWidget {
  @override
  _DcMountedFormFilterPageTabState createState() => _DcMountedFormFilterPageTabState();
}

class _DcMountedFormFilterPageTabState extends State<DcMountedFormFilterPageTab>
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
    return GetBuilder<DcMountedFormPloc>(
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
                        child: DcMountedFormFilterBasic(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: DcMountedFormFilterDependencies(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: DcMountedFormFilterAdditional(),
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
