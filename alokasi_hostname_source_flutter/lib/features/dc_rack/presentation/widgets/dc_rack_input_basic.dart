import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_checkbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_rack_ploc.dart';

class DcRackInputBasic extends StatelessWidget {
  const DcRackInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRackPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'Rack',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcRack.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'Rack',
                onChanged: (s) => _.inputDcRack.rackName = s,
                textEditingController: _.inputTextCtrl.rackName),
            MasterPageTextFormField(
                inputText: 'Description',
                onChanged: (s) => _.inputDcRack.description = s,
                textEditingController: _.inputTextCtrl.description),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcRackInput),
            // textEditingController: _.dcRackNameInputTextEditingController),
            MasterPageStandardCheckbox(
              onChanged: (value) => _.setIsReservedTo(value),
              text: 'Is Reserved',
              value: _.inputDcRack.isReserved ?? false,
            ),
          ],
        ),
      ),
    );
  }
}
