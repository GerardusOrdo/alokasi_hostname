import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/email_schedule.dart';
import '../../domain/entities/email_schedule_plus_filter.dart';
import '../models/email_schedule_model.dart';
import '../models/email_schedule_table_model.dart';
import 'email_schedule_query.dart';

abstract class EmailScheduleTableRemoteDataSource {
  Future<EmailScheduleTableModel> getAllDataWithFilter(
      EmailSchedulePlusFilter emailSchedulePlusFilter);
  Future<List<int>> getIdsFromInserted(EmailScheduleModel emailScheduleModel);
  Future<List<int>> getIdsFromCloned(
      List<EmailScheduleModel> emailScheduleModels);
  Future<List<int>> getIdsFromUpdated(EmailScheduleModel emailScheduleModel);
  Future<List<int>> getIdsFromSetToDeleted(List<EmailSchedule> emailSchedules);
  Future<List<int>> getIdsFromDeleted(List<EmailSchedule> emailSchedules);
}

class EmailScheduleTableRemoteDataSourceImpl
    implements EmailScheduleTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final EmailScheduleQuery emailScheduleQuery;

  EmailScheduleTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.emailScheduleQuery,
  });

  @override
  Future<EmailScheduleTableModel> getAllDataWithFilter(
      EmailSchedulePlusFilter emailSchedule) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(emailSchedule);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(EmailScheduleModel emailSchedule) async {
    Map<String, dynamic> variables =
        getPreparedInsertMutationVariable(emailSchedule);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: emailScheduleQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(
      List<EmailScheduleModel> emailSchedule) async {
    Map<String, dynamic> variables =
        getPreparedCloneMutationVariable(emailSchedule);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: emailScheduleQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(EmailScheduleModel emailSchedule) async {
    Map<String, dynamic> variables =
        getPreparedUpdateMutationVariable(emailSchedule);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: emailScheduleQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(
      List<EmailSchedule> emailSchedule) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(emailSchedule);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: emailScheduleQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<EmailSchedule> emailSchedule) async {
    Map<String, dynamic> variables =
        getPreparedDeleteMutationVariable(emailSchedule);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: emailScheduleQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<EmailScheduleTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(emailScheduleQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: emailScheduleQuery.getSelectStatement,
      );
      return EmailScheduleTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(
      EmailSchedulePlusFilter emailSchedule) {
    String dataFilterByLogicalOperator =
        emailSchedule.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = emailSchedule.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(emailSchedule);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: emailSchedule,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required EmailSchedulePlusFilter fields,
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
      EmailSchedulePlusFilter emailSchedule) {
    return [
      getVariableMap("id", "_eq", emailSchedule.id),
      getVariableMap("id_server", "_eq", emailSchedule.idServer),
      getVariableMap("server_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(emailSchedule.serverName)),
      getVariableMap(
          "ip", "_ilike", DataHelper.getQueryLikeTextFrom(emailSchedule.ip)),
      getVariableMap("owner", "_ilike",
          DataHelper.getQueryLikeTextFrom(emailSchedule.owner)),
      getVariableMap("email", "_ilike",
          DataHelper.getQueryLikeTextFrom(emailSchedule.email)),
      // getVariableMap("date", "_ilike",
      //     DataHelper.getQueryLikeTextFrom(emailSchedule.date)),
      getVariableMap("date", "_gte", emailSchedule.dateFrom),
      getVariableMap("date", "_lte", emailSchedule.dateTo),
      getVariableMap("state", "_eq", emailSchedule.state),
      getVariableMap("status", "_eq", emailSchedule.status),
      getVariableMap("notes", "_ilike",
          DataHelper.getQueryLikeTextFrom(emailSchedule.notes)),
      getVariableMap("created", "_ilike",
          DataHelper.getQueryLikeTextFrom(emailSchedule.created)),
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
        tableName: TableName.emailScheduleTableName,
        isSelectUsingView: true,
        viewName: TableName.emailScheduleViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(
      EmailScheduleModel emailSchedule) {
    Map<String, dynamic> variables = emailSchedule.toMap();
    variables.removeWhere((key, value) => value == null);
    emailScheduleQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.emailScheduleField, emailSchedule.toMap());
    emailScheduleQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.emailScheduleField, emailSchedule.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<EmailScheduleModel> emailScheduleModels) {
    List<Map<String, dynamic>> fields = [];

    Map<String, dynamic> emailScheduleModelMap = Map<String, dynamic>();

    emailScheduleModels.forEach((element) async {
      emailScheduleModelMap = element.toMap();
      emailScheduleModelMap.remove("id");
      emailScheduleModelMap.remove("deleted");
      emailScheduleModelMap.remove("created");
      emailScheduleModelMap.removeWhere((key, value) => value == null);
      fields.add(emailScheduleModelMap);
    });

    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(
      EmailScheduleModel emailSchedule) {
    Map<String, dynamic> variables = emailSchedule.toMap();
    variables['_eq'] = emailSchedule.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    emailScheduleQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.emailScheduleField, emailSchedule.toMap());
    emailScheduleQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.emailScheduleField, emailSchedule.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<EmailSchedule> emailSchedule) {
    List<int> ids = [];

    emailSchedule.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids}; //'deleted': true
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<EmailSchedule> emailSchedule) {
    List<int> ids = [];

    emailSchedule.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
