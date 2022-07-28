import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hw_model.dart';
import '../repositories/dc_hw_model_table_repository.dart';

class InsertDcHwModelTable implements UseCase<List<int>, DcHwModel> {
  final DcHwModelTableRepository repository;

  InsertDcHwModelTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcHwModel params) async {
    return await repository.getIdsFromInserted(params);
  }
}
