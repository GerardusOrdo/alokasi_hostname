import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/owner_ploc.dart';

class OwnerInputAdditional extends StatelessWidget {
  const OwnerInputAdditional({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerPloc>(
      builder: (_) => Form(
            // key: _.formKeyInputAdditional,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MasterPageNotesBox(
                  bodyText: 'Please fill this additional Information',
                ),
                MasterPageTextFormField(
                  inputText: 'Notes',
                  onChanged: (s) => _.inputOwner.notes = s,
                  textEditingController: _.inputTextCtrl.notes,
                  maxLines: 3,
                ),
              ],
            ),
          ),
    );
  }
}
