import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/domain/entities/master_data_filter.dart';
import 'server.dart';

/// Class ini merupakan bayangan class entities, dimana ada tambahan property filter dari mixin MasterDataFilter.
/// Class ini sebagai objek untuk filtering data dengan menggunakan property yang ada di class ini.

class ServerPlusFilter extends Server with MasterDataFilter {
  final String createdFrom;
  final String createdTo;
  final String powerOnDateFrom;
  final String powerOnDateTo;
  final String userNotifDateFrom;
  final String userNotifDateTo;
  final String powerOffDateFrom;
  final String powerOffDateTo;
  final String deleteDateFrom;
  final String deleteDateTo;
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

  ServerPlusFilter({
    int id,
    int idOwner,
    String owner,
    String serverName,
    String ip,
    int status,
    String powerOnDate,
    String userNotifDate,
    String powerOffDate,
    String deleteDate,
    String notes,
    bool deleted,
    String created,
    this.createdFrom,
    this.createdTo,
    this.powerOnDateFrom,
    this.powerOnDateTo,
    this.userNotifDateFrom,
    this.userNotifDateTo,
    this.powerOffDateFrom,
    this.powerOffDateTo,
    this.deleteDateFrom,
    this.deleteDateTo,
    this.offsets = 0,
    this.limits = 100,
    this.fieldToOrderBy = 'id',
    this.orderByAscending = true,
    this.selected = false,
    this.dataFilterByLogicalOperator = EnumLogicalOperator.and,
  }) : super(
          id: id,
          idOwner: idOwner,
          owner: owner,
          serverName: serverName,
          ip: ip,
          status: status,
          powerOnDate: powerOnDate,
          userNotifDate: userNotifDate,
          powerOffDate: powerOffDate,
          deleteDate: deleteDate,
          notes: notes,
          deleted: deleted,
          created: created,
        );

  @override
  List<Object> get props => [
        id,
        idOwner,
        owner,
        serverName,
        ip,
        status,
        powerOnDate,
        userNotifDate,
        powerOffDate,
        deleteDate,
        notes,
        deleted,
        created,
        powerOnDateFrom,
        powerOnDateTo,
        userNotifDateFrom,
        userNotifDateTo,
        powerOffDateFrom,
        powerOffDateTo,
        deleteDateFrom,
        deleteDateTo,
      ];
}
