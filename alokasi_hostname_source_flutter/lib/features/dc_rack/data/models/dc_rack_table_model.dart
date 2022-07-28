import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_rack_table.dart';
import 'dc_rack_model.dart';

class DcRackTableModel extends DcRackTable {
  DcRackTableModel({
    @required List<DcRackModel> dcRack,
  }) : super(dcRack: dcRack);

  factory DcRackTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcRackTableName,
        isSelectUsingView: true,
        viewName: TableName.dcRackViewName);

    DcRackTableModel _getObjectFrom(Iterable iterable) {
      return DcRackTableModel(
        dcRack: List<DcRackModel>.from(
          iterable?.map(
            (element) => DcRackModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
