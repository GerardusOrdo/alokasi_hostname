import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_hw_model/data/datasources/dc_hw_model_query.dart';
import '../../features/dc_hw_model/data/datasources/dc_hw_model_table_remote_data_source.dart';
import '../../features/dc_hw_model/data/repositories/dc_hw_model_table_repository_impl.dart';
import '../../features/dc_hw_model/domain/usecases/clone_dc_hw_model_table.dart';
import '../../features/dc_hw_model/domain/usecases/delete_dc_hw_model_table.dart';
import '../../features/dc_hw_model/domain/usecases/insert_dc_hw_model_table.dart';
import '../../features/dc_hw_model/domain/usecases/select_dc_hw_model_table.dart';
import '../../features/dc_hw_model/domain/usecases/set_delete_dc_hw_model_table.dart';
import '../../features/dc_hw_model/domain/usecases/update_dc_hw_model_table.dart';
import '../../features/dc_hw_model/presentation/bloc/dc_hw_model_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcHwModelBindings extends Bindings {
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
    DcHwModelQuery dcHwModelQuery = Get.put<DcHwModelQuery>(
      DcHwModelQuery(
        viewName: TableName.dcHwModelViewName,
        tableName: TableName.dcHwModelTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcHwModelViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcHwModelField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcHwModelField),
      ),
    );
    DcHwModelTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcHwModelTableRemoteDataSourceImpl>(
      DcHwModelTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcHwModelQuery: dcHwModelQuery,
      ),
    );
    // Repository
    DcHwModelTableRepositoryImpl repository =
        Get.put<DcHwModelTableRepositoryImpl>(
            DcHwModelTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcHwModelTable>(SelectDcHwModelTable(repository));
    Get.put<InsertDcHwModelTable>(InsertDcHwModelTable(repository));
    Get.put<UpdateDcHwModelTable>(UpdateDcHwModelTable(repository));
    Get.put<SetDeleteDcHwModelTable>(SetDeleteDcHwModelTable(repository));
    Get.put<DeleteDcHwModelTable>(DeleteDcHwModelTable(repository));
    Get.put<CloneDcHwModelTable>(CloneDcHwModelTable(repository));
    // Ploc
    Get.lazyPut<DcHwModelPloc>(() => DcHwModelPloc());
  }
}
