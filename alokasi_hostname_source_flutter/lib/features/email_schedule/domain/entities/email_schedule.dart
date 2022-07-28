import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class EmailSchedule extends MasterData {
  @override
  final int id;
  final int idServer;
  final String serverName;
  final String ip;
  final String owner;
  final String email;
  @required
  final String date;
  final int state;
  final int status;
  final String notes;
  final String created;
  EmailSchedule({
    this.id,
    this.idServer,
    this.serverName,
    this.ip,
    this.owner,
    this.email,
    @required this.date,
    this.state,
    this.status,
    this.notes,
    this.created,
  });

  @override
  List<Object> get props => [
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
}
