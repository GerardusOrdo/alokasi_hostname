import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_room_ploc.dart';

class DcRoomFilterDependencies extends StatelessWidget {
  const DcRoomFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomPloc>(
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
            labelText: 'Dc Site',
            onSuggestionSelected: (s) =>
                _.onFilterDcSiteNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterDcSiteSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.dcSiteName,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Room Type',
            onSuggestionSelected: (s) =>
                _.onFilterRoomTypeSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterRoomTypeSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.roomType,
          ),
        ],
      ),
    );
  }
}
