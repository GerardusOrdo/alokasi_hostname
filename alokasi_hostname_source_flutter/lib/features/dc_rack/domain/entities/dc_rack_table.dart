import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_rack.dart';

class DcRackTable extends Equatable with MasterDataTable {
  final List<DcRack> dcRack;

  DcRackTable({
    @required this.dcRack,
  });

  @override
  List<Object> get props => [dcRack];
}
