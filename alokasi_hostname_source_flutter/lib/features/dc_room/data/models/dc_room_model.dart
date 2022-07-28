import '../../domain/entities/dc_room.dart';

class DcRoomModel extends DcRoom {
  DcRoomModel({
    int id,
    int idOwner,
    String owner,
    int idDcSite,
    String dcSiteName,
    int idRoomType,
    String roomType,
    String roomName,
    int idParentRoom,
    int x,
    int y,
    int width,
    int height,
    int rackCapacity,
    bool isReserved,
    String map,
    String image,
    String notes,
    bool deleted,
    String created,
  }) : super(
          id: id,
          idOwner: idOwner,
          owner: owner,
          idDcSite: idDcSite,
          dcSiteName: dcSiteName,
          idRoomType: idRoomType,
          roomType: roomType,
          roomName: roomName,
          idParentRoom: idParentRoom,
          x: x,
          y: y,
          width: width,
          height: height,
          rackCapacity: rackCapacity,
          isReserved: isReserved,
          map: map,
          image: image,
          notes: notes,
          deleted: deleted,
          created: created,
        );

  factory DcRoomModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcRoomModel(
      id: map['id'],
      idOwner: map['id_owner'],
      owner: map['owner'],
      idDcSite: map['id_dc_site'],
      dcSiteName: map['dc_site_name'],
      idRoomType: map['id_room_type'],
      roomType: map['room_type'],
      roomName: map['room_name'],
      idParentRoom: map['id_parent_room'],
      x: map['x'],
      y: map['y'],
      width: map['width'],
      height: map['height'],
      rackCapacity: map['rack_capacity'],
      isReserved: map['is_reserved'],
      map: map['map'],
      image: map['image'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory DcRoomModel.fromDcRoom(DcRoom dcRoom) {
    if (dcRoom == null) return null;
    return DcRoomModel(
      id: dcRoom.id,
      idOwner: dcRoom.idOwner,
      owner: dcRoom.owner,
      idDcSite: dcRoom.idDcSite,
      dcSiteName: dcRoom.dcSiteName,
      idRoomType: dcRoom.idRoomType,
      roomType: dcRoom.roomType,
      roomName: dcRoom.roomName,
      idParentRoom: dcRoom.idParentRoom,
      x: dcRoom.x,
      y: dcRoom.y,
      width: dcRoom.width,
      height: dcRoom.height,
      rackCapacity: dcRoom.rackCapacity,
      isReserved: dcRoom.isReserved,
      map: dcRoom.map,
      image: dcRoom.image,
      notes: dcRoom.notes,
      deleted: dcRoom.deleted,
      created: dcRoom.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_owner': idOwner,
      'owner': owner,
      'id_dc_site': idDcSite,
      'dc_site_name': dcSiteName,
      'id_room_type': idRoomType,
      'room_type': roomType,
      'room_name': roomName,
      'id_parent_room': idParentRoom,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'rack_capacity': rackCapacity,
      'is_reserved': isReserved,
      'map': map,
      'image': image,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
