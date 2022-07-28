import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcSite extends MasterData {
  @override
  final int id;
  final int idOwner;
  final String owner;
  final String dcSiteName;
  final String address;
  final String map;
  final int width;
  final int height;
  final String image;
  final String notes;
  final bool deleted;
  final String created;

  DcSite({
    this.id,
    this.idOwner,
    this.owner,
    @required this.dcSiteName,
    this.address,
    this.map,
    this.width,
    this.height,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });

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
