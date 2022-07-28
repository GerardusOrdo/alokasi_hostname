import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_hw_model_ploc.dart';

class DcHwModelFilterDependencies extends StatelessWidget {
  const DcHwModelFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwModelPloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // MasterPageStandardTypeAheadTextField(
              //   labelText: 'HwModel',
              //   onSuggestionSelected: (s) => _.filterHwModelTextSelected(s),
              //   onSuggestionCallback: (pattern) =>
              //       _.getFilterHwModelSuggestionsFromAPI(pattern),
              //   textEditingController: _.filterTextCtrl.hwModel,
              // ),
            ],
          ),
    );
  }
}
