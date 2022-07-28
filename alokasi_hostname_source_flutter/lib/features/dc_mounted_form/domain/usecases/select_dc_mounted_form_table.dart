import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_mounted_form_plus_filter.dart';
import '../entities/dc_mounted_form_table.dart';
import '../repositories/dc_mounted_form_table_repository.dart';

class SelectDcMountedFormTable
    implements UseCase<MasterDataTable, DcMountedFormPlusFilter> {
  final DcMountedFormTableRepository repository;

  SelectDcMountedFormTable(this.repository);

  @override
  Future<Either<Failure, DcMountedFormTable>> call(DcMountedFormPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
