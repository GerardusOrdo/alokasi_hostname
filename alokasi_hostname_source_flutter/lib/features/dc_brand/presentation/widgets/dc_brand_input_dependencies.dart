import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_brand_ploc.dart';

class DcBrandInputDependencies extends StatelessWidget {
  const DcBrandInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcBrandPloc>(
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
              //   labelText: 'Brand',
              //   onSuggestionSelected: (s) => _.inputBrandTextSelected(s),
              //   onSuggestionCallback: (pattern) => _.debouncer.run(() {
              //         _.getInputBrandSuggestionFromAPI(pattern);
              //       }),
              //   textEditingController: _.inputTextCtrl.brand,
              //   onButtonAddClick: () {},
              // ),
            ],
          ),
        );
      },
    );
  }
}
