import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/owner.dart';
import '../repositories/owner_table_repository.dart';

class CloneOwnerTable implements UseCase<List<int>, List<Owner>> {
  final OwnerTableRepository repository;

  CloneOwnerTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<Owner> params) async {
    return await repository.getIdsFromCloned(params);
  }
}
