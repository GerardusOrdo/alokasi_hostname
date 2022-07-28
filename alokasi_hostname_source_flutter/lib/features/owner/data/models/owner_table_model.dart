import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/owner_table.dart';
import 'owner_model.dart';

class OwnerTableModel extends OwnerTable {
  OwnerTableModel({
    @required List<OwnerModel> owner,
  }) : super(owner: owner);

  factory OwnerTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.ownerTableName,
        isSelectUsingView: true,
        viewName: TableName.ownerViewName);

    OwnerTableModel _getObjectFrom(Iterable iterable) {
      return OwnerTableModel(
        owner: List<OwnerModel>.from(
          iterable?.map(
            (element) => OwnerModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
