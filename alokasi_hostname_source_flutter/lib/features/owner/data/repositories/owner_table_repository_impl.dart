import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/owner.dart';
import '../../domain/entities/owner_table.dart';
import '../../domain/repositories/owner_table_repository.dart';
import '../datasources/owner_table_remote_data_source.dart';
import '../models/owner_model.dart';

typedef Future<OwnerTable> _SelectAction();

class OwnerTableRepositoryImpl implements OwnerTableRepository {
  final OwnerTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  OwnerTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, OwnerTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteOwner = await actions();
      return Right(remoteOwner);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, OwnerTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      Owner dataTable) async {
    OwnerModel ownerModel = OwnerModel.fromOwner(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(ownerModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<Owner> dataTable) async {
    List<OwnerModel> ownerModels = [];
    dataTable.forEach((element) {
      ownerModels.add(OwnerModel.fromOwner(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(ownerModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(
      Owner dataTable) async {
    OwnerModel ownerModel = OwnerModel.fromOwner(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(ownerModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<Owner> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<Owner> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
