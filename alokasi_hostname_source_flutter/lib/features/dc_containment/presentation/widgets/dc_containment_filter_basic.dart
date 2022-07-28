import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_checkbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_containment_ploc.dart';

class DcContainmentFilterBasic extends StatelessWidget {
  DcContainmentFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcContainmentPloc>(
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
            labelText: 'Containment',
            onSuggestionSelected: (s) =>
                _.onFilterContainmentNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterContainmentNameSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.containmentName,
          ),
          MasterPageStandardCheckbox(
            onChanged: (value) => _.setFilterIsReservedTo(value),
            text: 'Is Reserved',
            value: _.filterDcContainment.isReserved ?? false,
          ),
        ],
      ),
    );
  }
}
