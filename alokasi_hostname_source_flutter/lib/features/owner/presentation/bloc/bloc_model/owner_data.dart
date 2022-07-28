class OwnerData {
  int id;
  String owner;
  String email;
  String phone;
  String notes;
  bool deleted;
  String created;

  List<Object> get props => [
        id,
        owner,
        email,
        phone,
        notes,
        deleted,
        created,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.owner = null;
    this.email = null;
    this.phone = null;
    this.notes = null;
    this.deleted = null;
    this.created = null;
  }
}
