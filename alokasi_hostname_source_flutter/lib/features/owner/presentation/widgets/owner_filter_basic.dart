import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/owner_ploc.dart';

class OwnerFilterBasic extends StatelessWidget {
  OwnerFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerPloc>(
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
            labelText: 'Owner',
            onSuggestionSelected: (s) => _.onFilterOwnerSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterOwnerSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.owner,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Email',
            onSuggestionSelected: (s) => _.onFilterEmailSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterEmailSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.email,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Phone',
            onSuggestionSelected: (s) => _.onFilterPhoneSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterPhoneSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.phone,
          ),
        ],
      ),
    );
  }
}
