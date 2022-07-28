import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_brand.dart';

class DcBrandTable extends Equatable with MasterDataTable {
  final List<DcBrand> dcBrand;

  DcBrandTable({
    @required this.dcBrand,
  });

  @override
  List<Object> get props => [dcBrand];
}
