import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_owner/data/datasources/dc_owner_query.dart';
import '../../features/dc_owner/data/datasources/dc_owner_table_remote_data_source.dart';
import '../../features/dc_owner/data/repositories/dc_owner_table_repository_impl.dart';
import '../../features/dc_owner/domain/usecases/clone_dc_owner_table.dart';
import '../../features/dc_owner/domain/usecases/delete_dc_owner_table.dart';
import '../../features/dc_owner/domain/usecases/insert_dc_owner_table.dart';
import '../../features/dc_owner/domain/usecases/select_dc_owner_table.dart';
import '../../features/dc_owner/domain/usecases/set_delete_dc_owner_table.dart';
import '../../features/dc_owner/domain/usecases/update_dc_owner_table.dart';
import '../../features/dc_owner/presentation/bloc/dc_owner_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcOwnerBindings extends Bindings {
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
    DcOwnerQuery dcOwnerQuery = Get.put<DcOwnerQuery>(
      DcOwnerQuery(
        viewName: TableName.dcOwnerViewName,
        tableName: TableName.dcOwnerTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcOwnerViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcOwnerField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcOwnerField),
      ),
    );
    DcOwnerTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcOwnerTableRemoteDataSourceImpl>(
      DcOwnerTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcOwnerQuery: dcOwnerQuery,
      ),
    );
    // Repository
    DcOwnerTableRepositoryImpl repository = Get.put<DcOwnerTableRepositoryImpl>(
        DcOwnerTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcOwnerTable>(SelectDcOwnerTable(repository));
    Get.put<InsertDcOwnerTable>(InsertDcOwnerTable(repository));
    Get.put<UpdateDcOwnerTable>(UpdateDcOwnerTable(repository));
    Get.put<SetDeleteDcOwnerTable>(SetDeleteDcOwnerTable(repository));
    Get.put<DeleteDcOwnerTable>(DeleteDcOwnerTable(repository));
    Get.put<CloneDcOwnerTable>(CloneDcOwnerTable(repository));
    // Ploc
    Get.lazyPut<DcOwnerPloc>(() => DcOwnerPloc());
  }
}
