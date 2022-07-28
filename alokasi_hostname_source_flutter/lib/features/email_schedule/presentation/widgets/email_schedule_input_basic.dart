import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield_tap.dart';
import '../bloc/email_schedule_ploc.dart';

class EmailScheduleInputBasic extends StatelessWidget {
  const EmailScheduleInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSchedulePloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'EmailSchedule',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputEmailSchedule.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            AbsorbPointer(
              absorbing: true,
              child: MasterPageTextFormFieldTap(
                onTap: () {
                  _.selectDate(context, _.inputTextCtrl.date);
                },
                textEditingController: _.inputTextCtrl.date,
                inputText: "Send Date",
                onChanged: (s) {},
              ),
            ),
            AbsorbPointer(
              absorbing: true,
              child: MasterPageStandardDropdown(
                text: 'State',
                value: _.inputEmailSchedule.state,
                items: _.dropdownState,
                onChanged: (value) => _.setStateTo(value),
              ),
            ),
            MasterPageStandardDropdown(
              text: 'Status',
              value: _.inputEmailSchedule.status,
              items: _.dropdownStatus,
              onChanged: (value) => _.setStatusTo(value),
            ),

            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.emailScheduleInput),
            // textEditingController: _.emailScheduleNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}
