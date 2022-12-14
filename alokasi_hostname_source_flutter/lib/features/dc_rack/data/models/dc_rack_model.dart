import '../../domain/entities/dc_rack.dart';

class DcRackModel extends DcRack {
  DcRackModel({
    int id,
    int idOwner,
    String owner,
    int idRoom,
    String roomName,
    int idContainment,
    String containmentName,
    int topviewFacing,
    String rackName,
    String description,
    int x,
    int y,
    int maxUHeight,
    bool requirePosition,
    int width,
    int height,
    bool isReserved,
    String image,
    String notes,
    bool deleted,
    String created,
  }) : super(
          id: id,
          idOwner: idOwner,
          owner: owner,
          idRoom: idRoom,
          roomName: roomName,
          idContainment: idContainment,
          containmentName: containmentName,
          topviewFacing: topviewFacing,
          rackName: rackName,
          description: description,
          x: x,
          y: y,
          maxUHeight: maxUHeight,
          requirePosition: requirePosition,
          width: width,
          height: height,
          isReserved: isReserved,
          image: image,
          notes: notes,
          deleted: deleted,
          created: created,
        );
  factory DcRackModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcRackModel(
      id: map['id'],
      idOwner: map['id_owner'],
      owner: map['owner'],
      idRoom: map['id_room'],
      roomName: map['room_name'],
      idContainment: map['id_containment'],
      containmentName: map['containment_name'],
      topviewFacing: map['topview_facing'],
      rackName: map['rack_name'],
      description: map['description'],
      x: map['x'],
      y: map['y'],
      maxUHeight: map['max_u_height'],
      requirePosition: map['require_position'],
      width: map['width'],
      height: map['height'],
      isReserved: map['is_reserved'],
      image: map['image'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory DcRackModel.fromDcRack(DcRack dcRack) {
    if (dcRack == null) return null;
    return DcRackModel(
      id: dcRack.id,
      idOwner: dcRack.idOwner,
      owner: dcRack.owner,
      idRoom: dcRack.idRoom,
      roomName: dcRack.roomName,
      idContainment: dcRack.idContainment,
      containmentName: dcRack.containmentName,
      topviewFacing: dcRack.topviewFacing,
      rackName: dcRack.rackName,
      description: dcRack.description,
      x: dcRack.x,
      y: dcRack.y,
      maxUHeight: dcRack.maxUHeight,
      requirePosition: dcRack.requirePosition,
      width: dcRack.width,
      height: dcRack.height,
      isReserved: dcRack.isReserved,
      image: dcRack.image,
      notes: dcRack.notes,
      deleted: dcRack.deleted,
      created: dcRack.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_owner': idOwner,
      'owner': owner,
      'id_room': idRoom,
      'room_name': roomName,
      'id_containment': idContainment,
      'containment_name': containmentName,
      'topview_facing': topviewFacing,
      'rack_name': rackName,
      'description': description,
      'x': x,
      'y': y,
      'max_u_height': maxUHeight,
      'require_position': requirePosition,
      'width': width,
      'height': height,
      'is_reserved': isReserved,
      'image': image,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
