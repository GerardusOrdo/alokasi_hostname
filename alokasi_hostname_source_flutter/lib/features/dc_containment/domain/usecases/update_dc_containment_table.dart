import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_containment.dart';
import '../repositories/dc_containment_table_repository.dart';

class UpdateDcContainmentTable implements UseCase<List<int>, DcContainment> {
  final DcContainmentTableRepository repository;

  UpdateDcContainmentTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcContainment params) async {
    return await repository.getIdsFromUpdated(params);
  }
}
