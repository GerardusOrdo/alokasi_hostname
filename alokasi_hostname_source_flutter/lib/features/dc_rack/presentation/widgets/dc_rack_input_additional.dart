import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_rack_ploc.dart';

class DcRackInputAdditional extends StatelessWidget {
  const DcRackInputAdditional({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRackPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputAdditional,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this additional Information',
            ),
            MasterPageStandardDropdown(
              text: 'Top View Facing',
              value: _.inputDcRack.topviewFacing,
              items: _.dropdownTopViewFacing,
              onChanged: (value) => _.setTopViewFacingTo(value),
            ),
            MasterPageTextFormField(
              inputText: 'X',
              onChanged: (s) => _.inputDcRack.x = int.parse(s),
              textEditingController: _.inputTextCtrl.x,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Y',
              onChanged: (s) => _.inputDcRack.y = int.parse(s),
              textEditingController: _.inputTextCtrl.y,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Max U Height',
              onChanged: (s) => _.inputDcRack.maxUHeight = int.parse(s),
              textEditingController: _.inputTextCtrl.maxUHeight,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Width',
              onChanged: (s) => _.inputDcRack.width = int.parse(s),
              textEditingController: _.inputTextCtrl.width,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Height',
              onChanged: (s) => _.inputDcRack.height = int.parse(s),
              textEditingController: _.inputTextCtrl.height,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Notes',
              onChanged: (s) => _.inputDcRack.notes = s,
              textEditingController: _.inputTextCtrl.notes,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
