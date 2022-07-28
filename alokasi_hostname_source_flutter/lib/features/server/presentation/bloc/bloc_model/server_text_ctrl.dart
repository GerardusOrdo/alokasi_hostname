import 'package:flutter/material.dart';

class ServerTextCtrl {
  TextEditingController id;
  TextEditingController idOwner;
  TextEditingController owner;
  TextEditingController serverName;
  TextEditingController ip;
  TextEditingController status;
  TextEditingController powerOnDate;
  TextEditingController userNotifDate;
  TextEditingController powerOffDate;
  TextEditingController deleteDate;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController created;
  ServerTextCtrl({
    this.id,
    this.idOwner,
    this.owner,
    this.serverName,
    this.ip,
    this.status,
    this.powerOnDate,
    this.userNotifDate,
    this.powerOffDate,
    this.deleteDate,
    this.notes,
    this.deleted,
    this.created,
  });
  List<TextEditingController> get props => [
        id,
        idOwner,
        owner,
        serverName,
        ip,
        status,
        powerOnDate,
        userNotifDate,
        powerOffDate,
        deleteDate,
        notes,
        deleted,
        created,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.idOwner.clear();
    this.owner.clear();
    this.serverName.clear();
    this.ip.clear();
    this.status.clear();
    this.powerOnDate.clear();
    this.userNotifDate.clear();
    this.powerOffDate.clear();
    this.deleteDate.clear();
    this.notes.clear();
    this.deleted.clear();
    this.created.clear();
  }
}
