import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_mounted_form_ploc.dart';

class DcMountedFormInputDependencies extends StatelessWidget {
  const DcMountedFormInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcMountedFormPloc>(
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
              //   labelText: 'MountedForm',
              //   onSuggestionSelected: (s) => _.inputMountedFormTextSelected(s),
              //   onSuggestionCallback: (pattern) => _.debouncer.run(() {
              //         _.getInputMountedFormSuggestionFromAPI(pattern);
              //       }),
              //   textEditingController: _.inputTextCtrl.mountedForm,
              //   onButtonAddClick: () {},
              // ),
            ],
          ),
        );
      },
    );
  }
}
