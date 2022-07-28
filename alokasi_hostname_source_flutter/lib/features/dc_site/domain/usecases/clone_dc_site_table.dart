import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_site.dart';
import '../repositories/dc_site_table_repository.dart';

class CloneDcSiteTable implements UseCase<List<int>, List<DcSite>> {
  final DcSiteTableRepository repository;

  CloneDcSiteTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcSite> params) async {
    return await repository.getIdsFromCloned(params);
  }
}
