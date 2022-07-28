import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_room_ploc.dart';
import '../widgets/dc_room_filter_additional.dart';
import '../widgets/dc_room_filter_basic.dart';
import '../widgets/dc_room_filter_dependencies.dart';

class DcRoomFilterPageTab extends StatefulWidget {
  @override
  _DcRoomFilterPageTabState createState() => _DcRoomFilterPageTabState();
}

class _DcRoomFilterPageTabState extends State<DcRoomFilterPageTab>
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
    return GetBuilder<DcRoomPloc>(
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
                        child: DcRoomFilterBasic(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: DcRoomFilterDependencies(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: DcRoomFilterAdditional(),
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
