import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'dc_site.dart';

class DcSiteTable extends Equatable with MasterDataTable {
  final List<DcSite> dcSite;

  DcSiteTable({
    @required this.dcSite,
  });

  @override
  List<Object> get props => [dcSite];
}
