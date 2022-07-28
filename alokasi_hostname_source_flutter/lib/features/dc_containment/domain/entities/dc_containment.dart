import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcContainment extends MasterData {
  @override
  final int id;
  final int idOwner;
  final String owner;
  final int idDcRoom;
  final String roomName;
  final int topviewFacing;
  final String containmentName;
  final int x;
  final int y;
  final int width;
  final int height;
  final bool isReserved;
  final int row;
  final int column;
  final String image;
  final String notes;
  final bool deleted;
  final String created;
  DcContainment({
    this.id,
    this.idOwner,
    this.owner,
    this.idDcRoom,
    this.roomName,
    this.topviewFacing,
    @required this.containmentName,
    this.x,
    this.y,
    this.width,
    this.height,
    this.isReserved,
    this.row,
    this.column,
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
        idDcRoom,
        roomName,
        topviewFacing,
        containmentName,
        x,
        y,
        width,
        height,
        isReserved,
        row,
        column,
        image,
        notes,
        deleted,
        created,
      ];
}
