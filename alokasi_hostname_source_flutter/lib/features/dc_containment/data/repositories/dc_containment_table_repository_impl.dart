import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_containment.dart';
import '../../domain/entities/dc_containment_table.dart';
import '../../domain/repositories/dc_containment_table_repository.dart';
import '../datasources/dc_containment_table_remote_data_source.dart';
import '../models/dc_containment_model.dart';

typedef Future<DcContainmentTable> _SelectAction();

class DcContainmentTableRepositoryImpl implements DcContainmentTableRepository {
  final DcContainmentTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcContainmentTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcContainmentTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcContainment = await actions();
      return Right(remoteDcContainment);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcContainmentTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcContainment dataTable) async {
    DcContainmentModel dcContainmentModel = DcContainmentModel.fromDcContainment(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcContainmentModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcContainment> dataTable) async {
    List<DcContainmentModel> dcContainmentModels = [];
    dataTable.forEach((element) {
      dcContainmentModels.add(DcContainmentModel.fromDcContainment(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcContainmentModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcContainment dataTable) async {
    DcContainmentModel dcContainmentModel = DcContainmentModel.fromDcContainment(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcContainmentModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcContainment> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcContainment> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
