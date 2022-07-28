import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_brand.dart';
import '../../domain/entities/dc_brand_plus_filter.dart';
import '../models/dc_brand_model.dart';
import '../models/dc_brand_table_model.dart';
import 'dc_brand_query.dart';

abstract class DcBrandTableRemoteDataSource {
  Future<DcBrandTableModel> getAllDataWithFilter(
      DcBrandPlusFilter dcBrandPlusFilter);
  Future<List<int>> getIdsFromInserted(DcBrandModel dcBrandModel);
  Future<List<int>> getIdsFromCloned(List<DcBrandModel> dcBrandModels);
  Future<List<int>> getIdsFromUpdated(DcBrandModel dcBrandModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcBrand> dcBrands);
  Future<List<int>> getIdsFromDeleted(List<DcBrand> dcBrands);
}

class DcBrandTableRemoteDataSourceImpl implements DcBrandTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcBrandQuery dcBrandQuery;

  DcBrandTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcBrandQuery,
  });

  @override
  Future<DcBrandTableModel> getAllDataWithFilter(
      DcBrandPlusFilter dcBrand) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcBrand);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcBrandModel dcBrand) async {
    Map<String, dynamic> variables = getPreparedInsertMutationVariable(dcBrand);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcBrandQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcBrandModel> dcBrand) async {
    Map<String, dynamic> variables = getPreparedCloneMutationVariable(dcBrand);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcBrandQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcBrandModel dcBrand) async {
    Map<String, dynamic> variables = getPreparedUpdateMutationVariable(dcBrand);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcBrandQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcBrand> dcBrand) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcBrand);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcBrandQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcBrand> dcBrand) async {
    Map<String, dynamic> variables = getPreparedDeleteMutationVariable(dcBrand);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcBrandQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcBrandTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcBrandQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcBrandQuery.getSelectStatement,
      );
      return DcBrandTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(DcBrandPlusFilter dcBrand) {
    String dataFilterByLogicalOperator =
        dcBrand.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcBrand.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcBrand);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcBrand,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcBrandPlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(DcBrand dcBrand) {
    return [
      getVariableMap("id", "_eq", dcBrand.id),
      getVariableMap(
          "brand", "_ilike", DataHelper.getQueryLikeTextFrom(dcBrand.brand)),
      getVariableMap(
          "image", "_ilike", DataHelper.getQueryLikeTextFrom(dcBrand.image)),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(dcBrand.notes)),
      getVariableMap("deleted", "_eq", dcBrand.deleted),
      getVariableMap("created", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcBrand.created)),
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
        tableName: TableName.dcBrandTableName,
        isSelectUsingView: true,
        viewName: TableName.dcBrandViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(DcBrandModel dcBrand) {
    Map<String, dynamic> variables = dcBrand.toMap();
    variables.removeWhere((key, value) => value == null);
    dcBrandQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcBrandField, dcBrand.toMap());
    dcBrandQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcBrandField, dcBrand.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcBrandModel> dcBrandModels) {
    List<Map<String, dynamic>> fields = [];
    Map<String, dynamic> dcBrandModelMap = Map<String, dynamic>();

    dcBrandModels.forEach((element) async {
      dcBrandModelMap = element.toMap();
      dcBrandModelMap.remove("id");
      dcBrandModelMap.remove("deleted");
      dcBrandModelMap.remove("created");
      dcBrandModelMap.removeWhere((key, value) => value == null);
      fields.add(dcBrandModelMap);
    });
    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(DcBrandModel dcBrand) {
    Map<String, dynamic> variables = dcBrand.toMap();
    variables['_eq'] = dcBrand.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcBrandQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcBrandField, dcBrand.toMap());
    dcBrandQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcBrandField, dcBrand.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcBrand> dcBrand) {
    List<int> ids = [];

    dcBrand.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<DcBrand> dcBrand) {
    List<int> ids = [];

    dcBrand.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
