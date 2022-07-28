import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_dependencies_typeahead_textfield_custom.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_checkbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_hardware_ploc.dart';

class DcHardwareFilterBasic extends StatelessWidget {
  DcHardwareFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHardwarePloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: double.infinity,
            child: DropdownButton(
                isExpanded: true,
                value: _.dataFilterSelection,
                items: _.dropdownFilterList,
                onChanged: (value) {
                  _.setComboboxFilter(value);
                }),
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Hardware',
            onSuggestionSelected: (s) => _.onFilterHwNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterHwNameSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.hwName,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Serial Number',
            onSuggestionSelected: (s) => _.onFilterSnSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterSnSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.sn,
          ),
          MasterPageStandardDropdown(
            text: 'Hardware Mounted Type',
            value: _.hwTypeFilterSelected,
            items: _.dropdownHwType,
            onChanged: (value) => _.setFilterHwTypeTo(value),
          ),
          // Blade
          _.hwTypeFilterSelected == 2
              ? Container(
                  child: Column(
                    children: [
                      MasterPageDependenciesTypeAheadTextFieldCustom(
                        labelText: 'SN Enclosure',
                        onSuggestionSelected: (s) =>
                            _.onFilterSnEnclosureSuggestionSelected(s),
                        onSuggestionCallback: (pattern) =>
                            _.getFilterSnEnclosureSuggestionsFromAPI(pattern),
                        textEditingController: _.filterEnclosureTextController,
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
            onChanged: (value) => _.setFilterIsReservedTo(value),
            text: 'Is Reserved',
            value: _.filterDcHardware.isReserved ?? false,
          ),
        ],
      ),
    );
  }
}
