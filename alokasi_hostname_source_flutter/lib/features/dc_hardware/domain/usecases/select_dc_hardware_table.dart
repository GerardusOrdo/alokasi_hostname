import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hardware_plus_filter.dart';
import '../entities/dc_hardware_table.dart';
import '../repositories/dc_hardware_table_repository.dart';

class SelectDcHardwareTable implements UseCase<MasterDataTable, DcHardwarePlusFilter> {
  final DcHardwareTableRepository repository;

  SelectDcHardwareTable(this.repository);

  @override
  Future<Either<Failure, DcHardwareTable>> call(DcHardwarePlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
