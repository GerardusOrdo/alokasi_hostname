import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_hw_model.dart';
import '../../domain/entities/dc_hw_model_table.dart';
import '../../domain/repositories/dc_hw_model_table_repository.dart';
import '../datasources/dc_hw_model_table_remote_data_source.dart';
import '../models/dc_hw_model_model.dart';

typedef Future<DcHwModelTable> _SelectAction();

class DcHwModelTableRepositoryImpl implements DcHwModelTableRepository {
  final DcHwModelTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcHwModelTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcHwModelTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcHwModel = await actions();
      return Right(remoteDcHwModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcHwModelTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcHwModel dataTable) async {
    DcHwModelModel dcHwModelModel = DcHwModelModel.fromDcHwModel(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcHwModelModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcHwModel> dataTable) async {
    List<DcHwModelModel> dcHwModelModels = [];
    dataTable.forEach((element) {
      dcHwModelModels.add(DcHwModelModel.fromDcHwModel(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcHwModelModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(
      DcHwModel dataTable) async {
    DcHwModelModel dcHwModelModel = DcHwModelModel.fromDcHwModel(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcHwModelModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcHwModel> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcHwModel> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
