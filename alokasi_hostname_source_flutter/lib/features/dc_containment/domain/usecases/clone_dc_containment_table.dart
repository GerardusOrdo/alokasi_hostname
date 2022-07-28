import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_containment.dart';
import '../repositories/dc_containment_table_repository.dart';

class CloneDcContainmentTable implements UseCase<List<int>, List<DcContainment>> {
  final DcContainmentTableRepository repository;

  CloneDcContainmentTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcContainment> params) async {
    return await repository.getIdsFromCloned(params);
  }
}
