class DcBrandData {
  int id;
  String brand;
  String image;
  String notes;
  bool deleted;
  String created;

  List<Object> get props => [
        id,
        brand,
        image,
        notes,
        deleted,
        created,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.brand = null;
    this.image = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
  }
}
