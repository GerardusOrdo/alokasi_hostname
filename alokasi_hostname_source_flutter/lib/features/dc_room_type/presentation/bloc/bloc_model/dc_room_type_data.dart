class DcRoomTypeData {
  int id;
  String roomType;

  List<Object> get props => [
        id,
        roomType,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.roomType = null;
  }
}
