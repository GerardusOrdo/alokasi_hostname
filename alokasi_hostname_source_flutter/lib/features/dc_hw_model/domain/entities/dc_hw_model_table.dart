import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_hw_model.dart';

class DcHwModelTable extends Equatable with MasterDataTable {
  final List<DcHwModel> dcHwModel;

  DcHwModelTable({
    @required this.dcHwModel,
  });

  @override
  List<Object> get props => [dcHwModel];
}
