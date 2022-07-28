import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_site_ploc.dart';

class DcSiteFilterAdditional extends StatelessWidget {
  const DcSiteFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcSitePloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MasterPageStandardTypeAheadTextField(
                labelText: 'Address',
                onSuggestionSelected: (s) =>
                    _.onFilterAddressSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterAddressSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.address,
              ),
              MasterPageStandardTypeAheadTextField(
                labelText: 'Notes',
                onSuggestionSelected: (s) =>
                    _.onFilterNotesSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterNotesSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.notes,
              ),
            ],
          ),
    );
  }
}
