import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/email_schedule_ploc.dart';

class EmailScheduleFilterAdditional extends StatelessWidget {
  const EmailScheduleFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSchedulePloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
