import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_owner_ploc.dart';

class DcOwnerFilterDependencies extends StatelessWidget {
  const DcOwnerFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcOwnerPloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // MasterPageStandardTypeAheadTextField(
              //   labelText: 'Owner',
              //   onSuggestionSelected: (s) => _.filterOwnerTextSelected(s),
              //   onSuggestionCallback: (pattern) =>
              //       _.getFilterOwnerSuggestionsFromAPI(pattern),
              //   textEditingController: _.filterTextCtrl.owner,
              // ),
            ],
          ),
    );
  }
}
