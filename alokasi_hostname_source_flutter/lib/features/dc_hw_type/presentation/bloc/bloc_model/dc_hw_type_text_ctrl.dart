import 'package:flutter/material.dart';

class DcHwTypeTextCtrl {
  TextEditingController id;
  TextEditingController hwType;
  DcHwTypeTextCtrl({
    this.id,
    this.hwType,
  });
  List<TextEditingController> get props => [
        id,
        hwType,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.hwType.clear();
  }
}
