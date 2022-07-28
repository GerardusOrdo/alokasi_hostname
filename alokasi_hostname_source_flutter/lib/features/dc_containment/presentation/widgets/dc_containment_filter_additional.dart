import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_containment_ploc.dart';

class DcContainmentFilterAdditional extends StatelessWidget {
  const DcContainmentFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcContainmentPloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MasterPageStandardDropdown(
            text: 'Top View Facing',
            value: _.filterDcContainment.topviewFacing,
            items: _.dropdownTopViewFacing,
            onChanged: (value) => _.setFilterTopViewFacingTo(value),
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Notes',
            onSuggestionSelected: (s) => _.onFilterNotesSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterNotesSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.notes,
          ),
        ],
      ),
    );
  }
}
