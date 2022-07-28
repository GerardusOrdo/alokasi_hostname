import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_brand.dart';
import '../entities/dc_brand_plus_filter.dart';
import '../entities/dc_brand_table.dart';

abstract class DcBrandTableRepository {
  Future<Either<Failure, DcBrandTable>> getAllDataWithFilter(
      DcBrandPlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcBrand dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcBrand> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcBrand dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcBrand> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcBrand> dataTable);
}
