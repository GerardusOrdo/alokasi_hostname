import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_hw_type_ploc.dart';

class DcHwTypeFilterDependencies extends StatelessWidget {
  const DcHwTypeFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwTypePloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // MasterPageStandardTypeAheadTextField(
              //   labelText: 'HwType',
              //   onSuggestionSelected: (s) => _.filterHwTypeTextSelected(s),
              //   onSuggestionCallback: (pattern) =>
              //       _.getFilterHwTypeSuggestionsFromAPI(pattern),
              //   textEditingController: _.filterTextCtrl.hwType,
              // ),
            ],
          ),
    );
  }
}
