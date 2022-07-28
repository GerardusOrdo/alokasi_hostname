import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_hardware_ploc.dart';

class DcHardwareFilterDependencies extends StatelessWidget {
  const DcHardwareFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHardwarePloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MasterPageStandardTypeAheadTextField(
            labelText: 'Owner',
            onSuggestionSelected: (s) => _.onFilterOwnerSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterOwnerSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.owner,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Rack',
            onSuggestionSelected: (s) =>
                _.onFilterRackNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterRackSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.rackName,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Brand',
            onSuggestionSelected: (s) => _.onFilterBrandSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterBrandSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.brand,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Hardware Model',
            onSuggestionSelected: (s) => _.onFilterHwModelSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterHwModelSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.hwModel,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Hardware Type',
            onSuggestionSelected: (s) => _.onFilterHwTypeSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterHwTypeSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.hwType,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Mounted Form',
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
