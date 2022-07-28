import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_checkbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_containment_ploc.dart';

class DcContainmentInputBasic extends StatelessWidget {
  const DcContainmentInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcContainmentPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'Containment',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcContainment.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'Containment',
                onChanged: (s) => _.inputDcContainment.containmentName = s,
                textEditingController: _.inputTextCtrl.containmentName),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcContainmentInput),
            // textEditingController: _.dcContainmentNameInputTextEditingController),
            MasterPageStandardCheckbox(
              onChanged: (value) => _.setIsReservedTo(value),
              text: 'Is Reserved',
              value: _.inputDcContainment.isReserved ?? false,
            ),
          ],
        ),
      ),
    );
  }
}
