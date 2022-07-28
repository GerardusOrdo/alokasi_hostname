import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/owner_plus_filter.dart';
import '../entities/owner_table.dart';
import '../repositories/owner_table_repository.dart';

class SelectOwnerTable
    implements UseCase<MasterDataTable, OwnerPlusFilter> {
  final OwnerTableRepository repository;

  SelectOwnerTable(this.repository);

  @override
  Future<Either<Failure, OwnerTable>> call(OwnerPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
