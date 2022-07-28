import 'package:flutter/material.dart';

class DcRackTextCtrl {
  TextEditingController id;
  TextEditingController idOwner;
  TextEditingController owner;
  TextEditingController idRoom;
  TextEditingController roomName;
  TextEditingController idContainment;
  TextEditingController containmentName;
  TextEditingController topviewFacing;
  TextEditingController rackName;
  TextEditingController description;
  TextEditingController x;
  TextEditingController y;
  TextEditingController maxUHeight;
  TextEditingController requirePosition;
  TextEditingController width;
  TextEditingController height;
  TextEditingController isReserved;
  TextEditingController image;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  DcRackTextCtrl({
    this.id,
    this.idOwner,
    this.owner,
    this.idRoom,
    this.roomName,
    this.idContainment,
    this.containmentName,
    this.topviewFacing,
    this.rackName,
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
  List<TextEditingController> get props => [
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

  void clearAllTextCtrl() {
    this.id.clear();
    this.idOwner.clear();
    this.owner.clear();
    this.idRoom.clear();
    this.roomName.clear();
    this.idContainment.clear();
    this.containmentName.clear();
    this.topviewFacing.clear();
    this.rackName.clear();
    this.description.clear();
    this.x.clear();
    this.y.clear();
    this.maxUHeight.clear();
    this.requirePosition.clear();
    this.width.clear();
    this.height.clear();
    this.isReserved.clear();
    this.image.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
