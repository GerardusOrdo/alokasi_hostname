import 'package:meta/meta.dart';

import '../../../../core/template/master_data/data/datasources/graphql_query.dart';

class DcHwTypeQuery extends GraphqlQuery {
  DcHwTypeQuery({
    @required String viewName,
    @required String tableName,
    @required String viewFieldName,
    @required String graphqlVariable,
    @required String graphqlArgument,
  }) : super(
          viewName: viewName,
          tableName: tableName,
          viewFieldName: viewFieldName,
          graphqlVariable: graphqlVariable,
          graphqlArgument: graphqlArgument,
        );
}
