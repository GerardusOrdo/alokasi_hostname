import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_room_type.dart';
import '../entities/dc_room_type_plus_filter.dart';
import '../entities/dc_room_type_table.dart';

abstract class DcRoomTypeTableRepository {
  Future<Either<Failure, DcRoomTypeTable>> getAllDataWithFilter(
      DcRoomTypePlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcRoomType dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcRoomType> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcRoomType dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcRoomType> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcRoomType> dataTable);
}
