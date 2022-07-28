import 'package:flutter/material.dart';

class DcHwModelTextCtrl {
  TextEditingController id;
  TextEditingController hwModel;
  TextEditingController image;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  DcHwModelTextCtrl({
    this.id,
    this.hwModel,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });

  List<TextEditingController> get props => [
        id,
        hwModel,
        image,
        notes,
        deleted,
        created,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.hwModel.clear();
    this.image.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
