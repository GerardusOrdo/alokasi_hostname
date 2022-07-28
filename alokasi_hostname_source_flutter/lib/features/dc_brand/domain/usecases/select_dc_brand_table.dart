import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_brand_plus_filter.dart';
import '../entities/dc_brand_table.dart';
import '../repositories/dc_brand_table_repository.dart';

class SelectDcBrandTable
    implements UseCase<MasterDataTable, DcBrandPlusFilter> {
  final DcBrandTableRepository repository;

  SelectDcBrandTable(this.repository);

  @override
  Future<Either<Failure, DcBrandTable>> call(DcBrandPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
