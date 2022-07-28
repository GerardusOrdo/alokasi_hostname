import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_brand/data/datasources/dc_brand_query.dart';
import '../../features/dc_brand/data/datasources/dc_brand_table_remote_data_source.dart';
import '../../features/dc_brand/data/repositories/dc_brand_table_repository_impl.dart';
import '../../features/dc_brand/domain/usecases/clone_dc_brand_table.dart';
import '../../features/dc_brand/domain/usecases/delete_dc_brand_table.dart';
import '../../features/dc_brand/domain/usecases/insert_dc_brand_table.dart';
import '../../features/dc_brand/domain/usecases/select_dc_brand_table.dart';
import '../../features/dc_brand/domain/usecases/set_delete_dc_brand_table.dart';
import '../../features/dc_brand/domain/usecases/update_dc_brand_table.dart';
import '../../features/dc_brand/presentation/bloc/dc_brand_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcBrandBindings extends Bindings {
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
    DcBrandQuery dcBrandQuery = Get.put<DcBrandQuery>(
      DcBrandQuery(
        viewName: TableName.dcBrandViewName,
        tableName: TableName.dcBrandTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcBrandViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcBrandField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcBrandField),
      ),
    );
    DcBrandTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcBrandTableRemoteDataSourceImpl>(
      DcBrandTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcBrandQuery: dcBrandQuery,
      ),
    );
    // Repository
    DcBrandTableRepositoryImpl repository = Get.put<DcBrandTableRepositoryImpl>(
        DcBrandTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcBrandTable>(SelectDcBrandTable(repository));
    Get.put<InsertDcBrandTable>(InsertDcBrandTable(repository));
    Get.put<UpdateDcBrandTable>(UpdateDcBrandTable(repository));
    Get.put<SetDeleteDcBrandTable>(SetDeleteDcBrandTable(repository));
    Get.put<DeleteDcBrandTable>(DeleteDcBrandTable(repository));
    Get.put<CloneDcBrandTable>(CloneDcBrandTable(repository));
    // Ploc
    Get.lazyPut<DcBrandPloc>(() => DcBrandPloc());
  }
}
