import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_containment/data/datasources/dc_containment_query.dart';
import '../../features/dc_containment/data/datasources/dc_containment_table_remote_data_source.dart';
import '../../features/dc_containment/data/repositories/dc_containment_table_repository_impl.dart';
import '../../features/dc_containment/domain/usecases/clone_dc_containment_table.dart';
import '../../features/dc_containment/domain/usecases/delete_dc_containment_table.dart';
import '../../features/dc_containment/domain/usecases/insert_dc_containment_table.dart';
import '../../features/dc_containment/domain/usecases/select_dc_containment_table.dart';
import '../../features/dc_containment/domain/usecases/set_delete_dc_containment_table.dart';
import '../../features/dc_containment/domain/usecases/update_dc_containment_table.dart';
import '../../features/dc_containment/presentation/bloc/dc_containment_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcContainmentBindings extends Bindings {
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
    DcContainmentQuery dcContainmentQuery = Get.put<DcContainmentQuery>(
      DcContainmentQuery(
        viewName: TableName.dcContainmentViewName,
        tableName: TableName.dcContainmentTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcContainmentViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcContainmentField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcContainmentField),
      ),
    );
    DcContainmentTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcContainmentTableRemoteDataSourceImpl>(
      DcContainmentTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcContainmentQuery: dcContainmentQuery,
      ),
    );
    // Repository
    DcContainmentTableRepositoryImpl repository = Get.put<
            DcContainmentTableRepositoryImpl>(
        DcContainmentTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcContainmentTable>(SelectDcContainmentTable(repository));
    Get.put<InsertDcContainmentTable>(InsertDcContainmentTable(repository));
    Get.put<UpdateDcContainmentTable>(UpdateDcContainmentTable(repository));
    Get.put<SetDeleteDcContainmentTable>(
        SetDeleteDcContainmentTable(repository));
    Get.put<DeleteDcContainmentTable>(DeleteDcContainmentTable(repository));
    Get.put<CloneDcContainmentTable>(CloneDcContainmentTable(repository));
    // Ploc
    Get.lazyPut<DcContainmentPloc>(() => DcContainmentPloc());
  }
}
