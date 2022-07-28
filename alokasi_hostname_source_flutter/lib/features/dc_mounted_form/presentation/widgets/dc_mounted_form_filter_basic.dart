import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_mounted_form_ploc.dart';

class DcMountedFormFilterBasic extends StatelessWidget {
  DcMountedFormFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcMountedFormPloc>(
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
                labelText: 'MountedForm',
                onSuggestionSelected: (s) =>
                    _.onFilterMountedFormSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterMountedFormSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.mountedForm,
              ),
            ],
          ),
    );
  }
}
