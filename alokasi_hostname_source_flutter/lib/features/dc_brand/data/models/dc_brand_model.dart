import 'package:meta/meta.dart';

import '../../domain/entities/dc_brand.dart';

class DcBrandModel extends DcBrand {
  DcBrandModel({
    int id,
    @required String brand,
    String image,
    String notes,
    bool deleted,
    String created,
  }) : super(
          id: id,
          brand: brand,
          image: image,
          notes: notes,
          deleted: deleted,
          created: created,
        );
  factory DcBrandModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcBrandModel(
      id: map['id'],
      brand: map['brand'],
      image: map['image'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory DcBrandModel.fromDcBrand(DcBrand dcBrand) {
    if (dcBrand == null) return null;
    return DcBrandModel(
      id: dcBrand.id,
      brand: dcBrand.brand,
      image: dcBrand.image,
      notes: dcBrand.notes,
      deleted: dcBrand.deleted,
      created: dcBrand.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'image': image,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
