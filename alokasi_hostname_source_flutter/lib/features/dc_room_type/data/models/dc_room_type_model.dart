import 'package:meta/meta.dart';

import '../../domain/entities/dc_room_type.dart';

class DcRoomTypeModel extends DcRoomType {
  DcRoomTypeModel({
    int id,
    @required String roomType,
  }) : super(
          id: id,
          roomType: roomType,
        );
  factory DcRoomTypeModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcRoomTypeModel(
      id: map['id'],
      roomType: map['room_type'],
    );
  }

  factory DcRoomTypeModel.fromDcRoomType(DcRoomType dcRoomType) {
    if (dcRoomType == null) return null;
    return DcRoomTypeModel(
      id: dcRoomType.id,
      roomType: dcRoomType.roomType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_type': roomType,
    };
  }
}
