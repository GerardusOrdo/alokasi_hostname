import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import 'dc_room.dart';

/// Class ini merupakan bayangan class entities, dimana ada tambahan property filter dari mixin MasterDataFilter.
/// Class ini sebagai objek untuk filtering data dengan menggunakan property yang ada di class ini.

class DcRoomPlusFilter extends DcRoom with MasterDataFilter {
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

  DcRoomPlusFilter({
    int id,
    int idOwner,
    String owner,
    int idDcSite,
    String dcSiteName,
    int idRoomType,
    String roomType,
    String roomName,
    int idParentRoom,
    int x,
    int y,
    int width,
    int height,
    int rackCapacity,
    bool isReserved,
    String map,
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
          idDcSite: idDcSite,
          dcSiteName: dcSiteName,
          idRoomType: idRoomType,
          roomType: roomType,
          roomName: roomName,
          idParentRoom: idParentRoom,
          x: x,
          y: y,
          width: width,
          height: height,
          rackCapacity: rackCapacity,
          isReserved: isReserved,
          map: map,
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
        idDcSite,
        dcSiteName,
        idRoomType,
        roomType,
        roomName,
        idParentRoom,
        x,
        y,
        width,
        height,
        rackCapacity,
        isReserved,
        map,
        image,
        notes,
        deleted,
        created,
      ];
}
