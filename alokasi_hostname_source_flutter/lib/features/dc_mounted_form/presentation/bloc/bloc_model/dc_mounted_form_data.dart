class DcMountedFormData {
  int id;
  String mountedForm;

  List<Object> get props => [
        id,
        mountedForm,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.mountedForm = null;
  }
}
