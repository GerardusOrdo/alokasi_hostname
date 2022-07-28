import 'package:alokasi_hostname/core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_dependencies_typeahead_textfield_custom.dart';
import '../bloc/email_schedule_ploc.dart';

class EmailScheduleInputDependencies extends StatelessWidget {
  const EmailScheduleInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSchedulePloc>(
      builder: (_) {
        return Form(
          // key: _.formKeyInputDependencies,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: SizedBox(
                  child: Text('Dependencies'),
                  width: double.infinity,
                ),
                color: Colors.blue[50],
                height: 70.0,
                padding: EdgeInsets.all(20.0),
              ),
              AbsorbPointer(
                absorbing: true,
                child: MasterPageTextFormField(
                    inputText: 'Server',
                    onChanged: (s) => _.inputEmailSchedule.serverName = s,
                    textEditingController: _.inputTextCtrl.serverName),
              ),
              // AbsorbPointer(
              //   absorbing: true,
              //   child: MasterPageDependenciesTypeAheadTextFieldCustom(
              //     labelText: 'Server',
              //     onSuggestionSelected: (s) => _.inputServerTextSelected(s),
              //     onSuggestionCallback: (pattern) =>
              //         _.getInputServerNameSuggestionFromAPI(pattern),
              //     textEditingController: _.inputTextCtrl.serverName,
              //     onButtonAddClick: () {},
              //     itemBuilder: (context, suggestion) => ListTile(
              //       title: Text(suggestion['server_name']),
              //     ),
              //   ),
              // ),
              // MasterPageDependenciesTypeAheadTextFieldCustom(
              //   labelText: 'Owner',
              //   onSuggestionSelected: (s) => _.inputOwnerTextSelected(s),
              //   onSuggestionCallback: (pattern) =>
              //       _.getInputOwnerSuggestionFromAPI(pattern),
              //   textEditingController: _.inputTextCtrl.owner,
              //   onButtonAddClick: () {},
              //   itemBuilder: (context, suggestion) => ListTile(
              //     title: Text(suggestion['owner']),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
