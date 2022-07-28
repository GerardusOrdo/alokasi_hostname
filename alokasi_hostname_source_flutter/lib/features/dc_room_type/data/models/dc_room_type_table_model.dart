import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_room_type_table.dart';
import 'dc_room_type_model.dart';

class DcRoomTypeTableModel extends DcRoomTypeTable {
  DcRoomTypeTableModel({
    @required List<DcRoomTypeModel> dcRoomType,
  }) : super(dcRoomType: dcRoomType);

  factory DcRoomTypeTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcRoomTypeTableName,
        isSelectUsingView: true,
        viewName: TableName.dcRoomTypeViewName);

    DcRoomTypeTableModel _getObjectFrom(Iterable iterable) {
      return DcRoomTypeTableModel(
        dcRoomType: List<DcRoomTypeModel>.from(
          iterable?.map(
            (element) => DcRoomTypeModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
