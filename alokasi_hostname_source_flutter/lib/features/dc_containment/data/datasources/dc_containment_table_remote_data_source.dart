import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_containment.dart';
import '../../domain/entities/dc_containment_plus_filter.dart';
import '../models/dc_containment_model.dart';
import '../models/dc_containment_table_model.dart';
import 'dc_containment_query.dart';

abstract class DcContainmentTableRemoteDataSource {
  Future<DcContainmentTableModel> getAllDataWithFilter(
      DcContainmentPlusFilter dcContainmentPlusFilter);
  Future<List<int>> getIdsFromInserted(DcContainmentModel dcContainmentModel);
  Future<List<int>> getIdsFromCloned(
      List<DcContainmentModel> dcContainmentModels);
  Future<List<int>> getIdsFromUpdated(DcContainmentModel dcContainmentModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcContainment> dcContainments);
  Future<List<int>> getIdsFromDeleted(List<DcContainment> dcContainments);
}

class DcContainmentTableRemoteDataSourceImpl
    implements DcContainmentTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcContainmentQuery dcContainmentQuery;

  DcContainmentTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcContainmentQuery,
  });

  @override
  Future<DcContainmentTableModel> getAllDataWithFilter(
      DcContainmentPlusFilter dcContainment) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcContainment);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcContainmentModel dcContainment) async {
    Map<String, dynamic> variables =
        getPreparedInsertMutationVariable(dcContainment);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcContainmentQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(
      List<DcContainmentModel> dcContainment) async {
    Map<String, dynamic> variables =
        getPreparedCloneMutationVariable(dcContainment);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcContainmentQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcContainmentModel dcContainment) async {
    Map<String, dynamic> variables =
        getPreparedUpdateMutationVariable(dcContainment);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcContainmentQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(
      List<DcContainment> dcContainment) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcContainment);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcContainmentQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcContainment> dcContainment) async {
    Map<String, dynamic> variables =
        getPreparedDeleteMutationVariable(dcContainment);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcContainmentQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcContainmentTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcContainmentQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcContainmentQuery.getSelectStatement,
      );
      return DcContainmentTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(
      DcContainmentPlusFilter dcContainment) {
    String dataFilterByLogicalOperator =
        dcContainment.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcContainment.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcContainment);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcContainment,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcContainmentPlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(
      DcContainment dcContainment) {
    return [
      getVariableMap("id", "_eq", dcContainment.id),
      getVariableMap("id_owner", "_eq", dcContainment.idOwner),
      getVariableMap("owner", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcContainment.owner)),
      getVariableMap("id_dc_room", "_eq", dcContainment.idDcRoom),
      getVariableMap("room_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcContainment.roomName)),
      getVariableMap("topview_facing", "_eq", dcContainment.topviewFacing),
      getVariableMap("containment_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcContainment.containmentName)),
      getVariableMap("x", "_eq", dcContainment.x),
      getVariableMap("y", "_eq", dcContainment.y),
      getVariableMap("width", "_eq", dcContainment.width),
      getVariableMap("height", "_eq", dcContainment.height),
      getVariableMap("is_reserved", "_eq", dcContainment.isReserved),
      getVariableMap("row", "_eq", dcContainment.row),
      getVariableMap("column", "_eq", dcContainment.column),
      getVariableMap("image", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcContainment.image)),
      getVariableMap("notes", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcContainment.notes)),
      getVariableMap("deleted", "_eq", dcContainment.deleted),
      getVariableMap("created", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcContainment.created)),
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
        tableName: TableName.dcContainmentTableName,
        isSelectUsingView: true,
        viewName: TableName.dcContainmentViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(
      DcContainmentModel dcContainment) {
    Map<String, dynamic> variables = dcContainment.toMap();
    variables.removeWhere((key, value) => value == null);
    dcContainmentQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcContainmentField, dcContainment.toMap());
    dcContainmentQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcContainmentField, dcContainment.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcContainmentModel> dcContainmentModels) {
    List<Map<String, dynamic>> fields = [];

    Map<String, dynamic> dcContainmentModelMap = Map<String, dynamic>();

    dcContainmentModels.forEach((element) async {
      dcContainmentModelMap = element.toMap();
      dcContainmentModelMap.remove("id");
      dcContainmentModelMap.remove("deleted");
      dcContainmentModelMap.remove("created");
      dcContainmentModelMap.removeWhere((key, value) => value == null);
      fields.add(dcContainmentModelMap);
    });

    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(
      DcContainmentModel dcContainment) {
    Map<String, dynamic> variables = dcContainment.toMap();
    variables['_eq'] = dcContainment.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcContainmentQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcContainmentField, dcContainment.toMap());
    dcContainmentQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcContainmentField, dcContainment.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcContainment> dcContainment) {
    List<int> ids = [];

    dcContainment.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<DcContainment> dcContainment) {
    List<int> ids = [];

    dcContainment.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
