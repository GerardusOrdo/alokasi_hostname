import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_site/data/datasources/dc_site_query.dart';
import '../../features/dc_site/data/datasources/dc_site_table_remote_data_source.dart';
import '../../features/dc_site/data/repositories/dc_site_table_repository_impl.dart';
import '../../features/dc_site/domain/usecases/clone_dc_site_table.dart';
import '../../features/dc_site/domain/usecases/delete_dc_site_table.dart';
import '../../features/dc_site/domain/usecases/insert_dc_site_table.dart';
import '../../features/dc_site/domain/usecases/select_dc_site_table.dart';
import '../../features/dc_site/domain/usecases/set_delete_dc_site_table.dart';
import '../../features/dc_site/domain/usecases/update_dc_site_table.dart';
import '../../features/dc_site/presentation/bloc/dc_site_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcSiteBindings extends Bindings {
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
    DcSiteQuery dcSiteQuery = Get.put<DcSiteQuery>(
      DcSiteQuery(
        viewName: TableName.dcSiteViewName,
        tableName: TableName.dcSiteTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcSiteViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcSiteField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcSiteField),
      ),
    );
    DcSiteTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcSiteTableRemoteDataSourceImpl>(
      DcSiteTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcSiteQuery: dcSiteQuery,
      ),
    );
    // Repository
    DcSiteTableRepositoryImpl repository = Get.put<DcSiteTableRepositoryImpl>(
        DcSiteTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcSiteTable>(SelectDcSiteTable(repository));
    Get.put<InsertDcSiteTable>(InsertDcSiteTable(repository));
    Get.put<UpdateDcSiteTable>(UpdateDcSiteTable(repository));
    Get.put<SetDeleteDcSiteTable>(SetDeleteDcSiteTable(repository));
    Get.put<DeleteDcSiteTable>(DeleteDcSiteTable(repository));
    Get.put<CloneDcSiteTable>(CloneDcSiteTable(repository));
    // Ploc
    Get.lazyPut<DcSitePloc>(() => DcSitePloc());
  }
}
