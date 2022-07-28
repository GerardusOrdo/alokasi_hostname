import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_room_plus_filter.dart';
import '../entities/dc_room_table.dart';
import '../repositories/dc_room_table_repository.dart';

class SelectDcRoomTable implements UseCase<MasterDataTable, DcRoomPlusFilter> {
  final DcRoomTableRepository repository;

  SelectDcRoomTable(this.repository);

  @override
  Future<Either<Failure, DcRoomTable>> call(DcRoomPlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
