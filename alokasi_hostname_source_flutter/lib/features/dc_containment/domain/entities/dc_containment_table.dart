import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_containment.dart';

class DcContainmentTable extends Equatable with MasterDataTable {
  final List<DcContainment> dcContainment;

  DcContainmentTable({
    @required this.dcContainment,
  });

  @override
  List<Object> get props => [dcContainment];
}
