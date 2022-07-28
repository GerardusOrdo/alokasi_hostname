import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_containment_ploc.dart';

class DcContainmentInputAdditional extends StatelessWidget {
  const DcContainmentInputAdditional({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcContainmentPloc>(
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
              value: _.inputDcContainment.topviewFacing,
              items: _.dropdownTopViewFacing,
              onChanged: (value) => _.setTopViewFacingTo(value),
            ),
            MasterPageTextFormField(
              inputText: 'X',
              onChanged: (s) => _.inputDcContainment.x = int.parse(s),
              textEditingController: _.inputTextCtrl.x,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Y',
              onChanged: (s) => _.inputDcContainment.y = int.parse(s),
              textEditingController: _.inputTextCtrl.y,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Width',
              onChanged: (s) => _.inputDcContainment.width = int.parse(s),
              textEditingController: _.inputTextCtrl.width,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Height',
              onChanged: (s) => _.inputDcContainment.height = int.parse(s),
              textEditingController: _.inputTextCtrl.height,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Row',
              onChanged: (s) => _.inputDcContainment.row = int.parse(s),
              textEditingController: _.inputTextCtrl.row,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Column',
              onChanged: (s) => _.inputDcContainment.column = int.parse(s),
              textEditingController: _.inputTextCtrl.column,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Notes',
              onChanged: (s) => _.inputDcContainment.notes = s,
              textEditingController: _.inputTextCtrl.notes,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
