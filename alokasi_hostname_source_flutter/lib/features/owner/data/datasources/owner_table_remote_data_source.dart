import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/owner.dart';
import '../../domain/entities/owner_plus_filter.dart';
import '../models/owner_model.dart';
import '../models/owner_table_model.dart';
import 'owner_query.dart';

abstract class OwnerTableRemoteDataSource {
  Future<OwnerTableModel> getAllDataWithFilter(OwnerPlusFilter ownerPlusFilter);
  Future<List<int>> getIdsFromInserted(OwnerModel ownerModel);
  Future<List<int>> getIdsFromCloned(List<OwnerModel> ownerModels);
  Future<List<int>> getIdsFromUpdated(OwnerModel ownerModel);
  Future<List<int>> getIdsFromSetToDeleted(List<Owner> owners);
  Future<List<int>> getIdsFromDeleted(List<Owner> owners);
}

class OwnerTableRemoteDataSourceImpl implements OwnerTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final OwnerQuery ownerQuery;

  OwnerTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.ownerQuery,
  });

  @override
  Future<OwnerTableModel> getAllDataWithFilter(OwnerPlusFilter owner) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(owner);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(OwnerModel owner) async {
    Map<String, dynamic> variables = getPreparedInsertMutationVariable(owner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: ownerQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<OwnerModel> owner) async {
    Map<String, dynamic> variables = getPreparedCloneMutationVariable(owner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: ownerQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(OwnerModel owner) async {
    Map<String, dynamic> variables = getPreparedUpdateMutationVariable(owner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: ownerQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<Owner> owner) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(owner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: ownerQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<Owner> owner) async {
    Map<String, dynamic> variables = getPreparedDeleteMutationVariable(owner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: ownerQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<OwnerTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(ownerQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: ownerQuery.getSelectStatement,
      );
      return OwnerTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(OwnerPlusFilter owner) {
    String dataFilterByLogicalOperator =
        owner.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = owner.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(owner);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: owner,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required OwnerPlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(Owner owner) {
    return [
      getVariableMap("id", "_eq", owner.id),
      getVariableMap(
          "owner", "_ilike", DataHelper.getQueryLikeTextFrom(owner.owner)),
      getVariableMap(
          "email", "_ilike", DataHelper.getQueryLikeTextFrom(owner.email)),
      getVariableMap(
          "phone", "_ilike", DataHelper.getQueryLikeTextFrom(owner.phone)),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(owner.notes)),
      getVariableMap("deleted", "_eq", owner.deleted),
      getVariableMap(
          "created", "_ilike", DataHelper.getQueryLikeTextFrom(owner.created)),
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
        tableName: TableName.ownerTableName,
        isSelectUsingView: true,
        viewName: TableName.ownerViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(OwnerModel owner) {
    Map<String, dynamic> variables = owner.toMap();
    variables.removeWhere((key, value) => value == null);
    ownerQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.ownerField, owner.toMap());
    ownerQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.ownerField, owner.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<OwnerModel> ownerModels) {
    List<Map<String, dynamic>> fields = [];
    Map<String, dynamic> ownerModelMap = Map<String, dynamic>();

    ownerModels.forEach((element) async {
      ownerModelMap = element.toMap();
      ownerModelMap.remove("id");
      ownerModelMap.remove("deleted");
      ownerModelMap.remove("created");
      ownerModelMap.removeWhere((key, value) => value == null);
      fields.add(ownerModelMap);
    });
    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(OwnerModel owner) {
    Map<String, dynamic> variables = owner.toMap();
    variables['_eq'] = owner.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    ownerQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.ownerField, owner.toMap());
    ownerQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.ownerField, owner.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(List<Owner> owner) {
    List<int> ids = [];

    owner.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(List<Owner> owner) {
    List<int> ids = [];

    owner.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
