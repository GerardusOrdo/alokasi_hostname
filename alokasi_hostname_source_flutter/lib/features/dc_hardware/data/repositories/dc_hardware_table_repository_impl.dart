import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_hardware.dart';
import '../../domain/entities/dc_hardware_table.dart';
import '../../domain/repositories/dc_hardware_table_repository.dart';
import '../datasources/dc_hardware_table_remote_data_source.dart';
import '../models/dc_hardware_model.dart';

typedef Future<DcHardwareTable> _SelectAction();

class DcHardwareTableRepositoryImpl implements DcHardwareTableRepository {
  final DcHardwareTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcHardwareTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcHardwareTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcHardware = await actions();
      return Right(remoteDcHardware);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcHardwareTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcHardware dataTable) async {
    DcHardwareModel dcHardwareModel = DcHardwareModel.fromDcHardware(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcHardwareModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcHardware> dataTable) async {
    List<DcHardwareModel> dcHardwareModels = [];
    dataTable.forEach((element) {
      dcHardwareModels.add(DcHardwareModel.fromDcHardware(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcHardwareModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcHardware dataTable) async {
    DcHardwareModel dcHardwareModel = DcHardwareModel.fromDcHardware(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcHardwareModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcHardware> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcHardware> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
