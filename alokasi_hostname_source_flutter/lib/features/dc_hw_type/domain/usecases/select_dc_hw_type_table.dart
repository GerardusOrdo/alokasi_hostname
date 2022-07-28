import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hw_type_plus_filter.dart';
import '../entities/dc_hw_type_table.dart';
import '../repositories/dc_hw_type_table_repository.dart';

class SelectDcHwTypeTable
    implements UseCase<MasterDataTable, DcHwTypePlusFilter> {
  final DcHwTypeTableRepository repository;

  SelectDcHwTypeTable(this.repository);

  @override
  Future<Either<Failure, DcHwTypeTable>> call(DcHwTypePlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
