import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_containment_table.dart';
import 'dc_containment_model.dart';

class DcContainmentTableModel extends DcContainmentTable {
  DcContainmentTableModel({
    @required List<DcContainmentModel> dcContainment,
  }) : super(dcContainment: dcContainment);

  factory DcContainmentTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcContainmentTableName,
        isSelectUsingView: true,
        viewName: TableName.dcContainmentViewName);

    DcContainmentTableModel _getObjectFrom(Iterable iterable) {
      return DcContainmentTableModel(
        dcContainment: List<DcContainmentModel>.from(
          iterable?.map(
            (element) => DcContainmentModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
