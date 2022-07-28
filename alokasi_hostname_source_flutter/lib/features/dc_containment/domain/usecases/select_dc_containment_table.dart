import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_containment_plus_filter.dart';
import '../entities/dc_containment_table.dart';
import '../repositories/dc_containment_table_repository.dart';

class SelectDcContainmentTable implements UseCase<MasterDataTable, DcContainmentPlusFilter> {
  final DcContainmentTableRepository repository;

  SelectDcContainmentTable(this.repository);

  @override
  Future<Either<Failure, DcContainmentTable>> call(DcContainmentPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
