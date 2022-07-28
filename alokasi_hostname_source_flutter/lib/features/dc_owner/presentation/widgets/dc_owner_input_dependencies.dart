import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_owner_ploc.dart';

class DcOwnerInputDependencies extends StatelessWidget {
  const DcOwnerInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcOwnerPloc>(
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
              //   labelText: 'Owner',
              //   onSuggestionSelected: (s) => _.inputOwnerTextSelected(s),
              //   onSuggestionCallback: (pattern) => _.debouncer.run(() {
              //         _.getInputOwnerSuggestionFromAPI(pattern);
              //       }),
              //   textEditingController: _.inputTextCtrl.owner,
              //   onButtonAddClick: () {},
              // ),
            ],
          ),
        );
      },
    );
  }
}
