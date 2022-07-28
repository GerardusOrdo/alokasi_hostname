import 'package:flutter/material.dart';

class DcContainmentTextCtrl {
  TextEditingController id;
  TextEditingController idOwner;
  TextEditingController owner;
  TextEditingController idDcRoom;
  TextEditingController roomName;
  TextEditingController topviewFacing;
  TextEditingController containmentName;
  TextEditingController x;
  TextEditingController y;
  TextEditingController width;
  TextEditingController height;
  TextEditingController isReserved;
  TextEditingController row;
  TextEditingController column;
  TextEditingController image;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  DcContainmentTextCtrl({
    this.id,
    this.idOwner,
    this.owner,
    this.idDcRoom,
    this.roomName,
    this.topviewFacing,
    this.containmentName,
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
  List<TextEditingController> get props => [
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

  void clearAllTextCtrl() {
    this.id.clear();
    this.idOwner.clear();
    this.owner.clear();
    this.idDcRoom.clear();
    this.roomName.clear();
    this.topviewFacing.clear();
    this.containmentName.clear();
    this.x.clear();
    this.y.clear();
    this.width.clear();
    this.height.clear();
    this.isReserved.clear();
    this.row.clear();
    this.column.clear();
    this.image.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
