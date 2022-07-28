import 'package:meta/meta.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import 'dc_containment.dart';

/// Class ini merupakan bayangan class entities, dimana ada tambahan property filter dari mixin MasterDataFilter.
/// Class ini sebagai objek untuk filtering data dengan menggunakan property yang ada di class ini.

class DcContainmentPlusFilter extends DcContainment with MasterDataFilter {
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

  DcContainmentPlusFilter({
    int id,
    int idOwner,
    String owner,
    int idDcRoom,
    String roomName,
    int topviewFacing,
    String containmentName,
    int x,
    int y,
    int width,
    int height,
    bool isReserved,
    int row,
    int column,
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
          idDcRoom: idDcRoom,
          roomName: roomName,
          topviewFacing: topviewFacing,
          containmentName: containmentName,
          x: x,
          y: y,
          width: width,
          height: height,
          isReserved: isReserved,
          row: row,
          column: column,
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
        idDcRoom,
        roomName,
        topviewFacing,
        containmentName,
        x,
        y,
        width,
        height,
        isReserved,
        row,
        column,
        image,
        notes,
        deleted,
        created,
      ];
}
