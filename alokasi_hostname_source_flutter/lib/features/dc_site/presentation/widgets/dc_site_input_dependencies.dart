import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_dependencies_typeahead_textfield_custom.dart';
import '../bloc/dc_site_ploc.dart';

class DcSiteInputDependencies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcSitePloc>(
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
            ],
          ),
        );
      },
    );
  }
}
