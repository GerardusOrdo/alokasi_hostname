import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_room_type.dart';
import '../../domain/entities/dc_room_type_plus_filter.dart';
import '../models/dc_room_type_model.dart';
import '../models/dc_room_type_table_model.dart';
import 'dc_room_type_query.dart';

abstract class DcRoomTypeTableRemoteDataSource {
  Future<DcRoomTypeTableModel> getAllDataWithFilter(
      DcRoomTypePlusFilter dcRoomTypePlusFilter);
  Future<List<int>> getIdsFromInserted(DcRoomTypeModel dcRoomTypeModel);
  Future<List<int>> getIdsFromCloned(List<DcRoomTypeModel> dcRoomTypeModels);
  Future<List<int>> getIdsFromUpdated(DcRoomTypeModel dcRoomTypeModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcRoomType> dcRoomTypes);
  Future<List<int>> getIdsFromDeleted(List<DcRoomType> dcRoomTypes);
}

class DcRoomTypeTableRemoteDataSourceImpl
    implements DcRoomTypeTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcRoomTypeQuery dcRoomTypeQuery;

  DcRoomTypeTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcRoomTypeQuery,
  });

  @override
  Future<DcRoomTypeTableModel> getAllDataWithFilter(
      DcRoomTypePlusFilter dcRoomType) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcRoomType);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcRoomTypeModel dcRoomType) async {
    Map<String, dynamic> variables =
        getPreparedInsertMutationVariable(dcRoomType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomTypeQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcRoomTypeModel> dcRoomType) async {
    Map<String, dynamic> variables =
        getPreparedCloneMutationVariable(dcRoomType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomTypeQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcRoomTypeModel dcRoomType) async {
    Map<String, dynamic> variables =
        getPreparedUpdateMutationVariable(dcRoomType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomTypeQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcRoomType> dcRoomType) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcRoomType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomTypeQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcRoomType> dcRoomType) async {
    Map<String, dynamic> variables =
        getPreparedDeleteMutationVariable(dcRoomType);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcRoomTypeQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcRoomTypeTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcRoomTypeQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcRoomTypeQuery.getSelectStatement,
      );
      return DcRoomTypeTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(
      DcRoomTypePlusFilter dcRoomType) {
    String dataFilterByLogicalOperator =
        dcRoomType.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcRoomType.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcRoomType);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcRoomType,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcRoomTypePlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(DcRoomType dcRoomType) {
    return [
      getVariableMap("id", "_eq", dcRoomType.id),
      getVariableMap("room_type", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcRoomType.roomType)),
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
        tableName: TableName.dcRoomTypeTableName,
        isSelectUsingView: true,
        viewName: TableName.dcRoomTypeViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(
      DcRoomTypeModel dcRoomType) {
    Map<String, dynamic> variables = dcRoomType.toMap();
    variables.removeWhere((key, value) => value == null);
    dcRoomTypeQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcRoomTypeField, dcRoomType.toMap());
    dcRoomTypeQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcRoomTypeField, dcRoomType.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcRoomTypeModel> dcRoomTypeModels) {
    List<Map<String, dynamic>> fields = [];
    Map<String, dynamic> dcRoomTypeModelMap = Map<String, dynamic>();

    dcRoomTypeModels.forEach((element) async {
      dcRoomTypeModelMap = element.toMap();
      dcRoomTypeModelMap.remove("id");
      dcRoomTypeModelMap.remove("deleted");
      dcRoomTypeModelMap.remove("created");
      dcRoomTypeModelMap.removeWhere((key, value) => value == null);
      fields.add(dcRoomTypeModelMap);
    });
    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(
      DcRoomTypeModel dcRoomType) {
    Map<String, dynamic> variables = dcRoomType.toMap();
    variables['_eq'] = dcRoomType.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcRoomTypeQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcRoomTypeField, dcRoomType.toMap());
    dcRoomTypeQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcRoomTypeField, dcRoomType.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcRoomType> dcRoomType) {
    List<int> ids = [];

    dcRoomType.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<DcRoomType> dcRoomType) {
    List<int> ids = [];

    dcRoomType.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
