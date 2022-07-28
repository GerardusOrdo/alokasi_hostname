import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/owner.dart';
import '../repositories/owner_table_repository.dart';

class SetDeleteOwnerTable implements UseCase<List<int>, List<Owner>> {
  final OwnerTableRepository repository;

  SetDeleteOwnerTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<Owner> params) async {
    return await repository.getIdsFromSetToDeleted(params);
  }
}
