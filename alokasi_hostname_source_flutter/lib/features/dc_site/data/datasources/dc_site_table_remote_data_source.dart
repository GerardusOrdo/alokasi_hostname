import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_site.dart';
import '../../domain/entities/dc_site_plus_filter.dart';
import '../models/dc_site_model.dart';
import '../models/dc_site_table_model.dart';
import 'dc_site_query.dart';

abstract class DcSiteTableRemoteDataSource {
  Future<DcSiteTableModel> getAllDataWithFilter(
      DcSitePlusFilter dcSitePlusFilter);
  Future<List<int>> getIdsFromInserted(DcSiteModel dcSiteModel);
  Future<List<int>> getIdsFromCloned(List<DcSiteModel> dcSiteModels);
  Future<List<int>> getIdsFromUpdated(DcSiteModel dcSiteModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcSite> dcSites);
  Future<List<int>> getIdsFromDeleted(List<DcSite> dcSites);
}

class DcSiteTableRemoteDataSourceImpl implements DcSiteTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcSiteQuery dcSiteQuery;

  DcSiteTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcSiteQuery,
  });

  @override
  Future<DcSiteTableModel> getAllDataWithFilter(DcSitePlusFilter dcSite) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcSite);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcSiteModel dcSite) async {
    Map<String, dynamic> variables = getPreparedInsertMutationVariable(dcSite);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcSiteQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcSiteModel> dcSite) async {
    Map<String, dynamic> variables = getPreparedCloneMutationVariable(dcSite);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcSiteQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcSiteModel dcSite) async {
    Map<String, dynamic> variables = getPreparedUpdateMutationVariable(dcSite);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcSiteQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcSite> dcSite) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcSite);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcSiteQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcSite> dcSite) async {
    Map<String, dynamic> variables = getPreparedDeleteMutationVariable(dcSite);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcSiteQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcSiteTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcSiteQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcSiteQuery.getSelectStatement,
      );
      return DcSiteTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(DcSitePlusFilter dcSite) {
    String dataFilterByLogicalOperator =
        dcSite.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcSite.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcSite);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcSite,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcSitePlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(DcSite dcSite) {
    return [
      getVariableMap("id", "_eq", dcSite.id),
      getVariableMap("id_owner", "_eq", dcSite.idOwner),
      getVariableMap(
          "owner", "_ilike", DataHelper.getQueryLikeTextFrom(dcSite.owner)),
      getVariableMap("dc_site_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcSite.dcSiteName)),
      getVariableMap(
          "address", "_ilike", DataHelper.getQueryLikeTextFrom(dcSite.address)),
      getVariableMap(
          "map", "_ilike", DataHelper.getQueryLikeTextFrom(dcSite.map)),
      getVariableMap("width", "_eq", dcSite.width),
      getVariableMap("height", "_eq", dcSite.height),
      getVariableMap(
          "image", "_ilike", DataHelper.getQueryLikeTextFrom(dcSite.image)),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(dcSite.notes)),
      getVariableMap("deleted", "_eq", dcSite.deleted),
      getVariableMap(
          "created", "_ilike", DataHelper.getQueryLikeTextFrom(dcSite.created)),
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
        tableName: TableName.dcSiteTableName,
        isSelectUsingView: true,
        viewName: TableName.dcSiteViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(DcSiteModel dcSite) {
    Map<String, dynamic> variables = dcSite.toMap();
    variables.removeWhere((key, value) => value == null);
    dcSiteQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcSiteField, dcSite.toMap());
    dcSiteQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcSiteField, dcSite.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcSiteModel> dcSiteModels) {
    List<Map<String, dynamic>> fields = [];

    Map<String, dynamic> dcSiteModelMap = Map<String, dynamic>();

    dcSiteModels.forEach((element) async {
      dcSiteModelMap = element.toMap();
      dcSiteModelMap.remove("id");
      dcSiteModelMap.remove("deleted");
      dcSiteModelMap.remove("created");
      dcSiteModelMap.removeWhere((key, value) => value == null);
      fields.add(dcSiteModelMap);
    });

    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(DcSiteModel dcSite) {
    Map<String, dynamic> variables = dcSite.toMap();
    variables['_eq'] = dcSite.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcSiteQuery.graphqlVariable =
        DataHelper.getGraphqlVariable(FieldName.dcSiteField, dcSite.toMap());
    dcSiteQuery.graphqlArgument =
        DataHelper.getGraphqlArgument(FieldName.dcSiteField, dcSite.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcSite> dcSite) {
    List<int> ids = [];

    dcSite.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(List<DcSite> dcSite) {
    List<int> ids = [];

    dcSite.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
