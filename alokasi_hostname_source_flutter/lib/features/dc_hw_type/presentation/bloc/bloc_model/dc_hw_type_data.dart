class DcHwTypeData {
  int id;
  String hwType;

  List<Object> get props => [
        id,
        hwType,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.hwType = null;
  }
}
