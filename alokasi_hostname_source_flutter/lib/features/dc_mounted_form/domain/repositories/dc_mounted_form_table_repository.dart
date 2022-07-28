import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_mounted_form.dart';
import '../entities/dc_mounted_form_plus_filter.dart';
import '../entities/dc_mounted_form_table.dart';

abstract class DcMountedFormTableRepository {
  Future<Either<Failure, DcMountedFormTable>> getAllDataWithFilter(
      DcMountedFormPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcMountedForm dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcMountedForm> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcMountedForm dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcMountedForm> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcMountedForm> dataTable);
}
