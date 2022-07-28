import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/server.dart';
import '../repositories/server_table_repository.dart';

class InsertServerTable implements UseCase<List<int>, Server> {
  final ServerTableRepository repository;

  InsertServerTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(Server params) async {
    return await repository.getIdsFromInserted(params);
  }
}
