import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/email_schedule.dart';
import '../repositories/email_schedule_table_repository.dart';

class SetDeleteEmailScheduleTable implements UseCase<List<int>, List<EmailSchedule>> {
  final EmailScheduleTableRepository repository;

  SetDeleteEmailScheduleTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<EmailSchedule> params) async {
    return await repository.getIdsFromSetToDeleted(params);
  }
}
