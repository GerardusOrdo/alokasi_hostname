import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/owner_ploc.dart';

class OwnerFilterDependencies extends StatelessWidget {
  const OwnerFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerPloc>(
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
