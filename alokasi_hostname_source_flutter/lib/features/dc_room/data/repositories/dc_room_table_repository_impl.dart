import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/dc_room.dart';
import '../../domain/entities/dc_room_table.dart';
import '../../domain/repositories/dc_room_table_repository.dart';
import '../datasources/dc_room_table_remote_data_source.dart';
import '../models/dc_room_model.dart';

typedef Future<DcRoomTable> _SelectAction();

class DcRoomTableRepositoryImpl implements DcRoomTableRepository {
  final DcRoomTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  DcRoomTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, DcRoomTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteDcRoom = await actions();
      return Right(remoteDcRoom);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, DcRoomTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      DcRoom dataTable) async {
    DcRoomModel dcRoomModel = DcRoomModel.fromDcRoom(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(dcRoomModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<DcRoom> dataTable) async {
    List<DcRoomModel> dcRoomModels = [];
    dataTable.forEach((element) {
      dcRoomModels.add(DcRoomModel.fromDcRoom(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(dcRoomModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcRoom dataTable) async {
    DcRoomModel dcRoomModel = DcRoomModel.fromDcRoom(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(dcRoomModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcRoom> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<DcRoom> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
