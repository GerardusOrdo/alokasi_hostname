import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hardware.dart';
import '../repositories/dc_hardware_table_repository.dart';

class DeleteDcHardwareTable implements UseCase<List<int>, List<DcHardware>> {
  final DcHardwareTableRepository repository;

  DeleteDcHardwareTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcHardware> params) async {
    return await repository.getIdsFromDeleted(params);
  }
}
