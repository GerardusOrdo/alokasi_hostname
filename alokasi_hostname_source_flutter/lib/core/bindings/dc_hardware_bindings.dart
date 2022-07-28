import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_hardware/data/datasources/dc_hardware_query.dart';
import '../../features/dc_hardware/data/datasources/dc_hardware_table_remote_data_source.dart';
import '../../features/dc_hardware/data/repositories/dc_hardware_table_repository_impl.dart';
import '../../features/dc_hardware/domain/usecases/clone_dc_hardware_table.dart';
import '../../features/dc_hardware/domain/usecases/delete_dc_hardware_table.dart';
import '../../features/dc_hardware/domain/usecases/insert_dc_hardware_table.dart';
import '../../features/dc_hardware/domain/usecases/select_dc_hardware_table.dart';
import '../../features/dc_hardware/domain/usecases/set_delete_dc_hardware_table.dart';
import '../../features/dc_hardware/domain/usecases/update_dc_hardware_table.dart';
import '../../features/dc_hardware/presentation/bloc/dc_hardware_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcHardwareBindings extends Bindings {
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
    DcHardwareQuery dcHardwareQuery = Get.put<DcHardwareQuery>(
      DcHardwareQuery(
        viewName: TableName.dcHardwareViewName,
        tableName: TableName.dcHardwareTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcHardwareViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcHardwareField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcHardwareField),
      ),
    );
    DcHardwareTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcHardwareTableRemoteDataSourceImpl>(
      DcHardwareTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcHardwareQuery: dcHardwareQuery,
      ),
    );
    // Repository
    DcHardwareTableRepositoryImpl repository =
        Get.put<DcHardwareTableRepositoryImpl>(
            DcHardwareTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcHardwareTable>(SelectDcHardwareTable(repository));
    Get.put<InsertDcHardwareTable>(InsertDcHardwareTable(repository));
    Get.put<UpdateDcHardwareTable>(UpdateDcHardwareTable(repository));
    Get.put<SetDeleteDcHardwareTable>(SetDeleteDcHardwareTable(repository));
    Get.put<DeleteDcHardwareTable>(DeleteDcHardwareTable(repository));
    Get.put<CloneDcHardwareTable>(CloneDcHardwareTable(repository));
    // Ploc
    Get.lazyPut<DcHardwarePloc>(() => DcHardwarePloc());
  }
}
