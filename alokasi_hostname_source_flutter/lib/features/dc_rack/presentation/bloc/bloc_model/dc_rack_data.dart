class DcRackData {
  int id;
  int idOwner;
  String owner;
  int idRoom;
  String roomName;
  int idContainment;
  String containmentName;
  int topviewFacing;
  String rackName;
  String description;
  int x;
  int y;
  int maxUHeight;
  bool requirePosition;
  int width;
  int height;
  bool isReserved;
  String image;
  String notes;
  bool deleted;
  String created;

  List<Object> get props => [
        id,
        idOwner,
        owner,
        idRoom,
        roomName,
        idContainment,
        containmentName,
        topviewFacing,
        rackName,
        description,
        x,
        y,
        maxUHeight,
        requirePosition,
        width,
        height,
        isReserved,
        image,
        notes,
        deleted,
        created,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.idOwner = null;
    this.owner = null;
    this.idRoom = null;
    this.roomName = null;
    this.idContainment = null;
    this.containmentName = null;
    this.topviewFacing = null;
    this.rackName = null;
    this.description = null;
    this.x = null;
    this.y = null;
    this.maxUHeight = null;
    this.requirePosition = null;
    this.width = null;
    this.height = null;
    this.isReserved = null;
    this.image = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
  }
}
