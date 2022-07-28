import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/dc_room_type/data/datasources/dc_room_type_query.dart';
import '../../features/dc_room_type/data/datasources/dc_room_type_table_remote_data_source.dart';
import '../../features/dc_room_type/data/repositories/dc_room_type_table_repository_impl.dart';
import '../../features/dc_room_type/domain/usecases/clone_dc_room_type_table.dart';
import '../../features/dc_room_type/domain/usecases/delete_dc_room_type_table.dart';
import '../../features/dc_room_type/domain/usecases/insert_dc_room_type_table.dart';
import '../../features/dc_room_type/domain/usecases/select_dc_room_type_table.dart';
import '../../features/dc_room_type/domain/usecases/set_delete_dc_room_type_table.dart';
import '../../features/dc_room_type/domain/usecases/update_dc_room_type_table.dart';
import '../../features/dc_room_type/presentation/bloc/dc_room_type_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class DcRoomTypeBindings extends Bindings {
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
    DcRoomTypeQuery dcRoomTypeQuery = Get.put<DcRoomTypeQuery>(
      DcRoomTypeQuery(
        viewName: TableName.dcRoomTypeViewName,
        tableName: TableName.dcRoomTypeTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.dcRoomTypeViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.dcRoomTypeField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.dcRoomTypeField),
      ),
    );
    DcRoomTypeTableRemoteDataSourceImpl remoteDataSource =
        Get.put<DcRoomTypeTableRemoteDataSourceImpl>(
      DcRoomTypeTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        dcRoomTypeQuery: dcRoomTypeQuery,
      ),
    );
    // Repository
    DcRoomTypeTableRepositoryImpl repository =
        Get.put<DcRoomTypeTableRepositoryImpl>(
            DcRoomTypeTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectDcRoomTypeTable>(SelectDcRoomTypeTable(repository));
    Get.put<InsertDcRoomTypeTable>(InsertDcRoomTypeTable(repository));
    Get.put<UpdateDcRoomTypeTable>(UpdateDcRoomTypeTable(repository));
    Get.put<SetDeleteDcRoomTypeTable>(SetDeleteDcRoomTypeTable(repository));
    Get.put<DeleteDcRoomTypeTable>(DeleteDcRoomTypeTable(repository));
    Get.put<CloneDcRoomTypeTable>(CloneDcRoomTypeTable(repository));
    // Ploc
    Get.lazyPut<DcRoomTypePloc>(() => DcRoomTypePloc());
  }
}
