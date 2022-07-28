import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hw_model_plus_filter.dart';
import '../entities/dc_hw_model_table.dart';
import '../repositories/dc_hw_model_table_repository.dart';

class SelectDcHwModelTable
    implements UseCase<MasterDataTable, DcHwModelPlusFilter> {
  final DcHwModelTableRepository repository;

  SelectDcHwModelTable(this.repository);

  @override
  Future<Either<Failure, DcHwModelTable>> call(DcHwModelPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
