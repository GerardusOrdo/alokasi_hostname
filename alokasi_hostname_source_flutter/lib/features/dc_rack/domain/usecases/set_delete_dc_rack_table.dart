import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_rack.dart';
import '../repositories/dc_rack_table_repository.dart';

class SetDeleteDcRackTable implements UseCase<List<int>, List<DcRack>> {
  final DcRackTableRepository repository;

  SetDeleteDcRackTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcRack> params) async {
    return await repository.getIdsFromSetToDeleted(params);
  }
}
