import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/owner_ploc.dart';
import '../widgets/owner_filter_additional.dart';
import '../widgets/owner_filter_basic.dart';
import '../widgets/owner_filter_dependencies.dart';

class OwnerFilterPageTab extends StatefulWidget {
  @override
  _OwnerFilterPageTabState createState() => _OwnerFilterPageTabState();
}

class _OwnerFilterPageTabState extends State<OwnerFilterPageTab>
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
    return GetBuilder<OwnerPloc>(
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
                        child: OwnerFilterBasic(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: OwnerFilterDependencies(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: OwnerFilterAdditional(),
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
