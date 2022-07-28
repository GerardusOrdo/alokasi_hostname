import 'package:meta/meta.dart';

import '../../domain/entities/dc_mounted_form.dart';

class DcMountedFormModel extends DcMountedForm {
  DcMountedFormModel({
    int id,
    @required String mountedForm,
  }) : super(
          id: id,
          mountedForm: mountedForm,
        );
  factory DcMountedFormModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DcMountedFormModel(
      id: map['id'],
      mountedForm: map['mounted_form'],
    );
  }

  factory DcMountedFormModel.fromDcMountedForm(DcMountedForm dcMountedForm) {
    if (dcMountedForm == null) return null;
    return DcMountedFormModel(
      id: dcMountedForm.id,
      mountedForm: dcMountedForm.mountedForm,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mounted_form': mountedForm,
    };
  }
}
