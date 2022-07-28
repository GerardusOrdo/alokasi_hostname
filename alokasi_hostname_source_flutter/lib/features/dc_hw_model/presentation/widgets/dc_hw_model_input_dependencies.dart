import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_hw_model_ploc.dart';

class DcHwModelInputDependencies extends StatelessWidget {
  const DcHwModelInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwModelPloc>(
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
              //   labelText: 'HwModel',
              //   onSuggestionSelected: (s) => _.inputHwModelTextSelected(s),
              //   onSuggestionCallback: (pattern) => _.debouncer.run(() {
              //         _.getInputHwModelSuggestionFromAPI(pattern);
              //       }),
              //   textEditingController: _.inputTextCtrl.hwModel,
              //   onButtonAddClick: () {},
              // ),
            ],
          ),
        );
      },
    );
  }
}
