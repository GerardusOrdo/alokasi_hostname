import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_room_ploc.dart';

class DcRoomInputAdditional extends StatelessWidget {
  const DcRoomInputAdditional({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputAdditional,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this additional Information',
            ),
            MasterPageTextFormField(
              inputText: 'X',
              onChanged: (s) => _.inputDcRoom.x = int.parse(s),
              textEditingController: _.inputTextCtrl.x,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Y',
              onChanged: (s) => _.inputDcRoom.y = int.parse(s),
              textEditingController: _.inputTextCtrl.y,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Width',
              onChanged: (s) => _.inputDcRoom.width = int.parse(s),
              textEditingController: _.inputTextCtrl.width,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Height',
              onChanged: (s) => _.inputDcRoom.height = int.parse(s),
              textEditingController: _.inputTextCtrl.height,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Notes',
              onChanged: (s) => _.inputDcRoom.notes = s,
              textEditingController: _.inputTextCtrl.notes,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
