import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_appbar.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_bottom_navigation_bar.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_fab_add_data.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_initial_widget.dart';
import '../bloc/dc_hardware_ploc.dart';
import '../widgets/dc_hardware_table_widget.dart';
import 'dc_hardware_filter_page_tab.dart';
import 'dc_hardware_input_page_tab.dart';

class DcHardwareMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHardwarePloc>(
      // initState: (_) => Get.find<DcHardwarePloc>().getDcHardwareTableWidget(),
      builder: (_) => Scaffold(
            appBar: MasterPageAppBar(
              ploc: _,
              height: 70.0,
              filterPage: DcHardwareFilterPageTab(),
            ),
            floatingActionButton: MasterPageFABAddData(
              ploc: _,
              inputPage: DcHardwareInputPageTab(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            body: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: _.isDataFetchSuccess
                  ? DcHardwareTableWidget()
                  : MasterPageInitialWidget(),
            ),
            backgroundColor: Colors.blue,
            bottomNavigationBar: MasterPageBottomNavigationBar(ploc: _),
          ),
    );
  }
}
