import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_owner.dart';

class DcOwnerTable extends Equatable with MasterDataTable {
  final List<DcOwner> dcOwner;

  DcOwnerTable({
    @required this.dcOwner,
  });

  @override
  List<Object> get props => [dcOwner];
}
