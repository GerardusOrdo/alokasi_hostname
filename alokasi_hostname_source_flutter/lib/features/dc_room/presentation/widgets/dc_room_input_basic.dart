import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_checkbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_room_ploc.dart';

class DcRoomInputBasic extends StatelessWidget {
  const DcRoomInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'Room',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcRoom.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
              inputText: 'Room',
              onChanged: (s) => _.inputDcRoom.roomName = s,
              textEditingController: _.inputTextCtrl.roomName,
            ),
            MasterPageTextFormField(
              inputText: 'Rack Capacity',
              onChanged: (s) => _.inputDcRoom.rackCapacity = int.parse(s),
              textEditingController: _.inputTextCtrl.rackCapacity,
              dataType: EnumDataType.integer,
            ),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcRoomInput),
            // textEditingController: _.dcRoomNameInputTextEditingController),
            MasterPageStandardCheckbox(
              onChanged: (value) => _.setIsReservedTo(value),
              text: 'Is Reserved',
              value: _.inputDcRoom.isReserved ?? false,
            ),
          ],
        ),
      ),
    );
  }
}
