import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_owner.dart';
import '../../domain/entities/dc_owner_plus_filter.dart';
import '../models/dc_owner_model.dart';
import '../models/dc_owner_table_model.dart';
import 'dc_owner_query.dart';

abstract class DcOwnerTableRemoteDataSource {
  Future<DcOwnerTableModel> getAllDataWithFilter(
      DcOwnerPlusFilter dcOwnerPlusFilter);
  Future<List<int>> getIdsFromInserted(DcOwnerModel dcOwnerModel);
  Future<List<int>> getIdsFromCloned(List<DcOwnerModel> dcOwnerModels);
  Future<List<int>> getIdsFromUpdated(DcOwnerModel dcOwnerModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcOwner> dcOwners);
  Future<List<int>> getIdsFromDeleted(List<DcOwner> dcOwners);
}

class DcOwnerTableRemoteDataSourceImpl implements DcOwnerTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcOwnerQuery dcOwnerQuery;

  DcOwnerTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcOwnerQuery,
  });

  @override
  Future<DcOwnerTableModel> getAllDataWithFilter(
      DcOwnerPlusFilter dcOwner) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcOwner);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcOwnerModel dcOwner) async {
    Map<String, dynamic> variables = getPreparedInsertMutationVariable(dcOwner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcOwnerQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcOwnerModel> dcOwner) async {
    Map<String, dynamic> variables = getPreparedCloneMutationVariable(dcOwner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcOwnerQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcOwnerModel dcOwner) async {
    Map<String, dynamic> variables = getPreparedUpdateMutationVariable(dcOwner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcOwnerQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcOwner> dcOwner) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcOwner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcOwnerQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcOwner> dcOwner) async {
    Map<String, dynamic> variables = getPreparedDeleteMutationVariable(dcOwner);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcOwnerQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcOwnerTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcOwnerQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcOwnerQuery.getSelectStatement,
      );
      return DcOwnerTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(DcOwnerPlusFilter dcOwner) {
    String dataFilterByLogicalOperator =
        dcOwner.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcOwner.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcOwner);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcOwner,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcOwnerPlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(DcOwner dcOwner) {
    return [
      getVariableMap("id", "_eq", dcOwner.id),
      getVariableMap(
          "owner", "_ilike", DataHelper.getQueryLikeTextFrom(dcOwner.owner)),
      getVariableMap(
          "image", "_ilike", DataHelper.getQueryLikeTextFrom(dcOwner.image)),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(dcOwner.notes)),
      getVariableMap("deleted", "_eq", dcOwner.deleted),
      getVariableMap("created", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcOwner.created)),
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
        tableName: TableName.dcOwnerTableName,
        isSelectUsingView: true,
        viewName: TableName.dcOwnerViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(DcOwnerModel dcOwner) {
    Map<String, dynamic> variables = dcOwner.toMap();
    variables.removeWhere((key, value) => value == null);
    dcOwnerQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcOwnerField, dcOwner.toMap());
    dcOwnerQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcOwnerField, dcOwner.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcOwnerModel> dcOwnerModels) {
    List<Map<String, dynamic>> fields = [];
    Map<String, dynamic> dcOwnerModelMap = Map<String, dynamic>();

    dcOwnerModels.forEach((element) async {
      dcOwnerModelMap = element.toMap();
      dcOwnerModelMap.remove("id");
      dcOwnerModelMap.remove("deleted");
      dcOwnerModelMap.remove("created");
      dcOwnerModelMap.removeWhere((key, value) => value == null);
      fields.add(dcOwnerModelMap);
    });
    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(DcOwnerModel dcOwner) {
    Map<String, dynamic> variables = dcOwner.toMap();
    variables['_eq'] = dcOwner.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcOwnerQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcOwnerField, dcOwner.toMap());
    dcOwnerQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcOwnerField, dcOwner.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcOwner> dcOwner) {
    List<int> ids = [];

    dcOwner.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<DcOwner> dcOwner) {
    List<int> ids = [];

    dcOwner.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
