import 'package:meta/meta.dart';

import '../../domain/entities/dc_hw_model.dart';

class DcHwModelModel extends DcHwModel {
  DcHwModelModel({
    int id,
    String hwModel,
    String image,
    String notes,
    bool deleted,
    String created,
  }) : super(
          id: id,
          hwModel: hwModel,
          image: image,
          notes: notes,
          deleted: deleted,
          created: created,
        );
  factory DcHwModelModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcHwModelModel(
      id: map['id'],
      hwModel: map['hw_model'],
      image: map['image'],
      notes: map['notes'],
      deleted: map['deleted'],
      created: map['created'],
    );
  }

  factory DcHwModelModel.fromDcHwModel(DcHwModel dcHwModel) {
    if (dcHwModel == null) return null;
    return DcHwModelModel(
      id: dcHwModel.id,
      hwModel: dcHwModel.hwModel,
      image: dcHwModel.image,
      notes: dcHwModel.notes,
      deleted: dcHwModel.deleted,
      created: dcHwModel.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hw_model': hwModel,
      'image': image,
      'notes': notes,
      'deleted': deleted,
      'created': created,
    };
  }
}
