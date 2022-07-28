import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_room.dart';

class DcRoomTable extends Equatable with MasterDataTable {
  final List<DcRoom> dcRoom;

  DcRoomTable({
    @required this.dcRoom,
  });

  @override
  List<Object> get props => [dcRoom];
}
