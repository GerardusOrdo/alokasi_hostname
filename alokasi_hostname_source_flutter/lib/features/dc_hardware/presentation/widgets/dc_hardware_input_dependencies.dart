import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_dependencies_typeahead_textfield_custom.dart';
import '../bloc/dc_hardware_ploc.dart';

class DcHardwareInputDependencies extends StatelessWidget {
  const DcHardwareInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHardwarePloc>(
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
                labelText: 'Rack',
                onSuggestionSelected: (s) => _.inputRackTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputRackSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.rackName,
                onButtonAddClick: () => _.addRackDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['rack_name']),
                ),
              ),
              MasterPageDependenciesTypeAheadTextFieldCustom(
                labelText: 'Brand',
                onSuggestionSelected: (s) => _.inputBrandTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputBrandSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.brand,
                onButtonAddClick: () => _.addBrandDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['brand']),
                ),
              ),
              MasterPageDependenciesTypeAheadTextFieldCustom(
                labelText: 'Hardware Model',
                onSuggestionSelected: (s) => _.inputHwModelTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputHwModelSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.hwModel,
                onButtonAddClick: () => _.addHwModelDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['hw_model']),
                ),
              ),
              MasterPageDependenciesTypeAheadTextFieldCustom(
                labelText: 'Hardware Type',
                onSuggestionSelected: (s) => _.inputHwTypeTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputHwTypeSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.hwType,
                onButtonAddClick: () => _.addHwTypeDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['hw_type']),
                ),
              ),
              MasterPageDependenciesTypeAheadTextFieldCustom(
                labelText: 'Mounted Form',
                onSuggestionSelected: (s) => _.inputMountedFormTextSelected(s),
                onSuggestionCallback: (pattern) =>
                    _.getInputMountedFormSuggestionFromAPI(pattern),
                textEditingController: _.inputTextCtrl.mountedForm,
                onButtonAddClick: () => _.addMountedFormDependencies(),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(suggestion['mounted_form']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
