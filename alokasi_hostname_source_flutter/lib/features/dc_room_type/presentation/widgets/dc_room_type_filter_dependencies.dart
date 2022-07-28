import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_room_type_ploc.dart';

class DcRoomTypeFilterDependencies extends StatelessWidget {
  const DcRoomTypeFilterDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomTypePloc>(
      builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // MasterPageStandardTypeAheadTextField(
              //   labelText: 'RoomType',
              //   onSuggestionSelected: (s) => _.filterRoomTypeTextSelected(s),
              //   onSuggestionCallback: (pattern) =>
              //       _.getFilterRoomTypeSuggestionsFromAPI(pattern),
              //   textEditingController: _.filterTextCtrl.roomType,
              // ),
            ],
          ),
    );
  }
}
