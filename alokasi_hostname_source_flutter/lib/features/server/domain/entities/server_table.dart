import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'server.dart';

class ServerTable extends Equatable with MasterDataTable {
  final List<Server> server;

  ServerTable({
    @required this.server,
  });

  @override
  List<Object> get props => [server];
}
