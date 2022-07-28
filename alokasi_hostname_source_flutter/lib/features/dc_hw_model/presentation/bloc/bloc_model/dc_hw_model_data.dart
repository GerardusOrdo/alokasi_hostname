class DcHwModelData {
  int id;
  String hwModel;
  String image;
  String notes;
  bool deleted;
  String created;

  List<Object> get props => [
        id,
        hwModel,
        image,
        notes,
        deleted,
        created,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.hwModel = null;
    this.image = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
  }
}
