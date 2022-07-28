import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_mounted_form.dart';
import '../repositories/dc_mounted_form_table_repository.dart';

class DeleteDcMountedFormTable implements UseCase<List<int>, List<DcMountedForm>> {
  final DcMountedFormTableRepository repository;

  DeleteDcMountedFormTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcMountedForm> params) async {
    return await repository.getIdsFromDeleted(params);
  }
}
