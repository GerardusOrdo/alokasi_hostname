import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class Server extends MasterData {
  @override
  final int id;
  final int idOwner;
  final String owner;
  final String serverName;
  final String ip;
  final int status;
  final String powerOnDate;
  final String userNotifDate;
  final String powerOffDate;
  final String deleteDate;
  final String notes;
  final bool deleted;
  final String created;
  Server({
    this.id,
    this.idOwner,
    this.owner,
    @required this.serverName,
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

  @override
  List<Object> get props => [
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
}
