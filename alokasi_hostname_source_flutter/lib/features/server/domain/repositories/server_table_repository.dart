import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/server.dart';
import '../entities/server_plus_filter.dart';
import '../entities/server_table.dart';

abstract class ServerTableRepository {
  Future<Either<Failure, ServerTable>> getAllDataWithFilter(
      ServerPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(Server dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<Server> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(Server dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<Server> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<Server> dataTable);
}
