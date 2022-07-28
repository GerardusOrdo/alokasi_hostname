import 'package:meta/meta.dart';

import '../../domain/entities/owner.dart';

class OwnerModel extends Owner {
  OwnerModel({
    int id,
    @required String owner,
    String email,
    String phone,
    String notes,
    bool deleted,
    String created,
  }) : super(
          id: id,
          owner: owner,
          email: email,
          phone: phone,
          notes: notes,
          deleted: deleted,
          created: created,
        );

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return OwnerModel(
      id: map['id'],
      owner: map['owner'],
      email: map['email'],
      phone: map['phone'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory OwnerModel.fromOwner(Owner owner) {
    if (owner == null) return null;
    return OwnerModel(
      id: owner.id,
      owner: owner.owner,
      email: owner.email,
      phone: owner.phone,
      notes: owner.notes,
      deleted: owner.deleted,
      created: owner.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'email': email,
      'phone': phone,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
