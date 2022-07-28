import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_room_type.dart';

class DcRoomTypeTable extends Equatable with MasterDataTable {
  final List<DcRoomType> dcRoomType;

  DcRoomTypeTable({
    @required this.dcRoomType,
  });

  @override
  List<Object> get props => [dcRoomType];
}
