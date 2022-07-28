import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_hw_type_ploc.dart';

class DcHwTypeFilterBasic extends StatelessWidget {
  DcHwTypeFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwTypePloc>(
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
                labelText: 'HwType',
                onSuggestionSelected: (s) =>
                    _.onFilterHwTypeSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterHwTypeSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.hwType,
              ),
            ],
          ),
    );
  }
}
