import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/server_plus_filter.dart';
import '../entities/server_table.dart';
import '../repositories/server_table_repository.dart';

class SelectServerTable implements UseCase<MasterDataTable, ServerPlusFilter> {
  final ServerTableRepository repository;

  SelectServerTable(this.repository);

  @override
  Future<Either<Failure, ServerTable>> call(ServerPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
