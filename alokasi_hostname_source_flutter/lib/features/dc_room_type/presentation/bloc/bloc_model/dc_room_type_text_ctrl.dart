import 'package:flutter/material.dart';

class DcRoomTypeTextCtrl {
  TextEditingController id;
  TextEditingController roomType;
  DcRoomTypeTextCtrl({
    this.id,
    this.roomType,
  });
  List<TextEditingController> get props => [
        id,
        roomType,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.roomType.clear();
  }
}
