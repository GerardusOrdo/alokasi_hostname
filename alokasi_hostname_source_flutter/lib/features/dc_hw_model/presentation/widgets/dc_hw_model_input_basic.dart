import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_hw_model_ploc.dart';

class DcHwModelInputBasic extends StatelessWidget {
  const DcHwModelInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwModelPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'HwModel',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcHwModel.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'HwModel',
                onChanged: (s) => _.inputDcHwModel.hwModel = s,
                textEditingController: _.inputTextCtrl.hwModel),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcHwModelInput),
            // textEditingController: _.dcHwModelNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}
