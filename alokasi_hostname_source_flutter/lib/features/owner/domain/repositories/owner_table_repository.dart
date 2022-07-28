import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/owner.dart';
import '../entities/owner_plus_filter.dart';
import '../entities/owner_table.dart';

abstract class OwnerTableRepository {
  Future<Either<Failure, OwnerTable>> getAllDataWithFilter(
      OwnerPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(Owner dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<Owner> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(Owner dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<Owner> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<Owner> dataTable);
}
