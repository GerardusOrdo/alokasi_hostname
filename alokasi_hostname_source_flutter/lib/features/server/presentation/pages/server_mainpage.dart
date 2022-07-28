import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_appbar.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_bottom_navigation_bar.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_fab_add_data.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_initial_widget.dart';
import '../bloc/server_ploc.dart';
import '../widgets/server_table_widget.dart';
import 'server_filter_page_tab.dart';
import 'server_input_page_tab.dart';

class ServerMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerPloc>(
      // initState: (_) => Get.find<ServerPloc>().getServerTableWidget(),
      builder: (_) => Scaffold(
            appBar: MasterPageAppBar(
              ploc: _,
              height: 70.0,
              filterPage: ServerFilterPageTab(),
            ),
            floatingActionButton: MasterPageFABAddData(
              ploc: _,
              inputPage: ServerInputPageTab(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            body: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: _.isDataFetchSuccess
                  ? ServerTableWidget()
                  : MasterPageInitialWidget(),
            ),
            backgroundColor: Colors.blue,
            bottomNavigationBar: MasterPageBottomNavigationBar(ploc: _),
          ),
    );
  }
}
