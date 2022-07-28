import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_appbar.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_bottom_navigation_bar.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_fab_add_data.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_initial_widget.dart';
import '../bloc/dc_mounted_form_ploc.dart';
import '../widgets/dc_mounted_form_table_widget.dart';
import 'dc_mounted_form_filter_page_tab.dart';
import 'dc_mounted_form_input_page_tab.dart';

class DcMountedFormMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcMountedFormPloc>(
      // initState: (_) => Get.find<DcMountedFormPloc>().getDcMountedFormTableWidget(),
      builder: (_) => Scaffold(
            appBar: MasterPageAppBar(
              ploc: _,
              height: 70.0,
              filterPage: DcMountedFormFilterPageTab(),
            ),
            floatingActionButton: MasterPageFABAddData(
              ploc: _,
              inputPage: DcMountedFormInputPageTab(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            body: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: _.isDataFetchSuccess
                  ? DcMountedFormTableWidget()
                  : MasterPageInitialWidget(),
            ),
            backgroundColor: Colors.blue,
            bottomNavigationBar: MasterPageBottomNavigationBar(ploc: _),
          ),
    );
  }
}
