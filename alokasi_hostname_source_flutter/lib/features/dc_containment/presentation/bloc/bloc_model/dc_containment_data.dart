class DcContainmentData {
  int id;
  int idOwner;
  String owner;
  int idDcRoom;
  String roomName;
  int topviewFacing;
  String containmentName;
  int x;
  int y;
  int width;
  int height;
  bool isReserved;
  int row;
  int column;
  String image;
  String notes;
  bool deleted;
  String created;

  List<Object> get props => [
        id,
        idOwner,
        owner,
        idDcRoom,
        roomName,
        topviewFacing,
        containmentName,
        x,
        y,
        width,
        height,
        isReserved,
        row,
        column,
        image,
        notes,
        deleted,
        created,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.idOwner = null;
    this.owner = null;
    this.idDcRoom = null;
    this.roomName = null;
    this.topviewFacing = null;
    this.containmentName = null;
    this.x = null;
    this.y = null;
    this.width = null;
    this.height = null;
    this.isReserved = null;
    this.row = null;
    this.column = null;
    this.image = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
  }
}
