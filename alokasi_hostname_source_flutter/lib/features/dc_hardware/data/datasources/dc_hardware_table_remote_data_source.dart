import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/settings/settings.dart';
import '../../domain/entities/dc_hardware.dart';
import '../../domain/entities/dc_hardware_plus_filter.dart';
import '../models/dc_hardware_model.dart';
import '../models/dc_hardware_table_model.dart';
import 'dc_hardware_query.dart';

abstract class DcHardwareTableRemoteDataSource {
  Future<DcHardwareTableModel> getAllDataWithFilter(
      DcHardwarePlusFilter dcHardwarePlusFilter);
  Future<List<int>> getIdsFromInserted(DcHardwareModel dcHardwareModel);
  Future<List<int>> getIdsFromCloned(List<DcHardwareModel> dcHardwareModels);
  Future<List<int>> getIdsFromUpdated(DcHardwareModel dcHardwareModel);
  Future<List<int>> getIdsFromSetToDeleted(List<DcHardware> dcHardwares);
  Future<List<int>> getIdsFromDeleted(List<DcHardware> dcHardwares);
}

class DcHardwareTableRemoteDataSourceImpl
    implements DcHardwareTableRemoteDataSource {
  final HasuraConnect graphqlClient;
  final DcHardwareQuery dcHardwareQuery;

  DcHardwareTableRemoteDataSourceImpl({
    @required this.graphqlClient,
    @required this.dcHardwareQuery,
  });

  @override
  Future<DcHardwareTableModel> getAllDataWithFilter(
      DcHardwarePlusFilter dcHardware) async {
    Map<String, dynamic> variables = getPreparedQueryVariables(dcHardware);
    return await _executeGraphqlQuery(variables);
  }

  @override
  Future<List<int>> getIdsFromInserted(DcHardwareModel dcHardware) async {
    Map<String, dynamic> variables =
        getPreparedInsertMutationVariable(dcHardware);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHardwareQuery.getInsertStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  // Insert Multiple
  @override
  Future<List<int>> getIdsFromCloned(List<DcHardwareModel> dcHardware) async {
    Map<String, dynamic> variables =
        getPreparedCloneMutationVariable(dcHardware);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHardwareQuery.getCloneStatement,
      dataManipulation: EnumDataManipulation.insert,
    );
  }

  @override
  Future<List<int>> getIdsFromUpdated(DcHardwareModel dcHardware) async {
    Map<String, dynamic> variables =
        getPreparedUpdateMutationVariable(dcHardware);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHardwareQuery.getUpdateStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  // Set Delete hanya Update Multiple data pada field setDelete
  @override
  Future<List<int>> getIdsFromSetToDeleted(List<DcHardware> dcHardware) async {
    Map<String, dynamic> variables =
        getPreparedSetDeleteMutationVariable(dcHardware);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHardwareQuery.getSetDeleteStatement,
      dataManipulation: EnumDataManipulation.update,
    );
  }

  @override
  Future<List<int>> getIdsFromDeleted(List<DcHardware> dcHardware) async {
    Map<String, dynamic> variables =
        getPreparedDeleteMutationVariable(dcHardware);
    return _executeGraphqlMutation(
      variables: variables,
      mutationStatement: dcHardwareQuery.getDeleteStatement,
      dataManipulation: EnumDataManipulation.delete,
    );
  }

  // ! ============== Secondary Function ==============

  Future<DcHardwareTableModel> _executeGraphqlQuery(
      Map<String, dynamic> variables) async {
    if (Settings.isDebuggingQueryMode) {
      print(dcHardwareQuery.getSelectStatement);
      print(variables);
    }
    try {
      Map<String, dynamic> result = await DataHelper.executeGraphqlQuery(
        graphqlClient: graphqlClient,
        variables: variables,
        queryStatement: dcHardwareQuery.getSelectStatement,
      );
      return DcHardwareTableModel.fromMap(
        map: result,
        dataManipulationType: EnumDataManipulation.select,
      );
    } on HasuraError {
      throw ServerException();
    }
  }

  Map<String, dynamic> getPreparedQueryVariables(
      DcHardwarePlusFilter dcHardware) {
    String dataFilterByLogicalOperator =
        dcHardware.dataFilterByLogicalOperator == EnumLogicalOperator.or
            ? "_or"
            : "_and";

    String orderBy = dcHardware.orderByAscending ? "asc" : "desc";

    List<Map<String, dynamic>> queryFieldVariables =
        getQueryFieldVariables(dcHardware);

    queryFieldVariables.removeWhere((element) => element == null);

    Map<String, dynamic> finalQueryVariables = getFullQueryVariables(
      fields: dcHardware,
      orderBy: orderBy,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
      queryFieldVariables: queryFieldVariables,
    );
    return finalQueryVariables;
  }

  Map<String, dynamic> getFullQueryVariables({
    @required DcHardwarePlusFilter fields,
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

  List<Map<String, dynamic>> getQueryFieldVariables(DcHardware dcHardware) {
    return [
      getVariableMap("id", "_eq", dcHardware.id),
      getVariableMap("id_owner", "_eq", dcHardware.idOwner),
      getVariableMap(
          "owner", "_ilike", DataHelper.getQueryLikeTextFrom(dcHardware.owner)),
      getVariableMap("id_dc_rack", "_eq", dcHardware.idDcRack),
      getVariableMap("rack_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHardware.rackName)),
      getVariableMap("id_brand", "_eq", dcHardware.idBrand),
      getVariableMap(
          "brand", "_ilike", DataHelper.getQueryLikeTextFrom(dcHardware.brand)),
      getVariableMap("id_hw_model", "_eq", dcHardware.idHwModel),
      getVariableMap("hw_model", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHardware.hwModel)),
      getVariableMap("frontback_facing", "_eq", dcHardware.frontbackFacing),
      getVariableMap("id_hw_type", "_eq", dcHardware.idHwType),
      getVariableMap("hw_type", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHardware.hwType)),
      getVariableMap("id_mounted_form", "_eq", dcHardware.idMountedForm),
      getVariableMap("mounted_form", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHardware.mountedForm)),
      getVariableMap("hw_connect_type", "_eq", dcHardware.hwConnectType),
      getVariableMap("is_enclosure", "_eq", dcHardware.isEnclosure),
      getVariableMap("enclosure_column", "_eq", dcHardware.enclosureColumn),
      getVariableMap("enclosure_row", "_eq", dcHardware.enclosureRow),
      getVariableMap("is_blade", "_eq", dcHardware.isBlade),
      getVariableMap("id_parent", "_eq", dcHardware.idParent),
      getVariableMap("x_in_enclosure", "_eq", dcHardware.xInEnclosure),
      getVariableMap("y_in_enclosure", "_eq", dcHardware.yInEnclosure),
      getVariableMap("hw_name", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHardware.hwName)),
      getVariableMap(
          "sn", "_ilike", DataHelper.getQueryLikeTextFrom(dcHardware.sn)),
      getVariableMap("u_height", "_eq", dcHardware.uHeight),
      getVariableMap("u_position", "_eq", dcHardware.uPosition),
      getVariableMap("x_position_in_rack", "_eq", dcHardware.xPositionInRack),
      getVariableMap("y_position_in_rack", "_eq", dcHardware.yPositionInRack),
      getVariableMap("cpu_core", "_eq", dcHardware.cpuCore),
      getVariableMap("memory_gb", "_eq", dcHardware.memoryGb),
      getVariableMap("disk_gb", "_eq", dcHardware.diskGb),
      getVariableMap("watt", "_eq", dcHardware.watt),
      getVariableMap("ampere", "_eq", dcHardware.ampere),
      getVariableMap("width", "_eq", dcHardware.width),
      getVariableMap("height", "_eq", dcHardware.height),
      getVariableMap("is_reserved", "_eq", dcHardware.isReserved),
      getVariableMap("require_position", "_eq", dcHardware.requirePosition),
      getVariableMap(
          "image", "_ilike", DataHelper.getQueryLikeTextFrom(dcHardware.image)),
      getVariableMap(
          "notes", "_ilike", DataHelper.getQueryLikeTextFrom(dcHardware.notes)),
      getVariableMap("deleted", "_eq", dcHardware.deleted),
      getVariableMap("create", "_ilike",
          DataHelper.getQueryLikeTextFrom(dcHardware.create)),
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
        tableName: TableName.dcHardwareTableName,
        isSelectUsingView: true,
        viewName: TableName.dcHardwareViewName);

    if (iter.isEmpty) throw ServerException();

    List<int> manipulatedIds = [];

    iter.forEach((element) {
      manipulatedIds.add(element["id"]);
    });
    return manipulatedIds;
  }

  Map<String, dynamic> getPreparedInsertMutationVariable(
      DcHardwareModel dcHardware) {
    Map<String, dynamic> variables = dcHardware.toMap();
    variables.removeWhere((key, value) => value == null);
    dcHardwareQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcHardwareField, dcHardware.toMap());
    dcHardwareQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcHardwareField, dcHardware.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedCloneMutationVariable(
      List<DcHardwareModel> dcHardwareModels) {
    List<Map<String, dynamic>> fields = [];

    Map<String, dynamic> dcHardwareModelMap = Map<String, dynamic>();

    dcHardwareModels.forEach((element) async {
      dcHardwareModelMap = element.toMap();
      dcHardwareModelMap.remove("id");
      dcHardwareModelMap.remove("deleted");
      dcHardwareModelMap.remove("created");
      dcHardwareModelMap.removeWhere((key, value) => value == null);
      fields.add(dcHardwareModelMap);
    });

    final Map<String, dynamic> variables = {"objects": fields};
    return variables;
  }

  Map<String, dynamic> getPreparedUpdateMutationVariable(
      DcHardwareModel dcHardware) {
    Map<String, dynamic> variables = dcHardware.toMap();
    variables['_eq'] = dcHardware.id;
    variables.remove("id");
    variables.remove("created");
    variables.removeWhere((key, value) => value == null);
    dcHardwareQuery.graphqlVariable = DataHelper.getGraphqlVariable(
        FieldName.dcHardwareField, dcHardware.toMap());
    dcHardwareQuery.graphqlArgument = DataHelper.getGraphqlArgument(
        FieldName.dcHardwareField, dcHardware.toMap());
    return variables;
  }

  Map<String, dynamic> getPreparedSetDeleteMutationVariable(
      List<DcHardware> dcHardware) {
    List<int> ids = [];

    dcHardware.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids, 'deleted': true};
    return variables;
  }

  Map<String, dynamic> getPreparedDeleteMutationVariable(
      List<DcHardware> dcHardware) {
    List<int> ids = [];

    dcHardware.forEach((element) {
      ids.add(element.id);
    });

    Map<String, dynamic> variables = {'_in': ids};
    return variables;
  }
}
