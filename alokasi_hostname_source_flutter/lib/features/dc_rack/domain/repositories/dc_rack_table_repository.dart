import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_rack.dart';
import '../entities/dc_rack_plus_filter.dart';
import '../entities/dc_rack_table.dart';

abstract class DcRackTableRepository {
  Future<Either<Failure, DcRackTable>> getAllDataWithFilter(
      DcRackPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcRack dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcRack> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcRack dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcRack> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcRack> dataTable);
}
