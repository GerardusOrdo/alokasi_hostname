import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_brand_table.dart';
import 'dc_brand_model.dart';

class DcBrandTableModel extends DcBrandTable {
  DcBrandTableModel({
    @required List<DcBrandModel> dcBrand,
  }) : super(dcBrand: dcBrand);

  factory DcBrandTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcBrandTableName,
        isSelectUsingView: true,
        viewName: TableName.dcBrandViewName);

    DcBrandTableModel _getObjectFrom(Iterable iterable) {
      return DcBrandTableModel(
        dcBrand: List<DcBrandModel>.from(
          iterable?.map(
            (element) => DcBrandModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
