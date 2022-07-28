class DcSiteData {
  int id;
  int idOwner;
  String owner;
  String dcSiteName;
  String address;
  String map;
  int width;
  int height;
  String image;
  String notes;
  bool deleted;
  String created;

  List<Object> get props => [
        id,
        idOwner,
        owner,
        dcSiteName,
        address,
        map,
        width,
        height,
        image,
        notes,
        deleted,
        created,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.idOwner = null;
    this.owner = null;
    this.dcSiteName = null;
    this.address = null;
    this.map = null;
    this.width = null;
    this.height = null;
    this.image = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
  }
}
