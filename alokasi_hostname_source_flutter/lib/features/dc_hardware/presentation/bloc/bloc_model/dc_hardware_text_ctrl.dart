import 'package:flutter/material.dart';

class DcHardwareTextCtrl {
  TextEditingController id;
  TextEditingController idOwner;
  TextEditingController owner;
  TextEditingController idDcRack;
  TextEditingController rackName;
  TextEditingController idBrand;
  TextEditingController brand;
  TextEditingController idHwModel;
  TextEditingController hwModel;
  TextEditingController frontbackFacing;
  TextEditingController idHwType;
  TextEditingController hwType;
  TextEditingController idMountedForm;
  TextEditingController mountedForm;
  TextEditingController hwConnectType;
  TextEditingController isEnclosure;
  TextEditingController enclosureColumn;
  TextEditingController enclosureRow;
  TextEditingController isBlade;
  TextEditingController idParent;
  TextEditingController xInEnclosure;
  TextEditingController yInEnclosure;
  TextEditingController hwName;
  TextEditingController sn;
  TextEditingController uHeight;
  TextEditingController uPosition;
  TextEditingController xPositionInRack;
  TextEditingController yPositionInRack;
  TextEditingController cpuCore;
  TextEditingController memoryGb;
  TextEditingController diskGb;
  TextEditingController watt;
  TextEditingController ampere;
  TextEditingController width;
  TextEditingController height;
  TextEditingController isReserved;
  TextEditingController requirePosition;
  TextEditingController image;
  TextEditingController notes;
  TextEditingController deleted;
  TextEditingController create;
  DcHardwareTextCtrl({
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
    this.hwName,
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
  List<TextEditingController> get props => [
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

  void clearAllTextCtrl() {
    this.id.clear();
    this.idOwner.clear();
    this.owner.clear();
    this.idDcRack.clear();
    this.rackName.clear();
    this.idBrand.clear();
    this.brand.clear();
    this.idHwModel.clear();
    this.hwModel.clear();
    this.frontbackFacing.clear();
    this.idHwType.clear();
    this.hwType.clear();
    this.idMountedForm.clear();
    this.mountedForm.clear();
    this.hwConnectType.clear();
    this.isEnclosure.clear();
    this.enclosureColumn.clear();
    this.enclosureRow.clear();
    this.isBlade.clear();
    this.idParent.clear();
    this.xInEnclosure.clear();
    this.yInEnclosure.clear();
    this.hwName.clear();
    this.sn.clear();
    this.uHeight.clear();
    this.uPosition.clear();
    this.xPositionInRack.clear();
    this.yPositionInRack.clear();
    this.cpuCore.clear();
    this.memoryGb.clear();
    this.diskGb.clear();
    this.watt.clear();
    this.ampere.clear();
    this.width.clear();
    this.height.clear();
    this.isReserved.clear();
    this.requirePosition.clear();
    this.image.clear();
    this.notes.clear();
    this.deleted.clear();
    this.create.clear();
  }
}
