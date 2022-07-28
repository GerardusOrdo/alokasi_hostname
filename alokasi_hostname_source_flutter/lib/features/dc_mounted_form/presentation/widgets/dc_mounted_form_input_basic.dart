import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_mounted_form_ploc.dart';

class DcMountedFormInputBasic extends StatelessWidget {
  const DcMountedFormInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcMountedFormPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'MountedForm',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcMountedForm.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'MountedForm',
                onChanged: (s) => _.inputDcMountedForm.mountedForm = s,
                textEditingController: _.inputTextCtrl.mountedForm),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcMountedFormInput),
            // textEditingController: _.dcMountedFormNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}
