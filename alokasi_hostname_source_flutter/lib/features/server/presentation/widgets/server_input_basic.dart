import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield_tap.dart';
import '../bloc/server_ploc.dart';

class ServerInputBasic extends StatelessWidget {
  const ServerInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'Server',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputServer.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'Server',
                onChanged: (s) => _.inputServer.serverName = s,
                textEditingController: _.inputTextCtrl.serverName),
            MasterPageTextFormField(
                inputText: 'IP',
                onChanged: (s) => _.inputServer.ip = s,
                textEditingController: _.inputTextCtrl.ip),
            MasterPageStandardDropdown(
              text: 'Status',
              value: _.inputServer.status,
              items: _.dropdownStatus,
              onChanged: (value) => _.setStatusTo(value),
            ),
            MasterPageTextFormFieldTap(
              onTap: () {
                _.selectDate(context, _.inputTextCtrl.powerOnDate);
              },
              textEditingController: _.inputTextCtrl.powerOnDate,
              inputText: "Server Power On Date",
              onChanged: (s) {},
            ),
            MasterPageTextFormFieldTap(
              onTap: () {
                _.selectDate(context, _.inputTextCtrl.userNotifDate);
              },
              textEditingController: _.inputTextCtrl.userNotifDate,
              inputText: "Before Server Power Off User Notification Date",
              onChanged: (s) {},
            ),
            MasterPageTextFormFieldTap(
              onTap: () {
                _.selectDate(context, _.inputTextCtrl.powerOffDate);
              },
              textEditingController: _.inputTextCtrl.powerOffDate,
              inputText: "Server Power Off Notification Date",
              onChanged: (s) {},
            ),
            MasterPageTextFormFieldTap(
              onTap: () {
                _.selectDate(context, _.inputTextCtrl.deleteDate);
              },
              textEditingController: _.inputTextCtrl.deleteDate,
              inputText: "Delete Server Notification Date",
              onChanged: (s) {},
            ),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.serverInput),
            // textEditingController: _.serverNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}
