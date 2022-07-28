import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_rack.dart';
import '../repositories/dc_rack_table_repository.dart';

class UpdateDcRackTable implements UseCase<List<int>, DcRack> {
  final DcRackTableRepository repository;

  UpdateDcRackTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcRack params) async {
    return await repository.getIdsFromUpdated(params);
  }
}
