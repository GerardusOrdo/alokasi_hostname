import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_owner_table.dart';
import 'dc_owner_model.dart';

class DcOwnerTableModel extends DcOwnerTable {
  DcOwnerTableModel({
    @required List<DcOwnerModel> dcOwner,
  }) : super(dcOwner: dcOwner);

  factory DcOwnerTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcOwnerTableName,
        isSelectUsingView: true,
        viewName: TableName.dcOwnerViewName);

    DcOwnerTableModel _getObjectFrom(Iterable iterable) {
      return DcOwnerTableModel(
        dcOwner: List<DcOwnerModel>.from(
          iterable?.map(
            (element) => DcOwnerModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
