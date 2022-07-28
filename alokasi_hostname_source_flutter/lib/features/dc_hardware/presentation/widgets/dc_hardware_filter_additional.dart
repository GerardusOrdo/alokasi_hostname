import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_hardware_ploc.dart';

class DcHardwareFilterAdditional extends StatelessWidget {
  const DcHardwareFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHardwarePloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MasterPageStandardDropdown(
            text: 'Front Back Facing',
            value: _.filterDcHardware.frontbackFacing,
            items: _.dropdownFrontBackFacing,
            onChanged: (value) => _.setFilterFrontBackFacingTo(value),
          ),
          MasterPageStandardDropdown(
            text: 'Hardware Connect Type',
            value: _.filterDcHardware.hwConnectType,
            items: _.dropdownHwConnectType,
            onChanged: (value) => _.setFilterHwConnectTypeTo(value),
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Notes',
            onSuggestionSelected: (s) => _.onFilterNotesSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterNotesSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.notes,
          ),
        ],
      ),
    );
  }
}
