import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_room_type_ploc.dart';

class DcRoomTypeFilterBasic extends StatelessWidget {
  DcRoomTypeFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomTypePloc>(
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
                labelText: 'RoomType',
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
