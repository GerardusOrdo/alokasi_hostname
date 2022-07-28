import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data_table.dart';
import 'email_schedule.dart';

class EmailScheduleTable extends Equatable with MasterDataTable {
  final List<EmailSchedule> emailSchedule;

  EmailScheduleTable({
    @required this.emailSchedule,
  });

  @override
  List<Object> get props => [emailSchedule];
}
