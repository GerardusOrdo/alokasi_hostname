import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_room.dart';
import '../repositories/dc_room_table_repository.dart';

class DeleteDcRoomTable implements UseCase<List<int>, List<DcRoom>> {
  final DcRoomTableRepository repository;

  DeleteDcRoomTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcRoom> params) async {
    return await repository.getIdsFromDeleted(params);
  }
}
