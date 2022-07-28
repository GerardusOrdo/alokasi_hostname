import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_rack.dart';
import '../../domain/entities/dc_rack_plus_filter.dart';
import '../models/dc_rack_model.dart';
import '../models/dc_rack_table_model.dart';
import 'dc_rack_query.dart';

abstract class DcRackTableRemoteDataSource {
  Future<DcRackTableModel> getAllDataWithFilter(
      DcRackPlusFilter dcRackPlusFilter);
  Future<List<int>> getIdsFromInserted(DcRackModel dcRackModel);
  Future<List<int>> getIdsFromCloned(List<DcRackModel> dcRackModels);
  Future<List<int>> getIdsFromUpdated(DcRackModel dcRackModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcRack> dcRacks);
  Future<List<int>> getIdsFromDeleted(List<DcRack> dcRacks);
}

class DcRackTableRemoteDataSourceImpl implements DcRackTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcRackQuery dcRackQuery;

  DcRackTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcRackQuery,
  });

  @override
  Future<DcRackTableModel> getAllDataWithFilter(DcRackPlusFilter dcRack) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcRack);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcRackModel dcRack) async {
    Map<String, dynamic> variables = getPreparedInsertMutationVariable(dcRack);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRackQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcRackModel> dcRack) async {
    Map<String, dynamic> variables = getPreparedCloneMutationVariable(dcRack);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRackQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcRackModel dcRack) async {
    Map<String, dynamic> variables = getPreparedUpdateMutationVariable(dcRack);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRackQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcRack> dcRack) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcRack);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRackQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcRack> dcRack) async {
    Map<String, dynamic> variables = getPreparedDeleteMutationVariable(dcRack);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRackQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcRackTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcRackQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcRackQuery.getSelectStatement,
      );
      return DcRackTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(DcRackPlusFilter dcRack) {
    String dataFilterByLogicalOperator =
        dcRack.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcRack.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcRack);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcRack,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcRackPlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(DcRack dcRack) {
    return [
      getVariableMap("id", "_eq", dcRack.id),
      getVariableMap("id_owner", "_eq", dcRack.idOwner),
      getVariableMap(
          "owner", "_ilike", DataHelper.getQueryLikeTextFrom(dcRack.owner)),
      getVariableMap("id_room", "_eq", dcRack.idRoom),
      getVariableMap("room_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcRack.roomName)),
      getVariableMap("id_containment", "_eq", dcRack.idContainment),
      getVariableMap("containment_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcRack.containmentName)),
      getVariableMap("topview_facing", "_eq", dcRack.topviewFacing),
      getVariableMap("rack_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcRack.rackName)),
      getVariableMap("description", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcRack.description)),
      getVariableMap("x", "_eq", dcRack.x),
      getVariableMap("y", "_eq", dcRack.y),
      getVariableMap("max_u_height", "_eq", dcRack.maxUHeight),
      getVariableMap("require_position", "_eq", dcRack.requirePosition),
      getVariableMap("width", "_eq", dcRack.width),
      getVariableMap("height", "_eq", dcRack.height),
      getVariableMap("is_reserved", "_eq", dcRack.isReserved),
      getVariableMap(
          "image", "_ilike", DataHelper.getQueryLikeTextFrom(dcRack.image)),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(dcRack.notes)),
      getVariableMap("deleted", "_eq", dcRack.deleted),
      getVariableMap(
          "created", "_ilike", DataHelper.getQueryLikeTextFrom(dcRack.created)),
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
        tableName: TableName.dcRackTableName,
        isSelectUsingView: true,
        viewName: TableName.dcRackViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(DcRackModel dcRack) {
    Map<String, dynamic> variables = dcRack.toMap();
    variables.removeWhere((key, value) => value == null);
    dcRackQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcRackField, dcRack.toMap());
    dcRackQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcRackField, dcRack.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcRackModel> dcRackModels) {
    List<Map<String, dynamic>> fields = [];

    Map<String, dynamic> dcRackModelMap = Map<String, dynamic>();

    dcRackModels.forEach((element) async {
      dcRackModelMap = element.toMap();
      dcRackModelMap.remove("id");
      dcRackModelMap.remove("deleted");
      dcRackModelMap.remove("created");
      dcRackModelMap.removeWhere((key, value) => value == null);
      fields.add(dcRackModelMap);
    });

    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(DcRackModel dcRack) {
    Map<String, dynamic> variables = dcRack.toMap();
    variables['_eq'] = dcRack.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcRackQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcRackField, dcRack.toMap());
    dcRackQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcRackField, dcRack.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcRack> dcRack) {
    List<int> ids = [];

    dcRack.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(List<DcRack> dcRack) {
    List<int> ids = [];

    dcRack.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
