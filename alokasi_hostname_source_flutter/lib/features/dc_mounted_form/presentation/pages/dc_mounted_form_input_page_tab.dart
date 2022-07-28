import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../bloc/dc_mounted_form_ploc.dart';
import '../widgets/dc_mounted_form_input_additional.dart';
import '../widgets/dc_mounted_form_input_basic.dart';
import '../widgets/dc_mounted_form_input_dependencies.dart';

class DcMountedFormInputPageTab extends StatefulWidget {
  @override
  _DcMountedFormInputPageTabState createState() => _DcMountedFormInputPageTabState();
}

class _DcMountedFormInputPageTabState extends State<DcMountedFormInputPageTab>
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
              title: Text('Input ' + _.pageName),
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
                        child: DcMountedFormInputBasic(),
                      ),
                      SingleChildScrollView(
                          padding: EdgeInsets.all(25),
                          child: DcMountedFormInputDependencies()),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: DcMountedFormInputAdditional(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                      //   child: Visibility(
                      //     visible: controller.index > 0,
                      //     child: IconButton(
                      //         tooltip: 'Before',
                      //         icon: Icon(Icons.navigate_before),
                      //         onPressed: () {}),
                      //   ),
                      // ),
                      // RaisedButton(
                      //   padding: EdgeInsets.all(10),
                      //   color: Colors.green,
                      //   textColor: Colors.white,
                      //   onPressed: () => _.saveTabInput(
                      //       controller, EnumDataManipulation.insert),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text('Save'),
                      //       Icon(Icons.save),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 10, 50, 10),
                      //   child: Visibility(
                      //     visible: controller.index < 2,
                      //     child: IconButton(
                      //         tooltip: 'Next',
                      //         icon: Icon(Icons.navigate_next),
                      //         onPressed: () {}),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  _.saveTabInput(controller, EnumDataManipulation.insert),
              child: Icon(Icons.check),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
    );
  }
}
