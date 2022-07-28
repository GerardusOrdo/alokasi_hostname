import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_mounted_form_ploc.dart';

class DcMountedFormFilterDependencies extends StatelessWidget {
  const DcMountedFormFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcMountedFormPloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // MasterPageStandardTypeAheadTextField(
              //   labelText: 'MountedForm',
              //   onSuggestionSelected: (s) => _.filterMountedFormTextSelected(s),
              //   onSuggestionCallback: (pattern) =>
              //       _.getFilterMountedFormSuggestionsFromAPI(pattern),
              //   textEditingController: _.filterTextCtrl.mountedForm,
              // ),
            ],
          ),
    );
  }
}
