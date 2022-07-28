import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_brand_ploc.dart';

class DcBrandFilterBasic extends StatelessWidget {
  DcBrandFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcBrandPloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                    isExpanded: true,
                    value: _.dataFilterSelection,
                    items: _.dropdownFilterList,
                    onChanged: (value) {
                      _.setComboboxFilter(value);
                    }),
              ),
              MasterPageStandardTypeAheadTextField(
                labelText: 'Brand',
                onSuggestionSelected: (s) =>
                    _.onFilterBrandSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterBrandSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.brand,
              ),
            ],
          ),
    );
  }
}
