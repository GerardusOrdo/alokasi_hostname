import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_hardware.dart';
import '../entities/dc_hardware_plus_filter.dart';
import '../entities/dc_hardware_table.dart';

abstract class DcHardwareTableRepository {
  Future<Either<Failure, DcHardwareTable>> getAllDataWithFilter(
      DcHardwarePlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcHardware dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcHardware> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcHardware dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcHardware> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcHardware> dataTable);
}
