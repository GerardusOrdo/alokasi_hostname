import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/email_schedule_ploc.dart';

class EmailScheduleInputAdditional extends StatelessWidget {
  const EmailScheduleInputAdditional({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSchedulePloc>(
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
              onChanged: (s) => _.inputEmailSchedule.notes = s,
              textEditingController: _.inputTextCtrl.notes,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
