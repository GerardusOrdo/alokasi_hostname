import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_site_plus_filter.dart';
import '../entities/dc_site_table.dart';
import '../repositories/dc_site_table_repository.dart';

class SelectDcSiteTable implements UseCase<MasterDataTable, DcSitePlusFilter> {
  final DcSiteTableRepository repository;

  SelectDcSiteTable(this.repository);

  @override
  Future<Either<Failure, DcSiteTable>> call(DcSitePlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
