class EmailScheduleData {
  int id;
  int idServer;
  String serverName;
  String ip;
  String owner;
  String email;
  String date;
  String dateFrom;
  String dateTo;
  int state;
  int status;
  String notes;
  String created;

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

  void setNullToAllFields() {
    this.id = null;
    this.idServer = null;
    this.serverName = null;
    this.ip = null;
    this.owner = null;
    this.email = null;
    this.date = null;
    this.dateFrom = null;
    this.dateTo = null;
    this.state = null;
    this.status = null;
    this.notes = null;
    this.created = null;
  }
}
