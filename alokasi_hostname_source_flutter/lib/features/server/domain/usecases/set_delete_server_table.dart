import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/server.dart';
import '../repositories/server_table_repository.dart';

class SetDeleteServerTable implements UseCase<List<int>, List<Server>> {
  final ServerTableRepository repository;

  SetDeleteServerTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<Server> params) async {
    return await repository.getIdsFromSetToDeleted(params);
  }
}
