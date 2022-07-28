import 'package:flutter/material.dart';

class DcBrandTextCtrl {
  TextEditingController id;
  TextEditingController brand;
  TextEditingController image;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  DcBrandTextCtrl({
    this.id,
    this.brand,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });
  List<TextEditingController> get props => [
        id,
        brand,
        image,
        notes,
        deleted,
        created,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.brand.clear();
    this.image.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
