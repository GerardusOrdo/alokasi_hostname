import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/email_schedule_ploc.dart';
import '../widgets/email_schedule_filter_additional.dart';
import '../widgets/email_schedule_filter_basic.dart';
import '../widgets/email_schedule_filter_dependencies.dart';

class EmailScheduleFilterPageTab extends StatefulWidget {
  @override
  _EmailScheduleFilterPageTabState createState() => _EmailScheduleFilterPageTabState();
}

class _EmailScheduleFilterPageTabState extends State<EmailScheduleFilterPageTab>
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
    return GetBuilder<EmailSchedulePloc>(
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
                        child: EmailScheduleFilterBasic(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: EmailScheduleFilterDependencies(),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: EmailScheduleFilterAdditional(),
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
