import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_brand_ploc.dart';

class DcBrandFilterAdditional extends StatelessWidget {
  const DcBrandFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcBrandPloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
