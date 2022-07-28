import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/dc_mounted_form_table.dart';
import 'dc_mounted_form_model.dart';

class DcMountedFormTableModel extends DcMountedFormTable {
  DcMountedFormTableModel({
    @required List<DcMountedFormModel> dcMountedForm,
  }) : super(dcMountedForm: dcMountedForm);

  factory DcMountedFormTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.dcMountedFormTableName,
        isSelectUsingView: true,
        viewName: TableName.dcMountedFormViewName);

    DcMountedFormTableModel _getObjectFrom(Iterable iterable) {
      return DcMountedFormTableModel(
        dcMountedForm: List<DcMountedFormModel>.from(
          iterable?.map(
            (element) => DcMountedFormModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
