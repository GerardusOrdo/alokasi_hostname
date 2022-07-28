import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/data_helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import '../../domain/entities/server.dart';
import '../../domain/entities/server_table.dart';
import '../../domain/repositories/server_table_repository.dart';
import '../datasources/server_table_remote_data_source.dart';
import '../models/server_model.dart';

typedef Future<ServerTable> _SelectAction();

class ServerTableRepositoryImpl implements ServerTableRepository {
  final ServerTableRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  ServerTableRepositoryImpl({
    @required this.remoteDataSource,
    // @required this.networkInfo,
  });

  Future<Either<Failure, ServerTable>> _getFilteredDataFrom(
    _SelectAction actions,
  ) async {
    try {
      final remoteServer = await actions();
      return Right(remoteServer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // ! Select Data
  @override
  Future<Either<Failure, ServerTable>> getAllDataWithFilter(
      MasterDataFilter dataTable) async {
    return await _getFilteredDataFrom(
        () => remoteDataSource.getAllDataWithFilter(dataTable));
  }

  // ! Insert Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromInserted(
      Server dataTable) async {
    ServerModel serverModel = ServerModel.fromServer(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromInserted(serverModel));
  }

  // ! Clone Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromCloned(
      List<Server> dataTable) async {
    List<ServerModel> serverModels = [];
    dataTable.forEach((element) {
      serverModels.add(ServerModel.fromServer(element));
    });
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromCloned(serverModels));
  }

  // ! Update Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromUpdated(Server dataTable) async {
    ServerModel serverModel = ServerModel.fromServer(dataTable);
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromUpdated(serverModel));
  }

  // ! Set Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<Server> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromSetToDeleted(dataTable));
  }

  // ! Delete Data
  @override
  Future<Either<Failure, List<int>>> getIdsFromDeleted(
      List<Server> dataTable) async {
    return await DataHelper.getManiputaledIdsFrom(
        () => remoteDataSource.getIdsFromDeleted(dataTable));
  }
}
