class ServerData {
  int id;
  int idOwner;
  String owner;
  String serverName;
  String ip;
  int status;
  String powerOnDate;
  String userNotifDate;
  String powerOffDate;
  String deleteDate;
  String notes;
  bool deleted;
  String created;
  String powerOnDateFrom;
  String powerOnDateTo;
  String userNotifDateFrom;
  String userNotifDateTo;
  String powerOffDateFrom;
  String powerOffDateTo;
  String deleteDateFrom;
  String deleteDateTo;

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

  void setNullToAllFields() {
    this.id = null;
    this.idOwner = null;
    this.owner = null;
    this.serverName = null;
    this.ip = null;
    this.status = null;
    this.powerOnDate = null;
    this.userNotifDate = null;
    this.powerOffDate = null;
    this.deleteDate = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
    this.powerOnDateFrom = null;
    this.powerOnDateTo = null;
    this.userNotifDateFrom = null;
    this.userNotifDateTo = null;
    this.powerOffDateFrom = null;
    this.powerOffDateTo = null;
    this.deleteDateFrom = null;
    this.deleteDateTo = null;
  }
}
