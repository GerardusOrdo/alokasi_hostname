import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_appbar.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_bottom_navigation_bar.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_initial_widget.dart';
import '../bloc/email_schedule_ploc.dart';
import '../widgets/email_schedule_table_widget.dart';
import 'email_schedule_filter_page_tab.dart';

class EmailScheduleMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSchedulePloc>(
      // initState: (_) => Get.find<EmailSchedulePloc>().getEmailScheduleTableWidget(),
      builder: (_) => Scaffold(
        appBar: MasterPageAppBar(
          ploc: _,
          height: 70.0,
          filterPage: EmailScheduleFilterPageTab(),
        ),
        floatingActionButton: Container(),
        // MasterPageFABAddData(
        //   ploc: _,
        //   inputPage: EmailScheduleInputPageTab(),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: _.isDataFetchSuccess
              ? EmailScheduleTableWidget()
              : MasterPageInitialWidget(),
        ),
        backgroundColor: Colors.blue,
        bottomNavigationBar: MasterPageBottomNavigationBar(ploc: _),
      ),
    );
  }
}
