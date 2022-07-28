import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import 'dc_rack.dart';

/// Class ini merupakan bayangan class entities, dimana ada tambahan property filter dari mixin MasterDataFilter.
/// Class ini sebagai objek untuk filtering data dengan menggunakan property yang ada di class ini.

class DcRackPlusFilter extends DcRack with MasterDataFilter {
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

  DcRackPlusFilter({
    int id,
    int idOwner,
    String owner,
    int idRoom,
    String roomName,
    int idContainment,
    String containmentName,
    int topviewFacing,
    String rackName,
    String description,
    int x,
    int y,
    int maxUHeight,
    bool requirePosition,
    int width,
    int height,
    bool isReserved,
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
          idRoom: idRoom,
          roomName: roomName,
          idContainment: idContainment,
          containmentName: containmentName,
          topviewFacing: topviewFacing,
          rackName: rackName,
          description: description,
          x: x,
          y: y,
          maxUHeight: maxUHeight,
          requirePosition: requirePosition,
          width: width,
          height: height,
          isReserved: isReserved,
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
        idRoom,
        roomName,
        idContainment,
        containmentName,
        topviewFacing,
        rackName,
        description,
        x,
        y,
        maxUHeight,
        requirePosition,
        width,
        height,
        isReserved,
        image,
        notes,
        deleted,
        created,
      ];
}
