import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_hardware_ploc.dart';

class DcHardwareInputAdditional extends StatelessWidget {
  const DcHardwareInputAdditional({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHardwarePloc>(
      builder: (_) => Form(
        // key: _.formKeyInputAdditional,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this additional Information',
            ),
            MasterPageStandardDropdown(
              text: 'Front Back Facing',
              value: _.inputDcHardware.frontbackFacing,
              items: _.dropdownFrontBackFacing,
              onChanged: (value) => _.setFrontBackFacingTo(value),
            ),
            MasterPageStandardDropdown(
              text: 'Hardware Connect Type',
              value: _.inputDcHardware.hwConnectType,
              items: _.dropdownHwConnectType,
              onChanged: (value) => _.setHwConnectTypeTo(value),
            ),
            MasterPageTextFormField(
              inputText: 'X Position In Rack',
              onChanged: (s) =>
                  _.inputDcHardware.xPositionInRack = int.parse(s),
              textEditingController: _.inputTextCtrl.xPositionInRack,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Y Position In Rack',
              onChanged: (s) =>
                  _.inputDcHardware.yPositionInRack = int.parse(s),
              textEditingController: _.inputTextCtrl.yPositionInRack,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'CPU Core',
              onChanged: (s) => _.inputDcHardware.cpuCore = int.parse(s),
              textEditingController: _.inputTextCtrl.cpuCore,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Memory (in GB)',
              onChanged: (s) => _.inputDcHardware.memoryGb = int.parse(s),
              textEditingController: _.inputTextCtrl.memoryGb,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Disk (in GB)',
              onChanged: (s) => _.inputDcHardware.diskGb = int.parse(s),
              textEditingController: _.inputTextCtrl.diskGb,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Load (in Watt)',
              onChanged: (s) => _.inputDcHardware.watt = double.parse(s),
              textEditingController: _.inputTextCtrl.watt,
              dataType: EnumDataType.float,
            ),
            MasterPageTextFormField(
              inputText: 'Current (in Ampere)',
              onChanged: (s) => _.inputDcHardware.watt = double.parse(s),
              textEditingController: _.inputTextCtrl.ampere,
              dataType: EnumDataType.float,
            ),
            MasterPageTextFormField(
              inputText: 'Width',
              onChanged: (s) => _.inputDcHardware.width = int.parse(s),
              textEditingController: _.inputTextCtrl.width,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Height',
              onChanged: (s) => _.inputDcHardware.height = int.parse(s),
              textEditingController: _.inputTextCtrl.height,
              dataType: EnumDataType.integer,
            ),
            MasterPageTextFormField(
              inputText: 'Notes',
              onChanged: (s) => _.inputDcHardware.notes = s,
              textEditingController: _.inputTextCtrl.notes,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
