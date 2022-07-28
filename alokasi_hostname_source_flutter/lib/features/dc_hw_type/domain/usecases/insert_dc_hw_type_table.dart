import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hw_type.dart';
import '../repositories/dc_hw_type_table_repository.dart';

class InsertDcHwTypeTable implements UseCase<List<int>, DcHwType> {
  final DcHwTypeTableRepository repository;

  InsertDcHwTypeTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcHwType params) async {
    return await repository.getIdsFromInserted(params);
  }
}
