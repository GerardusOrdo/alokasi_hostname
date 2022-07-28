import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/owner.dart';
import '../repositories/owner_table_repository.dart';

class UpdateOwnerTable implements UseCase<List<int>, Owner> {
  final OwnerTableRepository repository;

  UpdateOwnerTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(Owner params) async {
    return await repository.getIdsFromUpdated(params);
  }
}
