class DcRoomData {
  int id;
  int idOwner;
  String owner;
  int idDcSite;
  String dcSiteName;
  int idRoomType;
  String roomType;
  String roomName;
  int idParentRoom;
  int x;
  int y;
  int width;
  int height;
  int rackCapacity;
  bool isReserved;
  String map;
  String image;
  String notes;
  bool deleted;
  String created;

  List<Object> get props => [
        id,
        idOwner,
        owner,
        idDcSite,
        dcSiteName,
        idRoomType,
        roomType,
        roomName,
        idParentRoom,
        x,
        y,
        width,
        height,
        rackCapacity,
        isReserved,
        map,
        image,
        notes,
        deleted,
        created,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.idOwner = null;
    this.owner = null;
    this.idDcSite = null;
    this.dcSiteName = null;
    this.idRoomType = null;
    this.roomType = null;
    this.roomName = null;
    this.idParentRoom = null;
    this.x = null;
    this.y = null;
    this.width = null;
    this.height = null;
    this.rackCapacity = null;
    this.isReserved = null;
    this.map = null;
    this.image = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
  }
}
