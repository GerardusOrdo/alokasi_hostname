import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_hw_type.dart';
import '../../domain/entities/dc_hw_type_table.dart';
import '../../domain/repositories/dc_hw_type_table_repository.dart';
import '../datasources/dc_hw_type_table_remote_data_source.dart';
import '../models/dc_hw_type_model.dart';

typedef Future<DcHwTypeTable> _SelectAction();

class DcHwTypeTableRepositoryImpl implements DcHwTypeTableRepository {
  final DcHwTypeTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcHwTypeTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcHwTypeTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcHwType = await actions();
      return Right(remoteDcHwType);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcHwTypeTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcHwType dataTable) async {
    DcHwTypeModel dcHwTypeModel = DcHwTypeModel.fromDcHwType(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcHwTypeModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcHwType> dataTable) async {
    List<DcHwTypeModel> dcHwTypeModels = [];
    dataTable.forEach((element) {
      dcHwTypeModels.add(DcHwTypeModel.fromDcHwType(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcHwTypeModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(
      DcHwType dataTable) async {
    DcHwTypeModel dcHwTypeModel = DcHwTypeModel.fromDcHwType(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcHwTypeModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcHwType> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcHwType> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
