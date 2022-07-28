import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_mounted_form.dart';
import '../../domain/entities/dc_mounted_form_table.dart';
import '../../domain/repositories/dc_mounted_form_table_repository.dart';
import '../datasources/dc_mounted_form_table_remote_data_source.dart';
import '../models/dc_mounted_form_model.dart';

typedef Future<DcMountedFormTable> _SelectAction();

class DcMountedFormTableRepositoryImpl implements DcMountedFormTableRepository {
  final DcMountedFormTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcMountedFormTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcMountedFormTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcMountedForm = await actions();
      return Right(remoteDcMountedForm);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcMountedFormTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcMountedForm dataTable) async {
    DcMountedFormModel dcMountedFormModel = DcMountedFormModel.fromDcMountedForm(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcMountedFormModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcMountedForm> dataTable) async {
    List<DcMountedFormModel> dcMountedFormModels = [];
    dataTable.forEach((element) {
      dcMountedFormModels.add(DcMountedFormModel.fromDcMountedForm(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcMountedFormModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(
      DcMountedForm dataTable) async {
    DcMountedFormModel dcMountedFormModel = DcMountedFormModel.fromDcMountedForm(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcMountedFormModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcMountedForm> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcMountedForm> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
