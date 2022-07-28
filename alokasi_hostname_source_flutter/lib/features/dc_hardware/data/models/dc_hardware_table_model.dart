import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_hardware_table.dart';
import 'dc_hardware_model.dart';

class DcHardwareTableModel extends DcHardwareTable {
  DcHardwareTableModel({
    @required List<DcHardwareModel> dcHardware,
  }) : super(dcHardware: dcHardware);

  factory DcHardwareTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcHardwareTableName,
        isSelectUsingView: true,
        viewName: TableName.dcHardwareViewName);

    DcHardwareTableModel _getObjectFrom(Iterable iterable) {
      return DcHardwareTableModel(
        dcHardware: List<DcHardwareModel>.from(
          iterable?.map(
            (element) => DcHardwareModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
