import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_hw_model_ploc.dart';

class DcHwModelFilterAdditional extends StatelessWidget {
  const DcHwModelFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwModelPloc>(
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
