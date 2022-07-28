import 'package:meta/meta.dart';

abstract class GraphqlQuery {
  final String viewName;
  final String tableName;
  final String viewFieldName;
  String graphqlVariable;
  String graphqlArgument;

  GraphqlQuery({
    @required this.viewName,
    @required this.tableName,
    @required this.viewFieldName,
    @required this.graphqlVariable,
    @required this.graphqlArgument,
  });

  String get getSelectStatement =>
      '''query MyQuery(\$limit: Int = 100, \$offset: Int = 10, \$order_by: [${viewName}_order_by!] = {}, 
      \$where: ${viewName}_bool_exp = {}) {
  $viewName(offset: \$offset, limit: \$limit, order_by: \$order_by, where: \$where) {
    $viewFieldName
  }
}''';

  String get getInsertStatement => '''mutation MyMutation(
        $graphqlVariable
        ) {
  insert_$tableName(objects: { 
    $graphqlArgument
    }) {
    returning {
      id
    }
  }
}''';

  String get getCloneStatement =>
      '''mutation MyMutation(\$objects: [${tableName}_insert_input!]!) {
  insert_$tableName(objects: \$objects) {
    returning {
      id
    }
  }
}''';

  String get getUpdateStatement => '''mutation MyMutation(
        \$_eq: Int = 10, 
        $graphqlVariable
        ) {
  update_$tableName(where: {id: {_eq: \$_eq}}, _set: { 
    $graphqlArgument
    }) {
    returning {
      id
    }
  }
}''';

  String get getSetDeleteStatement =>
      '''mutation MyMutation(\$_in: [Int!] = 10, \$deleted: Boolean = false) {
  update_$tableName(where: {id: {_in: \$_in}}, _set: {deleted: \$deleted}) {
    returning {
      id
    }
  }
}''';

  String get getDeleteStatement => '''mutation MyMutation(\$_in: [Int!] = 10) {
  delete_$tableName(where: {id: {_in: \$_in}}) {
    returning {
      id
    }
  }
}''';
}
