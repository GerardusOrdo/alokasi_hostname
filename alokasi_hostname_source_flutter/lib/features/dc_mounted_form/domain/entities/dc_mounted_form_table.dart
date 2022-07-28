import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_mounted_form.dart';

class DcMountedFormTable extends Equatable with MasterDataTable {
  final List<DcMountedForm> dcMountedForm;

  DcMountedFormTable({
    @required this.dcMountedForm,
  });

  @override
  List<Object> get props => [dcMountedForm];
}
