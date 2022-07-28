import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/owner/data/datasources/owner_query.dart';
import '../../features/owner/data/datasources/owner_table_remote_data_source.dart';
import '../../features/owner/data/repositories/owner_table_repository_impl.dart';
import '../../features/owner/domain/usecases/clone_owner_table.dart';
import '../../features/owner/domain/usecases/delete_owner_table.dart';
import '../../features/owner/domain/usecases/insert_owner_table.dart';
import '../../features/owner/domain/usecases/select_owner_table.dart';
import '../../features/owner/domain/usecases/set_delete_owner_table.dart';
import '../../features/owner/domain/usecases/update_owner_table.dart';
import '../../features/owner/presentation/bloc/owner_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class OwnerBindings extends Bindings {
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
    OwnerQuery ownerQuery = Get.put<OwnerQuery>(
      OwnerQuery(
        viewName: TableName.ownerViewName,
        tableName: TableName.ownerTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.ownerViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.ownerField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.ownerField),
      ),
    );
    OwnerTableRemoteDataSourceImpl remoteDataSource =
        Get.put<OwnerTableRemoteDataSourceImpl>(
      OwnerTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        ownerQuery: ownerQuery,
      ),
    );
    // Repository
    OwnerTableRepositoryImpl repository = Get.put<OwnerTableRepositoryImpl>(
        OwnerTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectOwnerTable>(SelectOwnerTable(repository));
    Get.put<InsertOwnerTable>(InsertOwnerTable(repository));
    Get.put<UpdateOwnerTable>(UpdateOwnerTable(repository));
    Get.put<SetDeleteOwnerTable>(SetDeleteOwnerTable(repository));
    Get.put<DeleteOwnerTable>(DeleteOwnerTable(repository));
    Get.put<CloneOwnerTable>(CloneOwnerTable(repository));
    // Ploc
    Get.lazyPut<OwnerPloc>(() => OwnerPloc());
  }
}
