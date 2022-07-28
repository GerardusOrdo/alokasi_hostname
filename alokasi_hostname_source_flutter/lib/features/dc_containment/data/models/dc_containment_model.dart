import '../../domain/entities/dc_containment.dart';

class DcContainmentModel extends DcContainment {
  DcContainmentModel({
    int id,
    int idOwner,
    String owner,
    int idDcRoom,
    String roomName,
    int topviewFacing,
    String containmentName,
    int x,
    int y,
    int width,
    int height,
    bool isReserved,
    int row,
    int column,
    String image,
    String notes,
    bool deleted,
    String created,
  }) : super(
          id: id,
          idOwner: idOwner,
          owner: owner,
          idDcRoom: idDcRoom,
          roomName: roomName,
          topviewFacing: topviewFacing,
          containmentName: containmentName,
          x: x,
          y: y,
          width: width,
          height: height,
          isReserved: isReserved,
          row: row,
          column: column,
          image: image,
          notes: notes,
          deleted: deleted,
          created: created,
        );
  factory DcContainmentModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcContainmentModel(
      id: map['id'],
      idOwner: map['id_owner'],
      owner: map['owner'],
      idDcRoom: map['id_dc_room'],
      roomName: map['room_name'],
      topviewFacing: map['topview_facing'],
      containmentName: map['containment_name'],
      x: map['x'],
      y: map['y'],
      width: map['width'],
      height: map['height'],
      isReserved: map['is_reserved'],
      row: map['row'],
      column: map['column'],
      image: map['image'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory DcContainmentModel.fromDcContainment(DcContainment dcContainment) {
    if (dcContainment == null) return null;
    return DcContainmentModel(
      id: dcContainment.id,
      idOwner: dcContainment.idOwner,
      owner: dcContainment.owner,
      idDcRoom: dcContainment.idDcRoom,
      roomName: dcContainment.roomName,
      topviewFacing: dcContainment.topviewFacing,
      containmentName: dcContainment.containmentName,
      x: dcContainment.x,
      y: dcContainment.y,
      width: dcContainment.width,
      height: dcContainment.height,
      isReserved: dcContainment.isReserved,
      row: dcContainment.row,
      column: dcContainment.column,
      image: dcContainment.image,
      notes: dcContainment.notes,
      deleted: dcContainment.deleted,
      created: dcContainment.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_owner': idOwner,
      'owner': owner,
      'id_dc_room': idDcRoom,
      'room_name': roomName,
      'topview_facing': topviewFacing,
      'containment_name': containmentName,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'is_reserved': isReserved,
      'row': row,
      'column': column,
      'image': image,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
