import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_dependencies_typeahead_textfield_custom.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_checkbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_hardware_ploc.dart';

class DcHardwareInputBasic extends StatelessWidget {
  const DcHardwareInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHardwarePloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'Hardware',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcHardware.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),

            //! sini
            MasterPageTextFormField(
                inputText: 'Hardware',
                onChanged: (s) => _.inputDcHardware.hwName = s,
                textEditingController: _.inputTextCtrl.hwName),
            MasterPageTextFormField(
                inputText: 'Serial Number',
                onChanged: (s) => _.inputDcHardware.sn = s,
                textEditingController: _.inputTextCtrl.sn),
            MasterPageTextFormField(
              inputText: 'U Height',
              onChanged: (s) => _.inputDcHardware.uHeight = int.parse(s),
              textEditingController: _.inputTextCtrl.uHeight,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Base U Position',
              onChanged: (s) => _.inputDcHardware.uHeight = int.parse(s),
              textEditingController: _.inputTextCtrl.uPosition,
              dataType: EnumDataType.integer,
            ),
            MasterPageStandardDropdown(
              text: 'Hardware Mounted Type',
              value: _.hwTypeSelected,
              items: _.dropdownHwType,
              onChanged: (value) => _.setHwTypeTo(value),
            ),
            // Enclosure
            _.hwTypeSelected == 1
                ? Container(
                    child: Column(
                      children: [
                        MasterPageTextFormField(
                          inputText: 'Enclosure Column',
                          onChanged: (s) =>
                              _.inputDcHardware.enclosureColumn = int.parse(s),
                          textEditingController:
                              _.inputTextCtrl.enclosureColumn,
                          dataType: EnumDataType.integer,
                        ),
                        MasterPageTextFormField(
                          inputText: 'Enclosure Row',
                          onChanged: (s) =>
                              _.inputDcHardware.enclosureRow = int.parse(s),
                          textEditingController: _.inputTextCtrl.enclosureRow,
                          dataType: EnumDataType.integer,
                        ),
                      ],
                    ),
                  )
                : Container(),
            // Blade
            _.hwTypeSelected == 2
                ? Container(
                    child: Column(
                      children: [
                        MasterPageDependenciesTypeAheadTextFieldCustom(
                          labelText: 'SN Enclosure',
                          autofocus: false,
                          onSuggestionSelected: (s) =>
                              _.inputSnEnclosureTextSelected(s),
                          onSuggestionCallback: (pattern) =>
                              _.getInputSnEnclosureSuggestionFromAPI(pattern),
                          textEditingController: _.inputEnclosureTextController,
                          onButtonAddClick: () {},
                          itemBuilder: (context, suggestion) => ListTile(
                            title: Text(suggestion['sn']),
                            subtitle: Text(
                                '''${suggestion['hw_name']} : Rack ${suggestion['rack_name']} : U ${suggestion['u_position']} - ${suggestion['u_to_u']}'''),
                          ),
                        ),
                        MasterPageTextFormField(
                          inputText: 'X in Enclosure',
                          onChanged: (s) =>
                              _.inputDcHardware.xInEnclosure = int.parse(s),
                          textEditingController: _.inputTextCtrl.xInEnclosure,
                          dataType: EnumDataType.integer,
                        ),
                        MasterPageTextFormField(
                          inputText: 'Y in Enclosure',
                          onChanged: (s) =>
                              _.inputDcHardware.yInEnclosure = int.parse(s),
                          textEditingController: _.inputTextCtrl.yInEnclosure,
                          dataType: EnumDataType.integer,
                        ),
                      ],
                    ),
                  )
                : Container(),
            MasterPageStandardCheckbox(
              onChanged: (value) => _.setIsReservedTo(value),
              text: 'Is Reserved',
              value: _.inputDcHardware.isReserved ?? false,
            ),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcHardwareInput),
            // textEditingController: _.dcHardwareNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}
