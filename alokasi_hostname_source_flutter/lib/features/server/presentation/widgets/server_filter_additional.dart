import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/server_ploc.dart';

class ServerFilterAdditional extends StatelessWidget {
  const ServerFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerPloc>(
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
