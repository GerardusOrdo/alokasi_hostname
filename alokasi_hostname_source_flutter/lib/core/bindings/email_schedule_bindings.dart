import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../features/email_schedule/data/datasources/email_schedule_query.dart';
import '../../features/email_schedule/data/datasources/email_schedule_table_remote_data_source.dart';
import '../../features/email_schedule/data/repositories/email_schedule_table_repository_impl.dart';
import '../../features/email_schedule/domain/usecases/clone_email_schedule_table.dart';
import '../../features/email_schedule/domain/usecases/delete_email_schedule_table.dart';
import '../../features/email_schedule/domain/usecases/insert_email_schedule_table.dart';
import '../../features/email_schedule/domain/usecases/select_email_schedule_table.dart';
import '../../features/email_schedule/domain/usecases/set_delete_email_schedule_table.dart';
import '../../features/email_schedule/domain/usecases/update_email_schedule_table.dart';
import '../../features/email_schedule/presentation/bloc/email_schedule_ploc.dart';
import '../helper/data_helper.dart';
import '../helper/helper.dart';
import '../settings/settings.dart';

class EmailScheduleBindings extends Bindings {
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
    EmailScheduleQuery emailScheduleQuery = Get.put<EmailScheduleQuery>(
      EmailScheduleQuery(
        viewName: TableName.emailScheduleViewName,
        tableName: TableName.emailScheduleTableName,
        viewFieldName:
            DataHelper.getPlainKeyTextFromMap(FieldName.emailScheduleViewField),
        graphqlVariable:
            DataHelper.getDefaultGraphqlVariable(FieldName.emailScheduleField),
        graphqlArgument:
            DataHelper.getDefaultGraphqlArgument(FieldName.emailScheduleField),
      ),
    );
    EmailScheduleTableRemoteDataSourceImpl remoteDataSource =
        Get.put<EmailScheduleTableRemoteDataSourceImpl>(
      EmailScheduleTableRemoteDataSourceImpl(
        graphqlClient: hasuraConnect,
        emailScheduleQuery: emailScheduleQuery,
      ),
    );
    // Repository
    EmailScheduleTableRepositoryImpl repository = Get.put<
            EmailScheduleTableRepositoryImpl>(
        EmailScheduleTableRepositoryImpl(remoteDataSource: remoteDataSource));
    // Usecases
    Get.put<SelectEmailScheduleTable>(SelectEmailScheduleTable(repository));
    Get.put<InsertEmailScheduleTable>(InsertEmailScheduleTable(repository));
    Get.put<UpdateEmailScheduleTable>(UpdateEmailScheduleTable(repository));
    Get.put<SetDeleteEmailScheduleTable>(
        SetDeleteEmailScheduleTable(repository));
    Get.put<DeleteEmailScheduleTable>(DeleteEmailScheduleTable(repository));
    Get.put<CloneEmailScheduleTable>(CloneEmailScheduleTable(repository));
    // Ploc
    Get.lazyPut<EmailSchedulePloc>(() => EmailSchedulePloc());
  }
}
