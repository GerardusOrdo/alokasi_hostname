import 'package:flutter/material.dart';

class DcMountedFormTextCtrl {
  TextEditingController id;
  TextEditingController mountedForm;
  DcMountedFormTextCtrl({
    this.id,
    this.mountedForm,
  });
  List<TextEditingController> get props => [
        id,
        mountedForm,
      ];

  void clearAllTextCtrl() {
    this.id.clear();
    this.mountedForm.clear();
  }
}
