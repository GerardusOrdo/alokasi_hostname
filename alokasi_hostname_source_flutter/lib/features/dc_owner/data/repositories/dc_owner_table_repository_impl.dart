import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_owner.dart';
import '../../domain/entities/dc_owner_table.dart';
import '../../domain/repositories/dc_owner_table_repository.dart';
import '../datasources/dc_owner_table_remote_data_source.dart';
import '../models/dc_owner_model.dart';

typedef Future<DcOwnerTable> _SelectAction();

class DcOwnerTableRepositoryImpl implements DcOwnerTableRepository {
  final DcOwnerTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcOwnerTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcOwnerTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcOwner = await actions();
      return Right(remoteDcOwner);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcOwnerTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcOwner dataTable) async {
    DcOwnerModel dcOwnerModel = DcOwnerModel.fromDcOwner(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcOwnerModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcOwner> dataTable) async {
    List<DcOwnerModel> dcOwnerModels = [];
    dataTable.forEach((element) {
      dcOwnerModels.add(DcOwnerModel.fromDcOwner(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcOwnerModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(
      DcOwner dataTable) async {
    DcOwnerModel dcOwnerModel = DcOwnerModel.fromDcOwner(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcOwnerModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcOwner> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcOwner> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
