import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_owner.dart';
import '../entities/dc_owner_plus_filter.dart';
import '../entities/dc_owner_table.dart';

abstract class DcOwnerTableRepository {
  Future<Either<Failure, DcOwnerTable>> getAllDataWithFilter(
      DcOwnerPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcOwner dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcOwner> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcOwner dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcOwner> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcOwner> dataTable);
}
