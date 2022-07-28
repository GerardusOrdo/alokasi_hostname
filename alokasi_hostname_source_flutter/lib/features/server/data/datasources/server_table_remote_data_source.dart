import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/server.dart';
import '../../domain/entities/server_plus_filter.dart';
import '../models/server_model.dart';
import '../models/server_table_model.dart';
import 'server_query.dart';

abstract class ServerTableRemoteDataSource {
  Future<ServerTableModel> getAllDataWithFilter(
      ServerPlusFilter serverPlusFilter);
  Future<List<int>> getIdsFromInserted(ServerModel serverModel);
  Future<List<int>> getIdsFromCloned(List<ServerModel> serverModels);
  Future<List<int>> getIdsFromUpdated(ServerModel serverModel);
  Future<List<int>> getIdsFromSetToDeleted(List<Server> servers);
  Future<List<int>> getIdsFromDeleted(List<Server> servers);
}

class ServerTableRemoteDataSourceImpl implements ServerTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final ServerQuery serverQuery;

  ServerTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.serverQuery,
  });

  @override
  Future<ServerTableModel> getAllDataWithFilter(ServerPlusFilter server) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(server);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(ServerModel server) async {
    Map<String, dynamic> variables = getPreparedInsertMutationVariable(server);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: serverQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<ServerModel> server) async {
    Map<String, dynamic> variables = getPreparedCloneMutationVariable(server);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: serverQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(ServerModel server) async {
    Map<String, dynamic> variables = getPreparedUpdateMutationVariable(server);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: serverQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<Server> server) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(server);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: serverQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<Server> server) async {
    Map<String, dynamic> variables = getPreparedDeleteMutationVariable(server);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: serverQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<ServerTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(serverQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: serverQuery.getSelectStatement,
      );
      return ServerTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(ServerPlusFilter server) {
    String dataFilterByLogicalOperator =
        server.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = server.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(server);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: server,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required ServerPlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(ServerPlusFilter server) {
    print(server.powerOnDateFrom);
    print(server.powerOnDateTo);
    return [
      getVariableMap("id", "_eq", server.id),
      getVariableMap("id_owner", "_eq", server.idOwner),
      getVariableMap(
          "owner", "_ilike", DataHelper.getQueryLikeTextFrom(server.owner)),
      getVariableMap("server_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(server.serverName)),
      getVariableMap(
          "ip", "_ilike", DataHelper.getQueryLikeTextFrom(server.ip)),
      getVariableMap("status", "_eq", server.status),
      getVariableMap("power_on_date", "_gte", server.powerOnDateFrom),
      getVariableMap("power_on_date", "_lte", server.powerOnDateTo),
      getVariableMap("user_notif_date", "_gte", server.userNotifDateFrom),
      getVariableMap("user_notif_date", "_lte", server.userNotifDateTo),
      getVariableMap("power_off_date", "_gte", server.powerOffDateFrom),
      getVariableMap("power_off_date", "_lte", server.powerOffDateTo),
      getVariableMap("delete_date", "_gte", server.deleteDateFrom),
      getVariableMap("delete_date", "_lte", server.deleteDateTo),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(server.notes)),
      getVariableMap("deleted", "_eq", server.deleted),
      getVariableMap(
          "created", "_ilike", DataHelper.getQueryLikeTextFrom(server.created)),
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
        tableName: TableName.serverTableName,
        isSelectUsingView: true,
        viewName: TableName.serverViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(ServerModel server) {
    Map<String, dynamic> variables = server.toMap();
    variables.removeWhere((key, value) => value == null);
    serverQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.serverField, server.toMap());
    serverQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.serverField, server.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<ServerModel> serverModels) {
    List<Map<String, dynamic>> fields = [];

    Map<String, dynamic> serverModelMap = Map<String, dynamic>();

    serverModels.forEach((element) async {
      serverModelMap = element.toMap();
      serverModelMap.remove("id");
      serverModelMap.remove("deleted");
      serverModelMap.remove("created");
      serverModelMap.removeWhere((key, value) => value == null);
      fields.add(serverModelMap);
    });

    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(ServerModel server) {
    Map<String, dynamic> variables = server.toMap();
    variables['_eq'] = server.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    serverQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.serverField, server.toMap());
    serverQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.serverField, server.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<Server> server) {
    List<int> ids = [];

    server.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(List<Server> server) {
    List<int> ids = [];

    server.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
