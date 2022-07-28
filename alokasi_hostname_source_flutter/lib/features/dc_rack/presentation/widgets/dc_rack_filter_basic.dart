import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_checkbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_rack_ploc.dart';

class DcRackFilterBasic extends StatelessWidget {
  DcRackFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRackPloc>(
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
            labelText: 'Rack',
            onSuggestionSelected: (s) =>
                _.onFilterRackNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterRackNameSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.rackName,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Description',
            onSuggestionSelected: (s) =>
                _.onFilterDescriptionSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterDescriptionSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.description,
          ),
          MasterPageStandardCheckbox(
            onChanged: (value) => _.setFilterIsReservedTo(value),
            text: 'Is Reserved',
            value: _.filterDcRack.isReserved ?? false,
          ),
        ],
      ),
    );
  }
}
