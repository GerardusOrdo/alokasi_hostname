import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_hw_type_ploc.dart';

class DcHwTypeInputDependencies extends StatelessWidget {
  const DcHwTypeInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwTypePloc>(
      builder: (_) {
        return Form(
          // key: _.formKeyInputDependencies,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: SizedBox(
                  child: Text('Dependencies'),
                  width: double.infinity,
                ),
                color: Colors.blue[50],
                height: 70.0,
                padding: EdgeInsets.all(20.0),
              ),
              // MasterPageDependenciesTypeAheadTextField(
              //   labelText: 'HwType',
              //   onSuggestionSelected: (s) => _.inputHwTypeTextSelected(s),
              //   onSuggestionCallback: (pattern) => _.debouncer.run(() {
              //         _.getInputHwTypeSuggestionFromAPI(pattern);
              //       }),
              //   textEditingController: _.inputTextCtrl.hwType,
              //   onButtonAddClick: () {},
              // ),
            ],
          ),
        );
      },
    );
  }
}
