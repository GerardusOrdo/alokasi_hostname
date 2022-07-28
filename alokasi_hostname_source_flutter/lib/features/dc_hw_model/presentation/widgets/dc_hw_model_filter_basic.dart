import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_hw_model_ploc.dart';

class DcHwModelFilterBasic extends StatelessWidget {
  DcHwModelFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwModelPloc>(
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
                labelText: 'HwModel',
                onSuggestionSelected: (s) =>
                    _.onFilterHwModelSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterHwModelSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.hwModel,
              ),
            ],
          ),
    );
  }
}
