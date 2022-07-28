import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_hw_model.dart';
import '../entities/dc_hw_model_plus_filter.dart';
import '../entities/dc_hw_model_table.dart';

abstract class DcHwModelTableRepository {
  Future<Either<Failure, DcHwModelTable>> getAllDataWithFilter(
      DcHwModelPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcHwModel dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcHwModel> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcHwModel dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcHwModel> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcHwModel> dataTable);
}
