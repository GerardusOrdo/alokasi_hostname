import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcRoom extends MasterData {
  @override
  final int id;
  final int idOwner;
  final String owner;
  final int idDcSite;
  final String dcSiteName;
  final int idRoomType;
  final String roomType;
  final String roomName;
  final int idParentRoom;
  final int x;
  final int y;
  final int width;
  final int height;
  final int rackCapacity;
  final bool isReserved;
  final String map;
  final String image;
  final String notes;
  final bool deleted;
  final String created;
  DcRoom({
    this.id,
    this.idOwner,
    this.owner,
    this.idDcSite,
    this.dcSiteName,
    this.idRoomType,
    this.roomType,
    @required this.roomName,
    this.idParentRoom,
    this.x,
    this.y,
    this.width,
    this.height,
    this.rackCapacity,
    this.isReserved,
    this.map,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });

  @override
  List<Object> get props => [
        id,
        idOwner,
        owner,
        idDcSite,
        dcSiteName,
        idRoomType,
        roomType,
        roomName,
        idParentRoom,
        x,
        y,
        width,
        height,
        rackCapacity,
        isReserved,
        map,
        image,
        notes,
        deleted,
        created,
      ];
}
