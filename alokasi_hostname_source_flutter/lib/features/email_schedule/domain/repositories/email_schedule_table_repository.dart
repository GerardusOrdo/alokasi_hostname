import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/email_schedule.dart';
import '../entities/email_schedule_plus_filter.dart';
import '../entities/email_schedule_table.dart';

abstract class EmailScheduleTableRepository {
  Future<Either<Failure, EmailScheduleTable>> getAllDataWithFilter(
      EmailSchedulePlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(EmailSchedule dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<EmailSchedule> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(EmailSchedule dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<EmailSchedule> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<EmailSchedule> dataTable);
}
