import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_brand.dart';
import '../../domain/entities/dc_brand_table.dart';
import '../../domain/repositories/dc_brand_table_repository.dart';
import '../datasources/dc_brand_table_remote_data_source.dart';
import '../models/dc_brand_model.dart';

typedef Future<DcBrandTable> _SelectAction();

class DcBrandTableRepositoryImpl implements DcBrandTableRepository {
  final DcBrandTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcBrandTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcBrandTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcBrand = await actions();
      return Right(remoteDcBrand);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcBrandTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcBrand dataTable) async {
    DcBrandModel dcBrandModel = DcBrandModel.fromDcBrand(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcBrandModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcBrand> dataTable) async {
    List<DcBrandModel> dcBrandModels = [];
    dataTable.forEach((element) {
      dcBrandModels.add(DcBrandModel.fromDcBrand(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcBrandModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(
      DcBrand dataTable) async {
    DcBrandModel dcBrandModel = DcBrandModel.fromDcBrand(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcBrandModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcBrand> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcBrand> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
