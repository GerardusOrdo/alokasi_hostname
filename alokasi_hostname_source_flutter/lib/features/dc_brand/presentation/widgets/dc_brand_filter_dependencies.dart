import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_brand_ploc.dart';

class DcBrandFilterDependencies extends StatelessWidget {
  const DcBrandFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcBrandPloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // MasterPageStandardTypeAheadTextField(
              //   labelText: 'Brand',
              //   onSuggestionSelected: (s) => _.filterBrandTextSelected(s),
              //   onSuggestionCallback: (pattern) =>
              //       _.getFilterBrandSuggestionsFromAPI(pattern),
              //   textEditingController: _.filterTextCtrl.brand,
              // ),
            ],
          ),
    );
  }
}
