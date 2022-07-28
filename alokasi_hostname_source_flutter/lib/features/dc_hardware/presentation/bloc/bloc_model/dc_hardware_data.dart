class DcHardwareData {
  int id;
  int idOwner;
  String owner;
  int idDcRack;
  String rackName;
  int idBrand;
  String brand;
  int idHwModel;
  String hwModel;
  int frontbackFacing;
  int idHwType;
  String hwType;
  int idMountedForm;
  String mountedForm;
  int hwConnectType;
  bool isEnclosure;
  int enclosureColumn;
  int enclosureRow;
  bool isBlade;
  int idParent;
  int xInEnclosure;
  int yInEnclosure;
  String hwName;
  String sn;
  int uHeight;
  int uPosition;
  int xPositionInRack;
  int yPositionInRack;
  int cpuCore;
  int memoryGb;
  int diskGb;
  double watt;
  double ampere;
  int width;
  int height;
  bool isReserved;
  bool requirePosition;
  String image;
  String notes;
  bool deleted;
  String create;

  List<Object> get props => [
        id,
        idOwner,
        owner,
        idDcRack,
        rackName,
        idBrand,
        brand,
        idHwModel,
        hwModel,
        frontbackFacing,
        idHwType,
        hwType,
        idMountedForm,
        mountedForm,
        hwConnectType,
        isEnclosure,
        enclosureColumn,
        enclosureRow,
        isBlade,
        idParent,
        xInEnclosure,
        yInEnclosure,
        hwName,
        sn,
        uHeight,
        uPosition,
        xPositionInRack,
        yPositionInRack,
        cpuCore,
        memoryGb,
        diskGb,
        watt,
        ampere,
        width,
        height,
        isReserved,
        requirePosition,
        image,
        notes,
        deleted,
        create,
      ];

  void setNullToAllFields() {
    this.id = null;
    this.idOwner = null;
    this.owner = null;
    this.idDcRack = null;
    this.rackName = null;
    this.idBrand = null;
    this.brand = null;
    this.idHwModel = null;
    this.hwModel = null;
    this.frontbackFacing = null;
    this.idHwType = null;
    this.hwType = null;
    this.idMountedForm = null;
    this.mountedForm = null;
    this.hwConnectType = null;
    this.isEnclosure = null;
    this.enclosureColumn = null;
    this.enclosureRow = null;
    this.isBlade = null;
    this.idParent = null;
    this.xInEnclosure = null;
    this.yInEnclosure = null;
    this.hwName = null;
    this.sn = null;
    this.uHeight = null;
    this.uPosition = null;
    this.xPositionInRack = null;
    this.yPositionInRack = null;
    this.cpuCore = null;
    this.memoryGb = null;
    this.diskGb = null;
    this.watt = null;
    this.ampere = null;
    this.width = null;
    this.height = null;
    this.isReserved = null;
    this.requirePosition = null;
    this.image = null;
    this.notes = null;
    this.deleted = null;
    this.create = null;
  }
}
