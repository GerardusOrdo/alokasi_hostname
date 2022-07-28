import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcRack extends MasterData {
  @override
  final int id;
  final int idOwner;
  final String owner;
  final int idRoom;
  final String roomName;
  final int idContainment;
  final String containmentName;
  final int topviewFacing;
  final String rackName;
  final String description;
  final int x;
  final int y;
  final int maxUHeight;
  final bool requirePosition;
  final int width;
  final int height;
  final bool isReserved;
  final String image;
  final String notes;
  final bool deleted;
  final String created;
  DcRack({
    this.id,
    this.idOwner,
    this.owner,
    this.idRoom,
    this.roomName,
    this.idContainment,
    this.containmentName,
    this.topviewFacing,
    @required this.rackName,
    this.description,
    this.x,
    this.y,
    this.maxUHeight,
    this.requirePosition,
    this.width,
    this.height,
    this.isReserved,
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
        idRoom,
        roomName,
        idContainment,
        containmentName,
        topviewFacing,
        rackName,
        description,
        x,
        y,
        maxUHeight,
        requirePosition,
        width,
        height,
        isReserved,
        image,
        notes,
        deleted,
        created,
      ];
}
