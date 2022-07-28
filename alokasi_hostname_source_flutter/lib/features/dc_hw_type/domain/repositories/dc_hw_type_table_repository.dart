import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_hw_type.dart';
import '../entities/dc_hw_type_plus_filter.dart';
import '../entities/dc_hw_type_table.dart';

abstract class DcHwTypeTableRepository {
  Future<Either<Failure, DcHwTypeTable>> getAllDataWithFilter(
      DcHwTypePlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcHwType dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcHwType> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcHwType dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcHwType> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcHwType> dataTable);
}
