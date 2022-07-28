import 'package:meta/meta.dart';
import '../../domain/entities/server.dart';

class ServerModel extends Server {
  ServerModel({
    int id,
    int idOwner,
    String owner,
    @required String serverName,
    String ip,
    int status,
    String powerOnDate,
    String userNotifDate,
    String powerOffDate,
    String deleteDate,
    String notes,
    bool deleted,
    String created,
  }) : super(
          id: id,
          idOwner: idOwner,
          owner: owner,
          serverName: serverName,
          ip: ip,
          status: status,
          powerOnDate: powerOnDate,
          userNotifDate: userNotifDate,
          powerOffDate: powerOffDate,
          deleteDate: deleteDate,
          notes: notes,
          deleted: deleted,
          created: created,
        );
  factory ServerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ServerModel(
      id: map['id'],
      idOwner: map['id_owner'],
      owner: map['owner'],
      serverName: map['server_name'],
      ip: map['ip'],
      status: map['status'],
      powerOnDate: map['power_on_date'],
      userNotifDate: map['user_notif_date'],
      powerOffDate: map['power_off_date'],
      deleteDate: map['delete_date'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory ServerModel.fromServer(Server server) {
    if (server == null) return null;
    return ServerModel(
      id: server.id,
      idOwner: server.idOwner,
      owner: server.owner,
      serverName: server.serverName,
      ip: server.ip,
      status: server.status,
      powerOnDate: server.powerOnDate,
      userNotifDate: server.userNotifDate,
      powerOffDate: server.powerOffDate,
      deleteDate: server.deleteDate,
      notes: server.notes,
      deleted: server.deleted,
      created: server.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_owner': idOwner,
      'owner': owner,
      'server_name': serverName,
      'ip': ip,
      'status': status,
      'power_on_date': powerOnDate,
      'user_notif_date': userNotifDate,
      'power_off_date': powerOffDate,
      'delete_date': deleteDate,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
