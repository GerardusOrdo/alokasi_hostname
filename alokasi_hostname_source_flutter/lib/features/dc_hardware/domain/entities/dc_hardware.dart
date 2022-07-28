import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcHardware extends MasterData {
  @override
  final int id;
  final int idOwner;
  final String owner;
  final int idDcRack;
  final String rackName;
  final int idBrand;
  final String brand;
  final int idHwModel;
  final String hwModel;
  final int frontbackFacing;
  final int idHwType;
  final String hwType;
  final int idMountedForm;
  final String mountedForm;
  final int hwConnectType;
  final bool isEnclosure;
  final int enclosureColumn;
  final int enclosureRow;
  final bool isBlade;
  final int idParent;
  final int xInEnclosure;
  final int yInEnclosure;
  final String hwName;
  final String sn;
  final int uHeight;
  final int uPosition;
  final int xPositionInRack;
  final int yPositionInRack;
  final int cpuCore;
  final int memoryGb;
  final int diskGb;
  final double watt;
  final double ampere;
  final int width;
  final int height;
  final bool isReserved;
  final bool requirePosition;
  final String image;
  final String notes;
  final bool deleted;
  final String create;
  DcHardware({
    this.id,
    this.idOwner,
    this.owner,
    this.idDcRack,
    this.rackName,
    this.idBrand,
    this.brand,
    this.idHwModel,
    this.hwModel,
    this.frontbackFacing,
    this.idHwType,
    this.hwType,
    this.idMountedForm,
    this.mountedForm,
    this.hwConnectType,
    this.isEnclosure,
    this.enclosureColumn,
    this.enclosureRow,
    this.isBlade,
    this.idParent,
    this.xInEnclosure,
    this.yInEnclosure,
    @required this.hwName,
    this.sn,
    this.uHeight,
    this.uPosition,
    this.xPositionInRack,
    this.yPositionInRack,
    this.cpuCore,
    this.memoryGb,
    this.diskGb,
    this.watt,
    this.ampere,
    this.width,
    this.height,
    this.isReserved,
    this.requirePosition,
    this.image,
    this.notes,
    this.deleted,
    this.create,
  });

  @override
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
}
