import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hw_model.dart';
import '../repositories/dc_hw_model_table_repository.dart';

class CloneDcHwModelTable implements UseCase<List<int>, List<DcHwModel>> {
  final DcHwModelTableRepository repository;

  CloneDcHwModelTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcHwModel> params) async {
    return await repository.getIdsFromCloned(params);
  }
}
