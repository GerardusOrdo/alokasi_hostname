import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_site_ploc.dart';

class DcSiteFilterBasic extends StatelessWidget {
  DcSiteFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcSitePloc>(
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
                labelText: 'Site',
                onSuggestionSelected: (s) =>
                    _.onFilterDcSiteNameSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterDcSiteNameSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.dcSiteName,
              ),
            ],
          ),
    );
  }
}
