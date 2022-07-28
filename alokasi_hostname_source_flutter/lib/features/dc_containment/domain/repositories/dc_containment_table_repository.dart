import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_containment.dart';
import '../entities/dc_containment_plus_filter.dart';
import '../entities/dc_containment_table.dart';

abstract class DcContainmentTableRepository {
  Future<Either<Failure, DcContainmentTable>> getAllDataWithFilter(
      DcContainmentPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcContainment dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcContainment> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcContainment dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcContainment> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcContainment> dataTable);
}
