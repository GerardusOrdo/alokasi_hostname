import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_room_type_plus_filter.dart';
import '../entities/dc_room_type_table.dart';
import '../repositories/dc_room_type_table_repository.dart';

class SelectDcRoomTypeTable
    implements UseCase<MasterDataTable, DcRoomTypePlusFilter> {
  final DcRoomTypeTableRepository repository;

  SelectDcRoomTypeTable(this.repository);

  @override
  Future<Either<Failure, DcRoomTypeTable>> call(DcRoomTypePlusFilter params) async {
    return await repository.getAllDataWithFilter(params);
  }
}
