import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/server_table.dart';
import 'server_model.dart';

class ServerTableModel extends ServerTable {
  ServerTableModel({
    @required List<ServerModel> server,
  }) : super(server: server);

  factory ServerTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.serverTableName,
        isSelectUsingView: true,
        viewName: TableName.serverViewName);

    ServerTableModel _getObjectFrom(Iterable iterable) {
      return ServerTableModel(
        server: List<ServerModel>.from(
          iterable?.map(
            (element) => ServerModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
