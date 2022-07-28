import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_room_type.dart';
import '../repositories/dc_room_type_table_repository.dart';

class InsertDcRoomTypeTable implements UseCase<List<int>, DcRoomType> {
  final DcRoomTypeTableRepository repository;

  InsertDcRoomTypeTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcRoomType params) async {
    return await repository.getIdsFromInserted(params);
  }
}
