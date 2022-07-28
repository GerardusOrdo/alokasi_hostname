import 'package:flutter/material.dart';

class OwnerTextCtrl {
  TextEditingController id;
  TextEditingController owner;
  TextEditingController email;
  TextEditingController phone;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  OwnerTextCtrl({
    this.id,
    this.owner,
    this.email,
    this.phone,
    this.notes,
    this.deleted,
    this.created,
  });

  List<TextEditingController> get props => [
        id,
        owner,
        email,
        phone,
        notes,
        deleted,
        created,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.owner.clear();
    this.email.clear();
    this.phone.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
