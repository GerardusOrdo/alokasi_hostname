import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/server/data/datasources/server_query.dart';
import '../../features/server/data/datasources/server_table_remote_data_source.dart';
import '../../features/server/data/repositories/server_table_repository_impl.dart';
import '../../features/server/domain/usecases/clone_server_table.dart';
import '../../features/server/domain/usecases/delete_server_table.dart';
import '../../features/server/domain/usecases/insert_server_table.dart';
import '../../features/server/domain/usecases/select_server_table.dart';
import '../../features/server/domain/usecases/set_delete_server_table.dart';
import '../../features/server/domain/usecases/update_server_table.dart';
import '../../features/server/presentation/bloc/server_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class ServerBindings extends Bindings {
  @override
  void dependencies() {
    // ! External
    // DataConnectionChecker dataConnectionChecker =
    //     Get.put<DataConnectionChecker>(DataConnectionChecker());
    HasuraConnect hasuraConnect = Get.put<HasuraConnect>(
      HasuraConnect(
        Settings.hasuraConnectionString,
        headers: Settings.hasuraSecretHeader,
      ),
    );

    // ! Core
    // NetworkInfoImpl networkInfo =
    //     Get.put<NetworkInfo>(NetworkInfoImpl(dataConnectionChecker));

    // ! Main features
    // Data Sources
    ServerQuery serverQuery = Get.put<ServerQuery>(
      ServerQuery(
        viewName: TableName.serverViewName,
        tableName: TableName.serverTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.serverViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.serverField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.serverField),
      ),
    );
    ServerTableRemoteDataSourceImpl remoteDataSource =
        Get.put<ServerTableRemoteDataSourceImpl>(
      ServerTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        serverQuery: serverQuery,
      ),
    );
    // Repository
    ServerTableRepositoryImpl repository = Get.put<ServerTableRepositoryImpl>(
        ServerTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectServerTable>(SelectServerTable(repository));
    Get.put<InsertServerTable>(InsertServerTable(repository));
    Get.put<UpdateServerTable>(UpdateServerTable(repository));
    Get.put<SetDeleteServerTable>(SetDeleteServerTable(repository));
    Get.put<DeleteServerTable>(DeleteServerTable(repository));
    Get.put<CloneServerTable>(CloneServerTable(repository));
    // Ploc
    Get.lazyPut<ServerPloc>(() => ServerPloc());
  }
}
