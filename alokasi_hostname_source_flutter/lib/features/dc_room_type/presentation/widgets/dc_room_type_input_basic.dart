import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_room_type_ploc.dart';

class DcRoomTypeInputBasic extends StatelessWidget {
  const DcRoomTypeInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomTypePloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'RoomType',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcRoomType.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'RoomType',
                onChanged: (s) => _.inputDcRoomType.roomType = s,
                textEditingController: _.inputTextCtrl.roomType),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcRoomTypeInput),
            // textEditingController: _.dcRoomTypeNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}
