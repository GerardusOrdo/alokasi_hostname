import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_owner.dart';
import '../repositories/dc_owner_table_repository.dart';

class CloneDcOwnerTable implements UseCase<List<int>, List<DcOwner>> {
  final DcOwnerTableRepository repository;

  CloneDcOwnerTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcOwner> params) async {
    return await repository.getIdsFromCloned(params);
  }
}
