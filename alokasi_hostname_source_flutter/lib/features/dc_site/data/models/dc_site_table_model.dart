import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_site_table.dart';
import 'dc_site_model.dart';

class DcSiteTableModel extends DcSiteTable {
  DcSiteTableModel({
    @required List<DcSiteModel> dcSite,
  }) : super(dcSite: dcSite);

  factory DcSiteTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcSiteTableName,
        isSelectUsingView: true,
        viewName: TableName.dcSiteViewName);

    DcSiteTableModel _getObjectFrom(Iterable iterable) {
      return DcSiteTableModel(
        dcSite: List<DcSiteModel>.from(
          iterable?.map(
            (element) => DcSiteModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
