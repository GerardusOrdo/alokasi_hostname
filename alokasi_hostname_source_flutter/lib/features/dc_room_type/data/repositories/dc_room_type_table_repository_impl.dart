import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_room_type.dart';
import '../../domain/entities/dc_room_type_table.dart';
import '../../domain/repositories/dc_room_type_table_repository.dart';
import '../datasources/dc_room_type_table_remote_data_source.dart';
import '../models/dc_room_type_model.dart';

typedef Future<DcRoomTypeTable> _SelectAction();

class DcRoomTypeTableRepositoryImpl implements DcRoomTypeTableRepository {
  final DcRoomTypeTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcRoomTypeTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcRoomTypeTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcRoomType = await actions();
      return Right(remoteDcRoomType);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcRoomTypeTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcRoomType dataTable) async {
    DcRoomTypeModel dcRoomTypeModel = DcRoomTypeModel.fromDcRoomType(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcRoomTypeModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcRoomType> dataTable) async {
    List<DcRoomTypeModel> dcRoomTypeModels = [];
    dataTable.forEach((element) {
      dcRoomTypeModels.add(DcRoomTypeModel.fromDcRoomType(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcRoomTypeModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(
      DcRoomType dataTable) async {
    DcRoomTypeModel dcRoomTypeModel = DcRoomTypeModel.fromDcRoomType(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcRoomTypeModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcRoomType> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcRoomType> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
