import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_site.dart';
import '../repositories/dc_site_table_repository.dart';

class InsertDcSiteTable implements UseCase<List<int>, DcSite> {
  final DcSiteTableRepository repository;

  InsertDcSiteTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcSite params) async {
    return await repository.getIdsFromInserted(params);
  }
}
