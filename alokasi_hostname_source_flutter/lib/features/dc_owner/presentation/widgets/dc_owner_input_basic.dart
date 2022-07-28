import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_owner_ploc.dart';

class DcOwnerInputBasic extends StatelessWidget {
  const DcOwnerInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcOwnerPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'Owner',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcOwner.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'Owner',
                onChanged: (s) => _.inputDcOwner.owner = s,
                textEditingController: _.inputTextCtrl.owner),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcOwnerInput),
            // textEditingController: _.dcOwnerNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}
