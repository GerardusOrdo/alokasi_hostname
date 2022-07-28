import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_room_table.dart';
import 'dc_room_model.dart';

class DcRoomTableModel extends DcRoomTable {
  DcRoomTableModel({
    @required List<DcRoomModel> dcRoom,
  }) : super(dcRoom: dcRoom);

  factory DcRoomTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcRoomTableName,
        isSelectUsingView: true,
        viewName: TableName.dcRoomViewName);

    DcRoomTableModel _getObjectFrom(Iterable iterable) {
      return DcRoomTableModel(
        dcRoom: List<DcRoomModel>.from(
          iterable?.map(
            (element) => DcRoomModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
