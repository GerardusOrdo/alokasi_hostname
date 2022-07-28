import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hw_type.dart';
import '../repositories/dc_hw_type_table_repository.dart';

class SetDeleteDcHwTypeTable implements UseCase<List<int>, List<DcHwType>> {
  final DcHwTypeTableRepository repository;

  SetDeleteDcHwTypeTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcHwType> params) async {
    return await repository.getIdsFromSetToDeleted(params);
  }
}
