import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_hw_type.dart';

class DcHwTypeTable extends Equatable with MasterDataTable {
  final List<DcHwType> dcHwType;

  DcHwTypeTable({
    @required this.dcHwType,
  });

  @override
  List<Object> get props => [dcHwType];
}
