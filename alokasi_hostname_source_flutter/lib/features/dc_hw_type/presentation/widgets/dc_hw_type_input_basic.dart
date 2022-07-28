import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_hw_type_ploc.dart';

class DcHwTypeInputBasic extends StatelessWidget {
  const DcHwTypeInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwTypePloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'HwType',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcHwType.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'HwType',
                onChanged: (s) => _.inputDcHwType.hwType = s,
                textEditingController: _.inputTextCtrl.hwType),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcHwTypeInput),
            // textEditingController: _.dcHwTypeNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}
