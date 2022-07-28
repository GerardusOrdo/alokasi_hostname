import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_owner_ploc.dart';

class DcOwnerFilterBasic extends StatelessWidget {
  DcOwnerFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcOwnerPloc>(
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
                onSuggestionSelected: (s) =>
                    _.onFilterOwnerSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterOwnerSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.owner,
              ),
            ],
          ),
    );
  }
}
