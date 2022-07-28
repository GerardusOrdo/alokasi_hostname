import 'package:meta/meta.dart';
import '../../domain/entities/email_schedule.dart';

class EmailScheduleModel extends EmailSchedule {
  EmailScheduleModel({
    int id,
    int idServer,
    String serverName,
    String ip,
    String owner,
    String email,
    @required String date,
    int state,
    int status,
    String notes,
    String created,
  }) : super(
          id: id,
          idServer: idServer,
          serverName: serverName,
          ip: ip,
          owner: owner,
          email: email,
          date: date,
          state: state,
          status: status,
          notes: notes,
          created: created,
        );
  factory EmailScheduleModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return EmailScheduleModel(
      id: map['id'],
      idServer: map['id_server'],
      serverName: map['server_name'],
      ip: map['ip'],
      owner: map['owner'],
      email: map['email'],
      date: map['date'],
      state: map['state'],
      status: map['status'],
      notes: map['notes'],
      created: map['created'],
    );
  }

  factory EmailScheduleModel.fromEmailSchedule(EmailSchedule emailSchedule) {
    if (emailSchedule == null) return null;
    return EmailScheduleModel(
      id: emailSchedule.id,
      idServer: emailSchedule.idServer,
      serverName: emailSchedule.serverName,
      ip: emailSchedule.ip,
      owner: emailSchedule.owner,
      email: emailSchedule.email,
      date: emailSchedule.date,
      state: emailSchedule.state,
      status: emailSchedule.status,
      notes: emailSchedule.notes,
      created: emailSchedule.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_server': idServer,
      'server_name': serverName,
      'ip': ip,
      'owner': owner,
      'email': email,
      'date': date,
      'state': state,
      'status': status,
      'notes': notes,
      'created': created,
    };
  }
}
