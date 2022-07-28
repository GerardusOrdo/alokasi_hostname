import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_hardware.dart';

class DcHardwareTable extends Equatable with MasterDataTable {
  final List<DcHardware> dcHardware;

  DcHardwareTable({
    @required this.dcHardware,
  });

  @override
  List<Object> get props => [dcHardware];
}
