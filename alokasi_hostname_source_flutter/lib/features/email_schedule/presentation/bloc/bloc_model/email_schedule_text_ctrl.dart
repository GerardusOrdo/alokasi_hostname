import 'package:flutter/material.dart';

class EmailScheduleTextCtrl {
  TextEditingController id;
  TextEditingController idServer;
  TextEditingController serverName;
  TextEditingController ip;
  TextEditingController owner;
  TextEditingController email;
  TextEditingController date;
  TextEditingController state;
  TextEditingController status;
  TextEditingController notes;
  TextEditingController created;
  EmailScheduleTextCtrl({
    this.id,
    this.idServer,
    this.serverName,
    this.ip,
    this.owner,
    this.email,
    this.date,
    this.state,
    this.status,
    this.notes,
    this.created,
  });
  List<TextEditingController> get props => [
        id,
        idServer,
        serverName,
        ip,
        owner,
        email,
        date,
        state,
        status,
        notes,
        created,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.idServer.clear();
    this.serverName.clear();
    this.ip.clear();
    this.owner.clear();
    this.email.clear();
    this.date.clear();
    this.state.clear();
    this.status.clear();
    this.notes.clear();
    this.created.clear();
  }
}
