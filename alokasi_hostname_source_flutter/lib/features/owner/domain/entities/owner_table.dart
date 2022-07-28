import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'owner.dart';

class OwnerTable extends Equatable with MasterDataTable {
  final List<Owner> owner;

  OwnerTable({
    @required this.owner,
  });

  @override
  List<Object> get props => [owner];
}
