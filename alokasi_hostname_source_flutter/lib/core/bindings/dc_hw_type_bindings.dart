import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_hw_type/data/datasources/dc_hw_type_query.dart';
import '../../features/dc_hw_type/data/datasources/dc_hw_type_table_remote_data_source.dart';
import '../../features/dc_hw_type/data/repositories/dc_hw_type_table_repository_impl.dart';
import '../../features/dc_hw_type/domain/usecases/clone_dc_hw_type_table.dart';
import '../../features/dc_hw_type/domain/usecases/delete_dc_hw_type_table.dart';
import '../../features/dc_hw_type/domain/usecases/insert_dc_hw_type_table.dart';
import '../../features/dc_hw_type/domain/usecases/select_dc_hw_type_table.dart';
import '../../features/dc_hw_type/domain/usecases/set_delete_dc_hw_type_table.dart';
import '../../features/dc_hw_type/domain/usecases/update_dc_hw_type_table.dart';
import '../../features/dc_hw_type/presentation/bloc/dc_hw_type_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcHwTypeBindings extends Bindings {
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
    DcHwTypeQuery dcHwTypeQuery = Get.put<DcHwTypeQuery>(
      DcHwTypeQuery(
        viewName: TableName.dcHwTypeViewName,
        tableName: TableName.dcHwTypeTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcHwTypeViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcHwTypeField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcHwTypeField),
      ),
    );
    DcHwTypeTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcHwTypeTableRemoteDataSourceImpl>(
      DcHwTypeTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcHwTypeQuery: dcHwTypeQuery,
      ),
    );
    // Repository
    DcHwTypeTableRepositoryImpl repository =
        Get.put<DcHwTypeTableRepositoryImpl>(
            DcHwTypeTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcHwTypeTable>(SelectDcHwTypeTable(repository));
    Get.put<InsertDcHwTypeTable>(InsertDcHwTypeTable(repository));
    Get.put<UpdateDcHwTypeTable>(UpdateDcHwTypeTable(repository));
    Get.put<SetDeleteDcHwTypeTable>(SetDeleteDcHwTypeTable(repository));
    Get.put<DeleteDcHwTypeTable>(DeleteDcHwTypeTable(repository));
    Get.put<CloneDcHwTypeTable>(CloneDcHwTypeTable(repository));
    // Ploc
    Get.lazyPut<DcHwTypePloc>(() => DcHwTypePloc());
  }
}
