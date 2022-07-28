import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_room_type.dart';
import '../repositories/dc_room_type_table_repository.dart';

class UpdateDcRoomTypeTable implements UseCase<List<int>, DcRoomType> {
  final DcRoomTypeTableRepository repository;

  UpdateDcRoomTypeTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcRoomType params) async {
    return await repository.getIdsFromUpdated(params);
  }
}
