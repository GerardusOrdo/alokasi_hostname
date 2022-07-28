class DcOwnerData {
  int id;
  String owner;
  String image;
  String notes;
  bool deleted;
  String created;

  List<Object> get props => [
        id,
        owner,
        image,
        notes,
        deleted,
        created,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.owner = null;
    this.image = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
  }
}
