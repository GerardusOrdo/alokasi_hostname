import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_room_type.dart';
import '../repositories/dc_room_type_table_repository.dart';

class DeleteDcRoomTypeTable implements UseCase<List<int>, List<DcRoomType>> {
  final DcRoomTypeTableRepository repository;

  DeleteDcRoomTypeTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcRoomType> params) async {
    return await repository.getIdsFromDeleted(params);
  }
}
