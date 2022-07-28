import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_hardware.dart';
import '../repositories/dc_hardware_table_repository.dart';

class InsertDcHardwareTable implements UseCase<List<int>, DcHardware> {
  final DcHardwareTableRepository repository;

  InsertDcHardwareTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcHardware params) async {
    return await repository.getIdsFromInserted(params);
  }
}
