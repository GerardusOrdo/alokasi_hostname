import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_rack/data/datasources/dc_rack_query.dart';
import '../../features/dc_rack/data/datasources/dc_rack_table_remote_data_source.dart';
import '../../features/dc_rack/data/repositories/dc_rack_table_repository_impl.dart';
import '../../features/dc_rack/domain/usecases/clone_dc_rack_table.dart';
import '../../features/dc_rack/domain/usecases/delete_dc_rack_table.dart';
import '../../features/dc_rack/domain/usecases/insert_dc_rack_table.dart';
import '../../features/dc_rack/domain/usecases/select_dc_rack_table.dart';
import '../../features/dc_rack/domain/usecases/set_delete_dc_rack_table.dart';
import '../../features/dc_rack/domain/usecases/update_dc_rack_table.dart';
import '../../features/dc_rack/presentation/bloc/dc_rack_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcRackBindings extends Bindings {
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
    DcRackQuery dcRackQuery = Get.put<DcRackQuery>(
      DcRackQuery(
        viewName: TableName.dcRackViewName,
        tableName: TableName.dcRackTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcRackViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcRackField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcRackField),
      ),
    );
    DcRackTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcRackTableRemoteDataSourceImpl>(
      DcRackTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcRackQuery: dcRackQuery,
      ),
    );
    // Repository
    DcRackTableRepositoryImpl repository = Get.put<DcRackTableRepositoryImpl>(
        DcRackTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcRackTable>(SelectDcRackTable(repository));
    Get.put<InsertDcRackTable>(InsertDcRackTable(repository));
    Get.put<UpdateDcRackTable>(UpdateDcRackTable(repository));
    Get.put<SetDeleteDcRackTable>(SetDeleteDcRackTable(repository));
    Get.put<DeleteDcRackTable>(DeleteDcRackTable(repository));
    Get.put<CloneDcRackTable>(CloneDcRackTable(repository));
    // Ploc
    Get.lazyPut<DcRackPloc>(() => DcRackPloc());
  }
}
