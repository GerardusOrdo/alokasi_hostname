import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import 'email_schedule.dart';

/// Class ini merupakan bayangan class entities, dimana ada tambahan property filter dari mixin MasterDataFilter.
/// Class ini sebagai objek untuk filtering data dengan menggunakan property yang ada di class ini.

class EmailSchedulePlusFilter extends EmailSchedule with MasterDataFilter {
  final String createdFrom;
  final String createdTo;
  final String dateFrom;
  final String dateTo;
  @override
  int offsets;
  @override
  int limits;
  @override
  String fieldToOrderBy;
  @override
  bool orderByAscending;
  @override
  bool selected;
  @override
  EnumLogicalOperator dataFilterByLogicalOperator;

  EmailSchedulePlusFilter({
    int id,
    int idServer,
    String serverName,
    String ip,
    String owner,
    String email,
    String date,
    int state,
    int status,
    String notes,
    String created,
    this.createdFrom,
    this.createdTo,
    this.dateFrom,
    this.dateTo,
    this.offsets = 0,
    this.limits = 100,
    this.fieldToOrderBy = 'id',
    this.orderByAscending = true,
    this.selected = false,
    this.dataFilterByLogicalOperator = EnumLogicalOperator.and,
  }) : super(
          id: id,
          idServer: idServer,
          serverName: serverName,
          ip: ip,
          owner: owner,
          email: email,
          date: date,
          state: state,
          status: status,
          notes: notes,
          created: created,
        );

  @override
  List<Object> get props => [
        id,
        idServer,
        serverName,
        ip,
        owner,
        email,
        date,
        dateFrom,
        dateTo,
        state,
        status,
        notes,
        created,
      ];
}
