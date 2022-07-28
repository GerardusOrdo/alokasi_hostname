import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_owner.dart';
import '../repositories/dc_owner_table_repository.dart';

class UpdateDcOwnerTable implements UseCase<List<int>, DcOwner> {
  final DcOwnerTableRepository repository;

  UpdateDcOwnerTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcOwner params) async {
    return await repository.getIdsFromUpdated(params);
  }
}
