import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_rack_plus_filter.dart';
import '../entities/dc_rack_table.dart';
import '../repositories/dc_rack_table_repository.dart';

class SelectDcRackTable implements UseCase<MasterDataTable, DcRackPlusFilter> {
  final DcRackTableRepository repository;

  SelectDcRackTable(this.repository);

  @override
  Future<Either<Failure, DcRackTable>> call(DcRackPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
