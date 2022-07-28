import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_hw_model.dart';
import '../../domain/entities/dc_hw_model_plus_filter.dart';
import '../models/dc_hw_model_model.dart';
import '../models/dc_hw_model_table_model.dart';
import 'dc_hw_model_query.dart';

abstract class DcHwModelTableRemoteDataSource {
  Future<DcHwModelTableModel> getAllDataWithFilter(
      DcHwModelPlusFilter dcHwModelPlusFilter);
  Future<List<int>> getIdsFromInserted(DcHwModelModel dcHwModelModel);
  Future<List<int>> getIdsFromCloned(List<DcHwModelModel> dcHwModelModels);
  Future<List<int>> getIdsFromUpdated(DcHwModelModel dcHwModelModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcHwModel> dcHwModels);
  Future<List<int>> getIdsFromDeleted(List<DcHwModel> dcHwModels);
}

class DcHwModelTableRemoteDataSourceImpl
    implements DcHwModelTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcHwModelQuery dcHwModelQuery;

  DcHwModelTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcHwModelQuery,
  });

  @override
  Future<DcHwModelTableModel> getAllDataWithFilter(
      DcHwModelPlusFilter dcHwModel) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcHwModel);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcHwModelModel dcHwModel) async {
    Map<String, dynamic> variables =
        getPreparedInsertMutationVariable(dcHwModel);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwModelQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcHwModelModel> dcHwModel) async {
    Map<String, dynamic> variables =
        getPreparedCloneMutationVariable(dcHwModel);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwModelQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcHwModelModel dcHwModel) async {
    Map<String, dynamic> variables =
        getPreparedUpdateMutationVariable(dcHwModel);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwModelQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcHwModel> dcHwModel) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcHwModel);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwModelQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcHwModel> dcHwModel) async {
    Map<String, dynamic> variables =
        getPreparedDeleteMutationVariable(dcHwModel);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwModelQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcHwModelTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcHwModelQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcHwModelQuery.getSelectStatement,
      );
      return DcHwModelTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(
      DcHwModelPlusFilter dcHwModel) {
    String dataFilterByLogicalOperator =
        dcHwModel.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcHwModel.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcHwModel);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcHwModel,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcHwModelPlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(DcHwModel dcHwModel) {
    return [
      getVariableMap("id", "_eq", dcHwModel.id),
      getVariableMap("hw_model", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHwModel.hwModel)),
      getVariableMap(
          "image", "_ilike", DataHelper.getQueryLikeTextFrom(dcHwModel.image)),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(dcHwModel.notes)),
      getVariableMap("deleted", "_eq", dcHwModel.deleted),
      getVariableMap("created", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHwModel.created)),
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
        tableName: TableName.dcHwModelTableName,
        isSelectUsingView: true,
        viewName: TableName.dcHwModelViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(
      DcHwModelModel dcHwModel) {
    Map<String, dynamic> variables = dcHwModel.toMap();
    variables.removeWhere((key, value) => value == null);
    dcHwModelQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcHwModelField, dcHwModel.toMap());
    dcHwModelQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcHwModelField, dcHwModel.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcHwModelModel> dcHwModelModels) {
    List<Map<String, dynamic>> fields = [];
    Map<String, dynamic> dcHwModelModelMap = Map<String, dynamic>();

    dcHwModelModels.forEach((element) async {
      dcHwModelModelMap = element.toMap();
      dcHwModelModelMap.remove("id");
      dcHwModelModelMap.remove("deleted");
      dcHwModelModelMap.remove("created");
      dcHwModelModelMap.removeWhere((key, value) => value == null);
      fields.add(dcHwModelModelMap);
    });
    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(
      DcHwModelModel dcHwModel) {
    Map<String, dynamic> variables = dcHwModel.toMap();
    variables['_eq'] = dcHwModel.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcHwModelQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcHwModelField, dcHwModel.toMap());
    dcHwModelQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcHwModelField, dcHwModel.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcHwModel> dcHwModel) {
    List<int> ids = [];

    dcHwModel.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<DcHwModel> dcHwModel) {
    List<int> ids = [];

    dcHwModel.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
