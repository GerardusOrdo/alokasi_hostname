import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_room.dart';
import '../../domain/entities/dc_room_plus_filter.dart';
import '../models/dc_room_model.dart';
import '../models/dc_room_table_model.dart';
import 'dc_room_query.dart';

abstract class DcRoomTableRemoteDataSource {
  Future<DcRoomTableModel> getAllDataWithFilter(
      DcRoomPlusFilter dcRoomPlusFilter);
  Future<List<int>> getIdsFromInserted(DcRoomModel dcRoomModel);
  Future<List<int>> getIdsFromCloned(List<DcRoomModel> dcRoomModels);
  Future<List<int>> getIdsFromUpdated(DcRoomModel dcRoomModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcRoom> dcRooms);
  Future<List<int>> getIdsFromDeleted(List<DcRoom> dcRooms);
}

class DcRoomTableRemoteDataSourceImpl implements DcRoomTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcRoomQuery dcRoomQuery;

  DcRoomTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcRoomQuery,
  });

  @override
  Future<DcRoomTableModel> getAllDataWithFilter(DcRoomPlusFilter dcRoom) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcRoom);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcRoomModel dcRoom) async {
    Map<String, dynamic> variables = getPreparedInsertMutationVariable(dcRoom);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcRoomModel> dcRoom) async {
    Map<String, dynamic> variables = getPreparedCloneMutationVariable(dcRoom);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcRoomModel dcRoom) async {
    Map<String, dynamic> variables = getPreparedUpdateMutationVariable(dcRoom);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcRoom> dcRoom) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcRoom);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcRoom> dcRoom) async {
    Map<String, dynamic> variables = getPreparedDeleteMutationVariable(dcRoom);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcRoomTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcRoomQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcRoomQuery.getSelectStatement,
      );
      return DcRoomTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(DcRoomPlusFilter dcRoom) {
    String dataFilterByLogicalOperator =
        dcRoom.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcRoom.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcRoom);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcRoom,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcRoomPlusFilter fields,
    @required String orderBy,
    @required String dataFilterByLogicalOperator,
    @required List<Map<String, dynamic>> queryFieldVariables,
  }) {
    return {
      "offset": fields.offsets,
      "limit": fields.limits,
      "order_by": {fields.fieldToOrderBy: orderBy},
      "where": {
        "_and": [
          {dataFilterByLogicalOperator: queryFieldVariables},
          {
            "deleted": {"_eq": false}
          }
        ],
      }
    };
  }

  List<Map<String, dynamic>> getQueryFieldVariables(DcRoom dcRoom) {
    return [
      getVariableMap("id", "_eq", dcRoom.id),
      getVariableMap("id_owner", "_eq", dcRoom.idOwner),
      getVariableMap(
          "owner", "_ilike", DataHelper.getQueryLikeTextFrom(dcRoom.owner)),
      getVariableMap("id_dc_site", "_eq", dcRoom.idDcSite),
      getVariableMap("dc_site_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcRoom.dcSiteName)),
      getVariableMap("id_room_type", "_eq", dcRoom.idRoomType),
      getVariableMap("room_type", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcRoom.roomType)),
      getVariableMap("room_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcRoom.roomName)),
      getVariableMap("id_parent_room", "_eq", dcRoom.idParentRoom),
      getVariableMap("x", "_eq", dcRoom.x),
      getVariableMap("y", "_eq", dcRoom.y),
      getVariableMap("width", "_eq", dcRoom.width),
      getVariableMap("height", "_eq", dcRoom.height),
      getVariableMap("is_reserved", "_eq", dcRoom.isReserved),
      getVariableMap(
          "map", "_ilike", DataHelper.getQueryLikeTextFrom(dcRoom.map)),
      getVariableMap(
          "image", "_ilike", DataHelper.getQueryLikeTextFrom(dcRoom.image)),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(dcRoom.notes)),
      getVariableMap("deleted", "_eq", dcRoom.deleted),
      getVariableMap(
          "created", "_ilike", DataHelper.getQueryLikeTextFrom(dcRoom.created)),
    ];
  }

  Map<String, dynamic> getVariableMap(
      String fieldName, String queryOperator, Object value) {
    if (value != null) {
      return {
        fieldName: {queryOperator: value}
      };
    }
  }

  Future<List<int>> _executeGraphqlMutation({
    @required Map<String, dynamic> variables,
    @required String mutationStatement,
    @required EnumDataManipulation dataManipulation,
  }) async {
    try {
      if (Settings.isDebuggingQueryMode) {
        print(mutationStatement);
        print(variables);
      }

      Map<String, dynamic> result = await DataHelper.executeGraphqlMutation(
        graphqlClient: graphqlClient,
        variables: variables,
        mutationStatement: mutationStatement,
      );

      return getManipulatedIds(
        graphqlResult: result,
        dataManipulation: dataManipulation,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  List<int> getManipulatedIds({
    @required Map<String, dynamic> graphqlResult,
    @required EnumDataManipulation dataManipulation,
  }) {
    if (graphqlResult == null || dataManipulation == null)
      throw ServerException();

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: graphqlResult,
        dataManipulationType: dataManipulation,
        tableName: TableName.dcRoomTableName,
        isSelectUsingView: true,
        viewName: TableName.dcRoomViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(DcRoomModel dcRoom) {
    Map<String, dynamic> variables = dcRoom.toMap();
    variables.removeWhere((key, value) => value == null);
    dcRoomQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcRoomField, dcRoom.toMap());
    dcRoomQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcRoomField, dcRoom.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcRoomModel> dcRoomModels) {
    List<Map<String, dynamic>> fields = [];

    Map<String, dynamic> dcRoomModelMap = Map<String, dynamic>();

    dcRoomModels.forEach((element) async {
      dcRoomModelMap = element.toMap();
      dcRoomModelMap.remove("id");
      dcRoomModelMap.remove("deleted");
      dcRoomModelMap.remove("created");
      dcRoomModelMap.removeWhere((key, value) => value == null);
      fields.add(dcRoomModelMap);
    });

    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(DcRoomModel dcRoom) {
    Map<String, dynamic> variables = dcRoom.toMap();
    variables['_eq'] = dcRoom.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcRoomQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcRoomField, dcRoom.toMap());
    dcRoomQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcRoomField, dcRoom.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcRoom> dcRoom) {
    List<int> ids = [];

    dcRoom.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(List<DcRoom> dcRoom) {
    List<int> ids = [];

    dcRoom.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
