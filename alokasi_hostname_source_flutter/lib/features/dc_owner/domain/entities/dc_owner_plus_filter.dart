import 'package:meta/meta.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import 'dc_owner.dart';

/// Class ini merupakan bayangan class entities, dimana ada tambahan property filter dari mixin MasterDataFilter.
/// Class ini sebagai objek untuk filtering data dengan menggunakan property yang ada di class ini.

class DcOwnerPlusFilter extends DcOwner with MasterDataFilter {
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

  DcOwnerPlusFilter({
    int id,
    @required String owner,
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
          owner: owner,
          image: image,
          notes: notes,
          deleted: deleted,
          created: created,
        );

  @override
  List<Object> get props => [
        id,
        owner,
        image,
        notes,
        deleted,
        created,
      ];
}
