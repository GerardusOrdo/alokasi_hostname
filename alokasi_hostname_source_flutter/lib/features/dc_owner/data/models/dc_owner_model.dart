import 'package:meta/meta.dart';

import '../../domain/entities/dc_owner.dart';

class DcOwnerModel extends DcOwner {
  DcOwnerModel({
    int id,
    @required String owner,
    String image,
    String notes,
    bool deleted,
    String created,
  }) : super(
          id: id,
          owner: owner,
          image: image,
          notes: notes,
          deleted: deleted,
          created: created,
        );

  factory DcOwnerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcOwnerModel(
      id: map['id'],
      owner: map['owner'],
      image: map['image'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory DcOwnerModel.fromDcOwner(DcOwner dcOwner) {
    if (dcOwner == null) return null;
    return DcOwnerModel(
      id: dcOwner.id,
      owner: dcOwner.owner,
      image: dcOwner.image,
      notes: dcOwner.notes,
      deleted: dcOwner.deleted,
      created: dcOwner.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'image': image,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
