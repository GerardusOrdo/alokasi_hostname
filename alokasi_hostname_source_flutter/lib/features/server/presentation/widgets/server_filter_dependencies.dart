import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/server_ploc.dart';

class ServerFilterDependencies extends StatelessWidget {
  const ServerFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerPloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MasterPageStandardTypeAheadTextField(
                labelText: 'Owner',
                onSuggestionSelected: (s) =>
                    _.onFilterOwnerSuggestionSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getFilterOwnerSuggestionsFromAPI(pattern),
                textEditingController: _.filterTextCtrl.owner,
              ),
            ],
          ),
    );
  }
}
