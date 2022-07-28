import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_owner_ploc.dart';

class DcOwnerInputAdditional extends StatelessWidget {
  const DcOwnerInputAdditional({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcOwnerPloc>(
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
              onChanged: (s) => _.inputDcOwner.notes = s,
              textEditingController: _.inputTextCtrl.notes,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
