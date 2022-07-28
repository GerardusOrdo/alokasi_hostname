import 'package:flutter/material.dart';

class DcRoomTextCtrl {
  TextEditingController id;
  TextEditingController idOwner;
  TextEditingController owner;
  TextEditingController idDcSite;
  TextEditingController dcSiteName;
  TextEditingController idRoomType;
  TextEditingController roomType;
  TextEditingController roomName;
  TextEditingController idParentRoom;
  TextEditingController x;
  TextEditingController y;
  TextEditingController width;
  TextEditingController height;
  TextEditingController rackCapacity;
  TextEditingController isReserved;
  TextEditingController map;
  TextEditingController image;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  DcRoomTextCtrl({
    this.id,
    this.idOwner,
    this.owner,
    this.idDcSite,
    this.dcSiteName,
    this.idRoomType,
    this.roomType,
    this.roomName,
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
  List<TextEditingController> get props => [
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

  void clearAllTextCtrl() {
    this.id.clear();
    this.idOwner.clear();
    this.owner.clear();
    this.idDcSite.clear();
    this.dcSiteName.clear();
    this.idRoomType.clear();
    this.roomType.clear();
    this.roomName.clear();
    this.idParentRoom.clear();
    this.x.clear();
    this.y.clear();
    this.width.clear();
    this.height.clear();
    this.rackCapacity.clear();
    this.isReserved.clear();
    this.map.clear();
    this.image.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
