import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_room.dart';
import '../repositories/dc_room_table_repository.dart';

class UpdateDcRoomTable implements UseCase<List<int>, DcRoom> {
  final DcRoomTableRepository repository;

  UpdateDcRoomTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcRoom params) async {
    return await repository.getIdsFromUpdated(params);
  }
}
