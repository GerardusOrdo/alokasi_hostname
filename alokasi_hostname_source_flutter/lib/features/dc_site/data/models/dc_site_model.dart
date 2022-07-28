import '../../domain/entities/dc_site.dart';

class DcSiteModel extends DcSite {
  DcSiteModel({
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
  factory DcSiteModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcSiteModel(
      id: map['id'],
      idOwner: map['id_owner'],
      owner: map['owner'],
      dcSiteName: map['dc_site_name'],
      address: map['address'],
      map: map['map'],
      width: map['width'],
      height: map['height'],
      image: map['image'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory DcSiteModel.fromDcSite(DcSite dcSite) {
    if (dcSite == null) return null;
    return DcSiteModel(
      id: dcSite.id,
      idOwner: dcSite.idOwner,
      owner: dcSite.owner,
      dcSiteName: dcSite.dcSiteName,
      address: dcSite.address,
      map: dcSite.map,
      width: dcSite.width,
      height: dcSite.height,
      image: dcSite.image,
      notes: dcSite.notes,
      deleted: dcSite.deleted,
      created: dcSite.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_owner': idOwner,
      'owner': owner,
      'dc_site_name': dcSiteName,
      'address': address,
      'map': map,
      'width': width,
      'height': height,
      'image': image,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
