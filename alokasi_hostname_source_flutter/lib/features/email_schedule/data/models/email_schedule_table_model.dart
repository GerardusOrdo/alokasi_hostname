import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/data_helper.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/entities/email_schedule_table.dart';
import 'email_schedule_model.dart';

class EmailScheduleTableModel extends EmailScheduleTable {
  EmailScheduleTableModel({
    @required List<EmailScheduleModel> emailSchedule,
  }) : super(emailSchedule: emailSchedule);

  factory EmailScheduleTableModel.fromMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
  }) {
    if (map == null || dataManipulationType == null) return null;

    Iterable iter = DataHelper.getIterableFromGraphqlResultMap(
        map: map,
        dataManipulationType: dataManipulationType,
        tableName: TableName.emailScheduleTableName,
        isSelectUsingView: true,
        viewName: TableName.emailScheduleViewName);

    EmailScheduleTableModel _getObjectFrom(Iterable iterable) {
      return EmailScheduleTableModel(
        emailSchedule: List<EmailScheduleModel>.from(
          iterable?.map(
            (element) => EmailScheduleModel.fromMap(element),
          ),
        ),
      );
    }

    return _getObjectFrom(iter);
  }
}
