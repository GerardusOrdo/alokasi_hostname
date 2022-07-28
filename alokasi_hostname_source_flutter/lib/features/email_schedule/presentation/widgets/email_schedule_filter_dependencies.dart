import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/email_schedule_ploc.dart';

class EmailScheduleFilterDependencies extends StatelessWidget {
  const EmailScheduleFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSchedulePloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MasterPageStandardTypeAheadTextField(
            labelText: 'Server',
            onSuggestionSelected: (s) =>
                _.onFilterServerNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterServerNameSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.serverName,
          ),
          // MasterPageStandardTypeAheadTextField(
          //   labelText: 'Owner',
          //   onSuggestionSelected: (s) => _.onFilterOwnerSuggestionSelected(s),
          //   onSuggestionCallback: (pattern) =>
          //       _.getFilterOwnerSuggestionsFromAPI(pattern),
          //   textEditingController: _.filterTextCtrl.owner,
          // ),
        ],
      ),
    );
  }
}
