import 'package:meta/meta.dart';

import '../../domain/entities/dc_hw_type.dart';

class DcHwTypeModel extends DcHwType {
  DcHwTypeModel({
    int id,
    @required String hwType,
  }) : super(
          id: id,
          hwType: hwType,
        );
  factory DcHwTypeModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcHwTypeModel(
      id: map['id'],
      hwType: map['hw_type'],
    );
  }

  factory DcHwTypeModel.fromDcHwType(DcHwType dcHwType) {
    if (dcHwType == null) return null;
    return DcHwTypeModel(
      id: dcHwType.id,
      hwType: dcHwType.hwType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hw_type': hwType,
    };
  }
}
