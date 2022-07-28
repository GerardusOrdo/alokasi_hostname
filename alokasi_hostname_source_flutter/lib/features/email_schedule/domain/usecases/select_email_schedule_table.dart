import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/email_schedule_plus_filter.dart';
import '../entities/email_schedule_table.dart';
import '../repositories/email_schedule_table_repository.dart';

class SelectEmailScheduleTable implements UseCase<MasterDataTable, EmailSchedulePlusFilter> {
  final EmailScheduleTableRepository repository;

  SelectEmailScheduleTable(this.repository);

  @override
  Future<Either<Failure, EmailScheduleTable>> call(EmailSchedulePlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
