import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dc_site.dart';
import '../entities/dc_site_plus_filter.dart';
import '../entities/dc_site_table.dart';

abstract class DcSiteTableRepository {
  Future<Either<Failure, DcSiteTable>> getAllDataWithFilter(
      DcSitePlusFilter dataTable);
  Future<Either<Failure, List<int>>> getIdsFromInserted(DcSite dataTable);
  Future<Either<Failure, List<int>>> getIdsFromCloned(List<DcSite> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromUpdated(DcSite dataTable);
  Future<Either<Failure, List<int>>> getIdsFromSetToDeleted(
      List<DcSite> dataTable);
  Future<Either<Failure, List<int>>> getIdsFromDeleted(List<DcSite> dataTable);
}
