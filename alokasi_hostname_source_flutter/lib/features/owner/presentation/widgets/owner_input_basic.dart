import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/owner_ploc.dart';

class OwnerInputBasic extends StatelessWidget {
  const OwnerInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerPloc>(
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
            //       _.inputOwner.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'Owner',
                onChanged: (s) => _.inputOwner.owner = s,
                textEditingController: _.inputTextCtrl.owner),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.ownerInput),
            // textEditingController: _.ownerNameInputTextEditingController),
            MasterPageTextFormField(
                inputText: 'Email',
                onChanged: (s) => _.inputOwner.email = s,
                textEditingController: _.inputTextCtrl.email),
            MasterPageTextFormField(
                inputText: 'Phone',
                onChanged: (s) => _.inputOwner.phone = s,
                textEditingController: _.inputTextCtrl.phone),
          ],
        ),
      ),
    );
  }
}
