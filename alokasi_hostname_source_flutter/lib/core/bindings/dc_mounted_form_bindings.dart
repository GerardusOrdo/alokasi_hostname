import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_mounted_form/data/datasources/dc_mounted_form_query.dart';
import '../../features/dc_mounted_form/data/datasources/dc_mounted_form_table_remote_data_source.dart';
import '../../features/dc_mounted_form/data/repositories/dc_mounted_form_table_repository_impl.dart';
import '../../features/dc_mounted_form/domain/usecases/clone_dc_mounted_form_table.dart';
import '../../features/dc_mounted_form/domain/usecases/delete_dc_mounted_form_table.dart';
import '../../features/dc_mounted_form/domain/usecases/insert_dc_mounted_form_table.dart';
import '../../features/dc_mounted_form/domain/usecases/select_dc_mounted_form_table.dart';
import '../../features/dc_mounted_form/domain/usecases/set_delete_dc_mounted_form_table.dart';
import '../../features/dc_mounted_form/domain/usecases/update_dc_mounted_form_table.dart';
import '../../features/dc_mounted_form/presentation/bloc/dc_mounted_form_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcMountedFormBindings extends Bindings {
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
    DcMountedFormQuery dcMountedFormQuery = Get.put<DcMountedFormQuery>(
      DcMountedFormQuery(
        viewName: TableName.dcMountedFormViewName,
        tableName: TableName.dcMountedFormTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcMountedFormViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcMountedFormField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcMountedFormField),
      ),
    );
    DcMountedFormTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcMountedFormTableRemoteDataSourceImpl>(
      DcMountedFormTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcMountedFormQuery: dcMountedFormQuery,
      ),
    );
    // Repository
    DcMountedFormTableRepositoryImpl repository = Get.put<
            DcMountedFormTableRepositoryImpl>(
        DcMountedFormTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcMountedFormTable>(SelectDcMountedFormTable(repository));
    Get.put<InsertDcMountedFormTable>(InsertDcMountedFormTable(repository));
    Get.put<UpdateDcMountedFormTable>(UpdateDcMountedFormTable(repository));
    Get.put<SetDeleteDcMountedFormTable>(
        SetDeleteDcMountedFormTable(repository));
    Get.put<DeleteDcMountedFormTable>(DeleteDcMountedFormTable(repository));
    Get.put<CloneDcMountedFormTable>(CloneDcMountedFormTable(repository));
    // Ploc
    Get.lazyPut<DcMountedFormPloc>(() => DcMountedFormPloc());
  }
}
