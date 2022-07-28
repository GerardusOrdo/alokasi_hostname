import 'package:meta/meta.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import 'dc_site.dart';

/// Class ini merupakan bayangan class entities, dimana ada tambahan property filter dari mixin MasterDataFilter.
/// Class ini sebagai objek untuk filtering data dengan menggunakan property yang ada di class ini.

class DcSitePlusFilter extends DcSite with MasterDataFilter {
  final String createdFrom;
  final String createdTo;
  @override
  int offsets;
  @override
  int limits;
  @override
  String fieldToOrderBy;
  @override
  bool orderByAscending;
  @override
  bool selected;
  @override
  EnumLogicalOperator dataFilterByLogicalOperator;

  DcSitePlusFilter({
    int id,
    int idOwner,
    String owner,
    String dcSiteName,
    String address,
    String map,
    int width,
    int height,
    String image,
    String notes,
    bool deleted,
    String created,
    this.createdFrom,
    this.createdTo,
    this.offsets = 0,
    this.limits = 100,
    this.fieldToOrderBy = 'id',
    this.orderByAscending = true,
    this.selected = false,
    this.dataFilterByLogicalOperator = EnumLogicalOperator.and,
  }) : super(
          id: id,
          idOwner: idOwner,
          owner: owner,
          dcSiteName: dcSiteName,
          address: address,
          map: map,
          width: width,
          height: height,
          image: image,
          notes: notes,
          deleted: deleted,
          created: created,
        );

  @override
  List<Object> get props => [
        id,
        idOwner,
        owner,
        dcSiteName,
        address,
        map,
        width,
        height,
        image,
        notes,
        deleted,
        created,
      ];
}
