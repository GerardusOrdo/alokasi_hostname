import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_hw_type.dart';
import '../../domain/entities/dc_hw_type_plus_filter.dart';
import '../models/dc_hw_type_model.dart';
import '../models/dc_hw_type_table_model.dart';
import 'dc_hw_type_query.dart';

abstract class DcHwTypeTableRemoteDataSource {
  Future<DcHwTypeTableModel> getAllDataWithFilter(
      DcHwTypePlusFilter dcHwTypePlusFilter);
  Future<List<int>> getIdsFromInserted(DcHwTypeModel dcHwTypeModel);
  Future<List<int>> getIdsFromCloned(List<DcHwTypeModel> dcHwTypeModels);
  Future<List<int>> getIdsFromUpdated(DcHwTypeModel dcHwTypeModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcHwType> dcHwTypes);
  Future<List<int>> getIdsFromDeleted(List<DcHwType> dcHwTypes);
}

class DcHwTypeTableRemoteDataSourceImpl
    implements DcHwTypeTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcHwTypeQuery dcHwTypeQuery;

  DcHwTypeTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcHwTypeQuery,
  });

  @override
  Future<DcHwTypeTableModel> getAllDataWithFilter(
      DcHwTypePlusFilter dcHwType) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcHwType);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcHwTypeModel dcHwType) async {
    Map<String, dynamic> variables =
        getPreparedInsertMutationVariable(dcHwType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwTypeQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcHwTypeModel> dcHwType) async {
    Map<String, dynamic> variables = getPreparedCloneMutationVariable(dcHwType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwTypeQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcHwTypeModel dcHwType) async {
    Map<String, dynamic> variables =
        getPreparedUpdateMutationVariable(dcHwType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwTypeQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcHwType> dcHwType) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcHwType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwTypeQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcHwType> dcHwType) async {
    Map<String, dynamic> variables =
        getPreparedDeleteMutationVariable(dcHwType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHwTypeQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcHwTypeTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcHwTypeQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcHwTypeQuery.getSelectStatement,
      );
      return DcHwTypeTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(DcHwTypePlusFilter dcHwType) {
    String dataFilterByLogicalOperator =
        dcHwType.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcHwType.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcHwType);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcHwType,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcHwTypePlusFilter fields,
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
          // {
          //   "deleted": {"_eq": false}
          // }
        ],
      }
    };
  }

  List<Map<String, dynamic>> getQueryFieldVariables(DcHwType dcHwType) {
    return [
      getVariableMap("id", "_eq", dcHwType.id),
      getVariableMap("hw_type", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHwType.hwType)),
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
        tableName: TableName.dcHwTypeTableName,
        isSelectUsingView: true,
        viewName: TableName.dcHwTypeViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(
      DcHwTypeModel dcHwType) {
    Map<String, dynamic> variables = dcHwType.toMap();
    variables.removeWhere((key, value) => value == null);
    dcHwTypeQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcHwTypeField, dcHwType.toMap());
    dcHwTypeQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcHwTypeField, dcHwType.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcHwTypeModel> dcHwTypeModels) {
    List<Map<String, dynamic>> fields = [];
    Map<String, dynamic> dcHwTypeModelMap = Map<String, dynamic>();

    dcHwTypeModels.forEach((element) async {
      dcHwTypeModelMap = element.toMap();
      dcHwTypeModelMap.remove("id");
      dcHwTypeModelMap.remove("deleted");
      dcHwTypeModelMap.remove("created");
      dcHwTypeModelMap.removeWhere((key, value) => value == null);
      fields.add(dcHwTypeModelMap);
    });
    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(
      DcHwTypeModel dcHwType) {
    Map<String, dynamic> variables = dcHwType.toMap();
    variables['_eq'] = dcHwType.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcHwTypeQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcHwTypeField, dcHwType.toMap());
    dcHwTypeQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcHwTypeField, dcHwType.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcHwType> dcHwType) {
    List<int> ids = [];

    dcHwType.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<DcHwType> dcHwType) {
    List<int> ids = [];

    dcHwType.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
