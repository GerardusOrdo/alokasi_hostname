import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_checkbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_room_ploc.dart';

class DcRoomFilterBasic extends StatelessWidget {
  DcRoomFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomPloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: double.infinity,
            child: DropdownButton(
                isExpanded: true,
                value: _.dataFilterSelection,
                items: _.dropdownFilterList,
                onChanged: (value) {
                  _.setComboboxFilter(value);
                }),
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Room',
            onSuggestionSelected: (s) =>
                _.onFilterRoomNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterRoomNameSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.roomName,
          ),
          MasterPageStandardCheckbox(
            onChanged: (value) => _.setFilterIsReservedTo(value),
            text: 'Is Reserved',
            value: _.filterDcRoom.isReserved ?? false,
          )
        ],
      ),
    );
  }
}
