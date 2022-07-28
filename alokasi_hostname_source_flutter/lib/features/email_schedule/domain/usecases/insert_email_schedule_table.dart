import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/email_schedule.dart';
import '../repositories/email_schedule_table_repository.dart';

class InsertEmailScheduleTable implements UseCase<List<int>, EmailSchedule> {
  final EmailScheduleTableRepository repository;

  InsertEmailScheduleTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(EmailSchedule params) async {
    return await repository.getIdsFromInserted(params);
  }
}
