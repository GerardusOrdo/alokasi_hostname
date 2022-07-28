import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_hw_type_table.dart';
import 'dc_hw_type_model.dart';

class DcHwTypeTableModel extends DcHwTypeTable {
  DcHwTypeTableModel({
    @required List<DcHwTypeModel> dcHwType,
  }) : super(dcHwType: dcHwType);

  factory DcHwTypeTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcHwTypeTableName,
        isSelectUsingView: true,
        viewName: TableName.dcHwTypeViewName);

    DcHwTypeTableModel _getObjectFrom(Iterable iterable) {
      return DcHwTypeTableModel(
        dcHwType: List<DcHwTypeModel>.from(
          iterable?.map(
            (element) => DcHwTypeModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
