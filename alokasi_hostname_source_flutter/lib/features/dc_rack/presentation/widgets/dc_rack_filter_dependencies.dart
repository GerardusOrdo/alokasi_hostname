import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_rack_ploc.dart';

class DcRackFilterDependencies extends StatelessWidget {
  const DcRackFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRackPloc>(
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
            labelText: 'Room',
            onSuggestionSelected: (s) =>
                _.onFilterRoomNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterRoomSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.roomName,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Containment',
            onSuggestionSelected: (s) =>
                _.onFilterContainmentNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterContainmentSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.containmentName,
          ),
        ],
      ),
    );
  }
}
