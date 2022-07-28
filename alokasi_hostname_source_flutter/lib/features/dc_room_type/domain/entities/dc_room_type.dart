import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcRoomType extends MasterData {
  @override
  final int id;
  final String roomType;
  DcRoomType({
    this.id,
    @required this.roomType,
  });

  @override
  List<Object> get props => [
        id,
        roomType,
      ];
}
