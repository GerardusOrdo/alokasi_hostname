import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_dependencies_typeahead_textfield_custom.dart';
import '../bloc/dc_rack_ploc.dart';

class DcRackInputDependencies extends StatelessWidget {
  const DcRackInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRackPloc>(
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
              MasterPageDependenciesTypeAheadTextFieldCustom(
                labelText: 'Owner',
                onSuggestionSelected: (s) => _.inputOwnerTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputOwnerSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.owner,
                onButtonAddClick: () => _.addOwnerDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['owner']),
                ),
              ),
              MasterPageDependenciesTypeAheadTextFieldCustom(
                labelText: 'Room',
                onSuggestionSelected: (s) => _.inputRoomTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputRoomSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.roomName,
                onButtonAddClick: () => _.addRoomDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['room']),
                ),
              ),
              MasterPageDependenciesTypeAheadTextFieldCustom(
                labelText: 'Containment',
                onSuggestionSelected: (s) => _.inputContainmentTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputContainmentSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.containmentName,
                onButtonAddClick: () => _.addContainmentDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['containment']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
