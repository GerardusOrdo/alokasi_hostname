import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_dependencies_typeahead_textfield_custom.dart';
import '../bloc/dc_room_ploc.dart';

class DcRoomInputDependencies extends StatelessWidget {
  const DcRoomInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomPloc>(
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
                labelText: 'Dc Site',
                onSuggestionSelected: (s) => _.inputDcSiteTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputDcSiteSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.dcSiteName,
                onButtonAddClick: () => _.addDcSiteDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['dc_site']),
                ),
              ),
              MasterPageDependenciesTypeAheadTextFieldCustom(
                labelText: 'Room Type',
                onSuggestionSelected: (s) => _.inputRoomTypeTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputRoomTypeSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.roomType,
                onButtonAddClick: () => _.addRoomTypeDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['room_type']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
