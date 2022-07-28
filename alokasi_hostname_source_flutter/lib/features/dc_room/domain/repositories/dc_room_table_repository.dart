import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_room.dart';
import '../entities/dc_room_plus_filter.dart';
import '../entities/dc_room_table.dart';

abstract class DcRoomTableRepository {
  Future<Either<Failure, DcRoomTable>> getAllDataWithFilter(
      DcRoomPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcRoom dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcRoom> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcRoom dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcRoom> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcRoom> dataTable);
}
