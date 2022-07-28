import 'package:flutter/material.dart';

class DcSiteTextCtrl {
  TextEditingController id;
  TextEditingController idOwner;
  TextEditingController owner;
  TextEditingController dcSiteName;
  TextEditingController address;
  TextEditingController map;
  TextEditingController width;
  TextEditingController height;
  TextEditingController image;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  DcSiteTextCtrl({
    this.id,
    this.idOwner,
    this.owner,
    this.dcSiteName,
    this.address,
    this.map,
    this.width,
    this.height,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });
  List<TextEditingController> get props => [
        id,
        idOwner,
        owner,
        dcSiteName,
        address,
        map,
        width,
        height,
        image,
        notes,
        deleted,
        created,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.idOwner.clear();
    this.owner.clear();
    this.dcSiteName.clear();
    this.address.clear();
    this.map.clear();
    this.width.clear();
    this.height.clear();
    this.image.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
