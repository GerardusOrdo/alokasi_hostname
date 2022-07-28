import 'package:flutter/material.dart';

class DcOwnerTextCtrl {
  TextEditingController id;
  TextEditingController owner;
  TextEditingController image;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  DcOwnerTextCtrl({
    this.id,
    this.owner,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });

  List<TextEditingController> get props => [
        id,
        owner,
        image,
        notes,
        deleted,
        created,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.owner.clear();
    this.image.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
