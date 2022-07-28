import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_hw_model_table.dart';
import 'dc_hw_model_model.dart';

class DcHwModelTableModel extends DcHwModelTable {
  DcHwModelTableModel({
    @required List<DcHwModelModel> dcHwModel,
  }) : super(dcHwModel: dcHwModel);

  factory DcHwModelTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcHwModelTableName,
        isSelectUsingView: true,
        viewName: TableName.dcHwModelViewName);

    DcHwModelTableModel _getObjectFrom(Iterable iterable) {
      return DcHwModelTableModel(
        dcHwModel: List<DcHwModelModel>.from(
          iterable?.map(
            (element) => DcHwModelModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
