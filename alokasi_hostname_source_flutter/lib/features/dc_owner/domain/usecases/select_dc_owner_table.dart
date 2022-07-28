import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_owner_plus_filter.dart';
import '../entities/dc_owner_table.dart';
import '../repositories/dc_owner_table_repository.dart';

class SelectDcOwnerTable
    implements UseCase<MasterDataTable, DcOwnerPlusFilter> {
  final DcOwnerTableRepository repository;

  SelectDcOwnerTable(this.repository);

  @override
  Future<Either<Failure, DcOwnerTable>> call(DcOwnerPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
