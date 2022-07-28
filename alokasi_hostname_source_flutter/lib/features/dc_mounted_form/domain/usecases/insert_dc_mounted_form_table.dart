import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_mounted_form.dart';
import '../repositories/dc_mounted_form_table_repository.dart';

class InsertDcMountedFormTable implements UseCase<List<int>, DcMountedForm> {
  final DcMountedFormTableRepository repository;

  InsertDcMountedFormTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcMountedForm params) async {
    return await repository.getIdsFromInserted(params);
  }
}
