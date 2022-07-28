import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_mounted_form.dart';
import '../../domain/entities/dc_mounted_form_plus_filter.dart';
import '../models/dc_mounted_form_model.dart';
import '../models/dc_mounted_form_table_model.dart';
import 'dc_mounted_form_query.dart';

abstract class DcMountedFormTableRemoteDataSource {
  Future<DcMountedFormTableModel> getAllDataWithFilter(
      DcMountedFormPlusFilter dcMountedFormPlusFilter);
  Future<List<int>> getIdsFromInserted(DcMountedFormModel dcMountedFormModel);
  Future<List<int>> getIdsFromCloned(
      List<DcMountedFormModel> dcMountedFormModels);
  Future<List<int>> getIdsFromUpdated(DcMountedFormModel dcMountedFormModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcMountedForm> dcMountedForms);
  Future<List<int>> getIdsFromDeleted(List<DcMountedForm> dcMountedForms);
}

class DcMountedFormTableRemoteDataSourceImpl
    implements DcMountedFormTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcMountedFormQuery dcMountedFormQuery;

  DcMountedFormTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcMountedFormQuery,
  });

  @override
  Future<DcMountedFormTableModel> getAllDataWithFilter(
      DcMountedFormPlusFilter dcMountedForm) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcMountedForm);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcMountedFormModel dcMountedForm) async {
    Map<String, dynamic> variables =
        getPreparedInsertMutationVariable(dcMountedForm);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcMountedFormQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(
      List<DcMountedFormModel> dcMountedForm) async {
    Map<String, dynamic> variables =
        getPreparedCloneMutationVariable(dcMountedForm);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcMountedFormQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcMountedFormModel dcMountedForm) async {
    Map<String, dynamic> variables =
        getPreparedUpdateMutationVariable(dcMountedForm);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcMountedFormQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(
      List<DcMountedForm> dcMountedForm) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcMountedForm);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcMountedFormQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcMountedForm> dcMountedForm) async {
    Map<String, dynamic> variables =
        getPreparedDeleteMutationVariable(dcMountedForm);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcMountedFormQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcMountedFormTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcMountedFormQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcMountedFormQuery.getSelectStatement,
      );
      return DcMountedFormTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(
      DcMountedFormPlusFilter dcMountedForm) {
    String dataFilterByLogicalOperator =
        dcMountedForm.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcMountedForm.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcMountedForm);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcMountedForm,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcMountedFormPlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(
      DcMountedForm dcMountedForm) {
    return [
      getVariableMap("id", "_eq", dcMountedForm.id),
      getVariableMap("mounted_form", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcMountedForm.mountedForm)),
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
        tableName: TableName.dcMountedFormTableName,
        isSelectUsingView: true,
        viewName: TableName.dcMountedFormViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(
      DcMountedFormModel dcMountedForm) {
    Map<String, dynamic> variables = dcMountedForm.toMap();
    variables.removeWhere((key, value) => value == null);
    dcMountedFormQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcMountedFormField, dcMountedForm.toMap());
    dcMountedFormQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcMountedFormField, dcMountedForm.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcMountedFormModel> dcMountedFormModels) {
    List<Map<String, dynamic>> fields = [];
    Map<String, dynamic> dcMountedFormModelMap = Map<String, dynamic>();

    dcMountedFormModels.forEach((element) async {
      dcMountedFormModelMap = element.toMap();
      dcMountedFormModelMap.remove("id");
      dcMountedFormModelMap.remove("deleted");
      dcMountedFormModelMap.remove("created");
      dcMountedFormModelMap.removeWhere((key, value) => value == null);
      fields.add(dcMountedFormModelMap);
    });
    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(
      DcMountedFormModel dcMountedForm) {
    Map<String, dynamic> variables = dcMountedForm.toMap();
    variables['_eq'] = dcMountedForm.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcMountedFormQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcMountedFormField, dcMountedForm.toMap());
    dcMountedFormQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcMountedFormField, dcMountedForm.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcMountedForm> dcMountedForm) {
    List<int> ids = [];

    dcMountedForm.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<DcMountedForm> dcMountedForm) {
    List<int> ids = [];

    dcMountedForm.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
