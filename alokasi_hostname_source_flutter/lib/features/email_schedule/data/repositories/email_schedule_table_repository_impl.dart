import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/email_schedule.dart';
import '../../domain/entities/email_schedule_table.dart';
import '../../domain/repositories/email_schedule_table_repository.dart';
import '../datasources/email_schedule_table_remote_data_source.dart';
import '../models/email_schedule_model.dart';

typedef Future<EmailScheduleTable> _SelectAction();

class EmailScheduleTableRepositoryImpl implements EmailScheduleTableRepository {
  final EmailScheduleTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  EmailScheduleTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, EmailScheduleTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteEmailSchedule = await actions();
      return Right(remoteEmailSchedule);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, EmailScheduleTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      EmailSchedule dataTable) async {
    EmailScheduleModel emailScheduleModel = EmailScheduleModel.fromEmailSchedule(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(emailScheduleModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<EmailSchedule> dataTable) async {
    List<EmailScheduleModel> emailScheduleModels = [];
    dataTable.forEach((element) {
      emailScheduleModels.add(EmailScheduleModel.fromEmailSchedule(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(emailScheduleModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(EmailSchedule dataTable) async {
    EmailScheduleModel emailScheduleModel = EmailScheduleModel.fromEmailSchedule(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(emailScheduleModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<EmailSchedule> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<EmailSchedule> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
