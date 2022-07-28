import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_room/data/datasources/dc_room_query.dart';
import '../../features/dc_room/data/datasources/dc_room_table_remote_data_source.dart';
import '../../features/dc_room/data/repositories/dc_room_table_repository_impl.dart';
import '../../features/dc_room/domain/usecases/clone_dc_room_table.dart';
import '../../features/dc_room/domain/usecases/delete_dc_room_table.dart';
import '../../features/dc_room/domain/usecases/insert_dc_room_table.dart';
import '../../features/dc_room/domain/usecases/select_dc_room_table.dart';
import '../../features/dc_room/domain/usecases/set_delete_dc_room_table.dart';
import '../../features/dc_room/domain/usecases/update_dc_room_table.dart';
import '../../features/dc_room/presentation/bloc/dc_room_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcRoomBindings extends Bindings {
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
    DcRoomQuery dcRoomQuery = Get.put<DcRoomQuery>(
      DcRoomQuery(
        viewName: TableName.dcRoomViewName,
        tableName: TableName.dcRoomTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcRoomViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcRoomField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcRoomField),
      ),
    );
    DcRoomTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcRoomTableRemoteDataSourceImpl>(
      DcRoomTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcRoomQuery: dcRoomQuery,
      ),
    );
    // Repository
    DcRoomTableRepositoryImpl repository = Get.put<DcRoomTableRepositoryImpl>(
        DcRoomTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcRoomTable>(SelectDcRoomTable(repository));
    Get.put<InsertDcRoomTable>(InsertDcRoomTable(repository));
    Get.put<UpdateDcRoomTable>(UpdateDcRoomTable(repository));
    Get.put<SetDeleteDcRoomTable>(SetDeleteDcRoomTable(repository));
    Get.put<DeleteDcRoomTable>(DeleteDcRoomTable(repository));
    Get.put<CloneDcRoomTable>(CloneDcRoomTable(repository));
    // Ploc
    Get.lazyPut<DcRoomPloc>(() => DcRoomPloc());
  }
}
