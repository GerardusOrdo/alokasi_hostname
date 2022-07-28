import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_brand/domain/entities/dc_brand_plus_filter.dart';
import '../../../dc_brand/domain/entities/dc_brand_table.dart';
import '../../../dc_brand/domain/usecases/select_dc_brand_table.dart';
import '../../../dc_brand/presentation/bloc/dc_brand_ploc.dart';
import '../../../dc_hw_model/domain/entities/dc_hw_model_plus_filter.dart';
import '../../../dc_hw_model/domain/entities/dc_hw_model_table.dart';
import '../../../dc_hw_model/domain/usecases/select_dc_hw_model_table.dart';
import '../../../dc_hw_model/presentation/bloc/dc_hw_model_ploc.dart';
import '../../../dc_hw_type/domain/entities/dc_hw_type_plus_filter.dart';
import '../../../dc_hw_type/domain/entities/dc_hw_type_table.dart';
import '../../../dc_hw_type/domain/usecases/select_dc_hw_type_table.dart';
import '../../../dc_hw_type/presentation/bloc/dc_hw_type_ploc.dart';
import '../../../dc_mounted_form/domain/entities/dc_mounted_form_plus_filter.dart';
import '../../../dc_mounted_form/domain/entities/dc_mounted_form_table.dart';
import '../../../dc_mounted_form/domain/usecases/select_dc_mounted_form_table.dart';
import '../../../dc_mounted_form/presentation/bloc/dc_mounted_form_ploc.dart';
import '../../../dc_owner/domain/entities/dc_owner_plus_filter.dart';
import '../../../dc_owner/domain/entities/dc_owner_table.dart';
import '../../../dc_owner/domain/usecases/select_dc_owner_table.dart';
import '../../../dc_owner/presentation/bloc/dc_owner_ploc.dart';
import '../../../dc_rack/domain/entities/dc_rack_plus_filter.dart';
import '../../../dc_rack/domain/entities/dc_rack_table.dart';
import '../../../dc_rack/domain/usecases/select_dc_rack_table.dart';
import '../../../dc_rack/presentation/bloc/dc_rack_ploc.dart';
import '../../domain/entities/dc_hardware.dart';
import '../../domain/entities/dc_hardware_plus_filter.dart';
import '../../domain/entities/dc_hardware_table.dart';
import '../../domain/usecases/clone_dc_hardware_table.dart';
import '../../domain/usecases/delete_dc_hardware_table.dart';
import '../../domain/usecases/insert_dc_hardware_table.dart';
import '../../domain/usecases/select_dc_hardware_table.dart';
import '../../domain/usecases/set_delete_dc_hardware_table.dart';
import '../../domain/usecases/update_dc_hardware_table.dart';
import 'bloc_model/dc_hardware_data.dart';
import 'bloc_model/dc_hardware_text_ctrl.dart';

class DcHardwarePloc extends MasterPagePloc {
  // ! Data Related variable
  DcHardwareTable dcHardwareTable;
  DcHardware dcHardware;
  DcHardwarePlusFilter dcHardwarePlusFilterField;
  List<DcHardware> selectedDatasInTable = [];
  List<DropdownMenuItem<dynamic>> dropdownFrontBackFacing = [
    DropdownMenuItem(
      child: Text('Front'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('Back'),
      value: 1,
    ),
  ];
  List<DropdownMenuItem<dynamic>> dropdownHwConnectType = [
    DropdownMenuItem(
      child: Text('Through PDU'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('To Legrand'),
      value: 1,
    ),
  ];
  List<DropdownMenuItem<dynamic>> dropdownHwType = [
    DropdownMenuItem(
      child: Text('Rack Mounted'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('Enclosure'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Blade'),
      value: 2,
    ),
  ];
  List<String> hwType = ['Rack Mounted', 'Enclosure', 'Blade'];
  int hwTypeSelected = 0;
  int hwTypeFilterSelected = 0;
  DcHardware inputEnlosure;
  DcHardware filterEnlosure;
  TextEditingController inputEnclosureTextController = TextEditingController();
  TextEditingController filterEnclosureTextController = TextEditingController();

  // Data Dependencies Variable
  DcOwnerTable dcOwnerTable;
  DcOwnerPlusFilter dcOwnerPlusFilter;
  DcRackTable dcRackTable;
  DcRackPlusFilter dcRackPlusFilter;
  DcBrandTable dcBrandTable;
  DcBrandPlusFilter dcBrandPlusFilter;
  DcHwModelTable dcHwModelTable;
  DcHwModelPlusFilter dcHwModelPlusFilter;
  DcHwTypeTable dcHwTypeTable;
  DcHwTypePlusFilter dcHwTypePlusFilter;
  DcMountedFormTable dcMountedFormTable;
  DcMountedFormPlusFilter dcMountedFormPlusFilter;
  // Data Basic Variable
  DcHardwareTable dcSnEnclosureTable;
  DcHardwarePlusFilter dcSnEnclosurePlusFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Hardware';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcHardwareData filterDcHardware = DcHardwareData();
  DcHardwareTextCtrl filterTextCtrl = DcHardwareTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    idDcRack: TextEditingController(),
    rackName: TextEditingController(),
    idBrand: TextEditingController(),
    brand: TextEditingController(),
    idHwModel: TextEditingController(),
    hwModel: TextEditingController(),
    frontbackFacing: TextEditingController(),
    idHwType: TextEditingController(),
    hwType: TextEditingController(),
    idMountedForm: TextEditingController(),
    mountedForm: TextEditingController(),
    hwConnectType: TextEditingController(),
    isEnclosure: TextEditingController(),
    enclosureColumn: TextEditingController(),
    enclosureRow: TextEditingController(),
    isBlade: TextEditingController(),
    idParent: TextEditingController(),
    xInEnclosure: TextEditingController(),
    yInEnclosure: TextEditingController(),
    hwName: TextEditingController(),
    sn: TextEditingController(),
    uHeight: TextEditingController(),
    uPosition: TextEditingController(),
    xPositionInRack: TextEditingController(),
    yPositionInRack: TextEditingController(),
    cpuCore: TextEditingController(),
    memoryGb: TextEditingController(),
    diskGb: TextEditingController(),
    watt: TextEditingController(),
    ampere: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    isReserved: TextEditingController(),
    requirePosition: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    create: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcHardwareData inputDcHardware = DcHardwareData();
  DcHardwareTextCtrl inputTextCtrl = DcHardwareTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    idDcRack: TextEditingController(),
    rackName: TextEditingController(),
    idBrand: TextEditingController(),
    brand: TextEditingController(),
    idHwModel: TextEditingController(),
    hwModel: TextEditingController(),
    frontbackFacing: TextEditingController(),
    idHwType: TextEditingController(),
    hwType: TextEditingController(),
    idMountedForm: TextEditingController(),
    mountedForm: TextEditingController(),
    hwConnectType: TextEditingController(),
    isEnclosure: TextEditingController(),
    enclosureColumn: TextEditingController(),
    enclosureRow: TextEditingController(),
    isBlade: TextEditingController(),
    idParent: TextEditingController(),
    xInEnclosure: TextEditingController(),
    yInEnclosure: TextEditingController(),
    hwName: TextEditingController(),
    sn: TextEditingController(),
    uHeight: TextEditingController(),
    uPosition: TextEditingController(),
    xPositionInRack: TextEditingController(),
    yPositionInRack: TextEditingController(),
    cpuCore: TextEditingController(),
    memoryGb: TextEditingController(),
    diskGb: TextEditingController(),
    watt: TextEditingController(),
    ampere: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    isReserved: TextEditingController(),
    requirePosition: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    create: TextEditingController(),
  );
  DcOwnerPloc dcOwnerPloc = Get.find<DcOwnerPloc>();
  DcRackPloc dcRackPloc = Get.find<DcRackPloc>();
  DcBrandPloc dcBrandPloc = Get.find<DcBrandPloc>();
  DcHwModelPloc dcHwModelPloc = Get.find<DcHwModelPloc>();
  DcHwTypePloc dcHwTypePloc = Get.find<DcHwTypePloc>();
  DcMountedFormPloc dcMountedFormPloc = Get.find<DcMountedFormPloc>();

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcHardware.setNullToAllFields();
    inputEnlosure = null;
    hwTypeSelected = 0;
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
    inputEnclosureTextController.clear();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcHardware.setNullToAllFields();
    filterEnlosure = null;
  }

  @override
  void resetFilterController() {
    super.resetFilterController();
    filterTextCtrl.clearAllTextCtrl();
    filterEnclosureTextController.clear();
  }

  void resetSelectedData() {
    selectedDataCount = 0;
    selectedDatasInTable = [];
  }

  @override
  Future selectAndFilterData({
    EnumLogicalOperator dataFilterByLogicalOperator = EnumLogicalOperator.and,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcHardwarePlusFilterField = DcHardwarePlusFilter(
      id: filterDcHardware.id,
      idOwner: filterDcHardware.idOwner,
      owner: getNullIfStringEmpty(filterDcHardware.owner),
      idDcRack: filterDcHardware.idDcRack,
      rackName: getNullIfStringEmpty(filterDcHardware.rackName),
      idBrand: filterDcHardware.idBrand,
      brand: getNullIfStringEmpty(filterDcHardware.brand),
      idHwModel: filterDcHardware.idHwModel,
      hwModel: getNullIfStringEmpty(filterDcHardware.hwModel),
      frontbackFacing: filterDcHardware.frontbackFacing,
      idHwType: filterDcHardware.idHwType,
      hwType: getNullIfStringEmpty(filterDcHardware.hwType),
      idMountedForm: filterDcHardware.idMountedForm,
      mountedForm: getNullIfStringEmpty(filterDcHardware.mountedForm),
      hwConnectType: filterDcHardware.hwConnectType,
      isEnclosure: hwTypeFilterSelected == 1
          ? true
          : null, //filterDcHardware.isEnclosure,
      enclosureColumn: filterDcHardware.enclosureColumn,
      enclosureRow: filterDcHardware.enclosureRow,
      isBlade:
          hwTypeFilterSelected == 2 ? true : null, //filterDcHardware.isBlade,
      idParent: filterDcHardware.idParent,
      xInEnclosure: filterDcHardware.xInEnclosure,
      yInEnclosure: filterDcHardware.yInEnclosure,
      hwName: getNullIfStringEmpty(filterDcHardware.hwName),
      sn: getNullIfStringEmpty(filterDcHardware.sn),
      uHeight: filterDcHardware.uHeight,
      uPosition: filterDcHardware.uPosition,
      xPositionInRack: filterDcHardware.xPositionInRack,
      yPositionInRack: filterDcHardware.yPositionInRack,
      cpuCore: filterDcHardware.cpuCore,
      memoryGb: filterDcHardware.memoryGb,
      diskGb: filterDcHardware.diskGb,
      watt: filterDcHardware.watt,
      ampere: filterDcHardware.ampere,
      width: filterDcHardware.width,
      height: filterDcHardware.height,
      isReserved: filterDcHardware.isReserved,
      requirePosition: filterDcHardware.requirePosition,
      image: getNullIfStringEmpty(filterDcHardware.image),
      notes: getNullIfStringEmpty(filterDcHardware.notes),
      deleted: filterDcHardware.deleted,
      create: getNullIfStringEmpty(filterDcHardware.create),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcHardware =
        await Get.find<SelectDcHardwareTable>()(dcHardwarePlusFilterField);
    failureOrDcHardware.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcHardwareTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Owner
  Future selectAndFilterDataOwner({
    @required String searchItem,
    bool isNeedToRefreshDcHardware = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcOwnerPlusFilter = DcOwnerPlusFilter(
      owner: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcOwner =
        await Get.find<SelectDcOwnerTable>()(dcOwnerPlusFilter);
    failureOrDcOwner.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcOwnerTable = data;
    });
    if (isNeedToRefreshDcHardware) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Rack
  Future selectAndFilterDataRack({
    @required String searchItem,
    bool isNeedToRefreshDcHardware = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcRackPlusFilter = DcRackPlusFilter(
      rackName: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcRack =
        await Get.find<SelectDcRackTable>()(dcRackPlusFilter);
    failureOrDcRack.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcRackTable = data;
    });
    if (isNeedToRefreshDcHardware) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Brand
  Future selectAndFilterDataBrand({
    @required String searchItem,
    bool isNeedToRefreshDcHardware = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcBrandPlusFilter = DcBrandPlusFilter(
      brand: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcBrand =
        await Get.find<SelectDcBrandTable>()(dcBrandPlusFilter);
    failureOrDcBrand.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcBrandTable = data;
    });
    if (isNeedToRefreshDcHardware) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Hw Model
  Future selectAndFilterDataHwModel({
    @required String searchItem,
    bool isNeedToRefreshDcHardware = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcHwModelPlusFilter = DcHwModelPlusFilter(
      hwModel: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcHwModel =
        await Get.find<SelectDcHwModelTable>()(dcHwModelPlusFilter);
    failureOrDcHwModel.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcHwModelTable = data;
    });
    if (isNeedToRefreshDcHardware) {
      await selectAndFilterData();
    }
  }

  // Dependencies - HwType
  Future selectAndFilterDataHwType({
    @required String searchItem,
    bool isNeedToRefreshDcHardware = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcHwTypePlusFilter = DcHwTypePlusFilter(
      hwType: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcHwType =
        await Get.find<SelectDcHwTypeTable>()(dcHwTypePlusFilter);
    failureOrDcHwType.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcHwTypeTable = data;
    });
    if (isNeedToRefreshDcHardware) {
      await selectAndFilterData();
    }
  }

  // Dependencies - MountedForm
  Future selectAndFilterDataMountedForm({
    @required String searchItem,
    bool isNeedToRefreshDcHardware = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcMountedFormPlusFilter = DcMountedFormPlusFilter(
      mountedForm: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcMountedForm =
        await Get.find<SelectDcMountedFormTable>()(dcMountedFormPlusFilter);
    failureOrDcMountedForm.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcMountedFormTable = data;
    });
    if (isNeedToRefreshDcHardware) {
      await selectAndFilterData();
    }
  }

  // Basic - SN Enclosure (for Hw Type = Blade)
  Future selectAndFilterDataSnEnclosure({
    @required String searchItem,
    bool isNeedToRefreshDcHardware = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcSnEnclosurePlusFilter = DcHardwarePlusFilter(
      sn: getNullIfStringEmpty(searchItem),
      isEnclosure: true,
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcHardwareEnclosure =
        await Get.find<SelectDcHardwareTable>()(dcSnEnclosurePlusFilter);
    failureOrDcHardwareEnclosure.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcSnEnclosureTable = data;
    });
    if (isNeedToRefreshDcHardware) {
      await selectAndFilterData();
    }
  }

  @override
  Future insertData() async {
    dcHardware = DcHardware(
      idOwner: inputDcHardware.idOwner, //!dependencies
      idDcRack: inputDcHardware.idDcRack, //!dependencies
      idBrand: inputDcHardware.idBrand, //!dependencies
      idHwModel: inputDcHardware.idHwModel, //!dependencies
      frontbackFacing: inputDcHardware.frontbackFacing, //?additional
      idHwType: inputDcHardware.idHwType, //!dependencies
      idMountedForm: inputDcHardware.idMountedForm, //!dependencies
      hwConnectType: inputDcHardware.hwConnectType, //?additional
      // enclosure
      isEnclosure: inputDcHardware.isEnclosure, //*basic
      enclosureColumn: inputDcHardware.enclosureColumn, //*basic
      enclosureRow: inputDcHardware.enclosureRow, //*basic
      // blade
      isBlade: inputDcHardware.isBlade, //*basic
      idParent: inputDcHardware.idParent, //*basic
      xInEnclosure: inputDcHardware.xInEnclosure, //*basic
      yInEnclosure: inputDcHardware.yInEnclosure, //*basic
      //standard hardware
      hwName: inputDcHardware.hwName, //*basic
      sn: inputDcHardware.sn, //*basic
      uHeight: inputDcHardware.uHeight, //*basic
      uPosition: inputDcHardware.uPosition, //*basic
      xPositionInRack: inputDcHardware.xPositionInRack, //?additional
      yPositionInRack: inputDcHardware.yPositionInRack, //?additional
      cpuCore: inputDcHardware.cpuCore, //?additional
      memoryGb: inputDcHardware.memoryGb, //?additional
      diskGb: inputDcHardware.diskGb, //?additional
      watt: inputDcHardware.watt, //?additional
      ampere: inputDcHardware.ampere, //?additional
      width: inputDcHardware.width, //?additional
      height: inputDcHardware.height, //?additional
      isReserved: inputDcHardware.isReserved, //*basic
      // requirePosition: inputDcHardware.requirePosition,
      // image: inputDcHardware.image,
      // notes: inputDcHardware.notes,
      // deleted: inputDcHardware.deleted,
      // create: inputDcHardware.create,
    );
    final fetchedData = await Get.find<InsertDcHardwareTable>()(dcHardware);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHardwareTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - Owner
  void addOwnerDependencies() async {
    dcOwnerPloc.inputDcOwner.owner = inputTextCtrl.owner.text;
    await dcOwnerPloc.insertData();
    getInputOwnerSuggestionFromAPI(inputTextCtrl.owner.text);
    inputTextCtrl.owner.clear();
    update();
  }

  void inputOwnerTextSelected(Map<String, dynamic> value) {
    inputTextCtrl.owner.text = value['owner'];
    inputDcHardware.owner = value['owner'];
    inputDcHardware.idOwner = value['id'];
    getInputOwnerSuggestionFromAPI(value['owner']);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputOwnerSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataOwner(
            searchItem: value, isNeedToRefreshDcHardware: false, fetchLimit: 7)
        .whenComplete(
      () => dcOwnerTable.dcOwner.forEach((element) {
        match.add({
          'id': element.id,
          'owner': element.owner,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // Dependencies - Rack
  void addRackDependencies() async {
    dcRackPloc.inputDcRack.rackName = inputTextCtrl.rackName.text;
    await dcRackPloc.insertData();
    getInputRackSuggestionFromAPI(inputTextCtrl.rackName.text);
    inputTextCtrl.rackName.clear();
    update();
  }

  void inputRackTextSelected(Map<String, dynamic> value) {
    inputTextCtrl.rackName.text = value['rack_name'];
    inputDcHardware.rackName = value['rack_name'];
    inputDcHardware.idDcRack = value['id'];
    getInputRackSuggestionFromAPI(value['rack_name']);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputRackSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataRack(
            searchItem: value, isNeedToRefreshDcHardware: false, fetchLimit: 7)
        .whenComplete(
      () => dcRackTable.dcRack.forEach((element) {
        match.add({
          'id': element.id,
          'rack_name': element.rackName,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // Dependencies - Brand
  void addBrandDependencies() async {
    dcBrandPloc.inputDcBrand.brand = inputTextCtrl.brand.text;
    await dcBrandPloc.insertData();
    getInputBrandSuggestionFromAPI(inputTextCtrl.brand.text);
    inputTextCtrl.brand.clear();
    update();
  }

  void inputBrandTextSelected(Map<String, dynamic> value) {
    inputTextCtrl.brand.text = value['brand'];
    inputDcHardware.brand = value['brand'];
    inputDcHardware.idBrand = value['id'];
    getInputBrandSuggestionFromAPI(value['brand']);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputBrandSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataBrand(
            searchItem: value, isNeedToRefreshDcHardware: false, fetchLimit: 7)
        .whenComplete(
      () => dcBrandTable.dcBrand.forEach((element) {
        match.add({
          'id': element.id,
          'brand': element.brand,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // Dependencies - HwModel
  void addHwModelDependencies() async {
    dcHwModelPloc.inputDcHwModel.hwModel = inputTextCtrl.hwModel.text;
    await dcHwModelPloc.insertData();
    getInputHwModelSuggestionFromAPI(inputTextCtrl.hwModel.text);
    inputTextCtrl.hwModel.clear();
    update();
  }

  void inputHwModelTextSelected(Map<String, dynamic> value) {
    inputTextCtrl.hwModel.text = value['hw_model'];
    inputDcHardware.hwModel = value['hw_model'];
    inputDcHardware.idHwModel = value['id'];
    getInputHwModelSuggestionFromAPI(value['hw_model']);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputHwModelSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataHwModel(
            searchItem: value, isNeedToRefreshDcHardware: false, fetchLimit: 7)
        .whenComplete(
      () => dcHwModelTable.dcHwModel.forEach((element) {
        match.add({
          'id': element.id,
          'hw_model': element.hwModel,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // Basic - Enclosure ( Parent of Blade )
  void inputSnEnclosureTextSelected(Map<String, dynamic> value) {
    inputEnclosureTextController.text = value['sn'];
    inputDcHardware.idParent = value['id'];
    getInputSnEnclosureSuggestionFromAPI(value['sn']);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputSnEnclosureSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataSnEnclosure(
            searchItem: value, isNeedToRefreshDcHardware: false, fetchLimit: 7)
        .whenComplete(
      () => dcSnEnclosureTable.dcHardware.forEach((element) {
        match.add({
          'id': element.id,
          'id_owner': element.idOwner,
          'owner': element.owner,
          'id_dc_rack': element.idDcRack,
          'rack_name': element.rackName,
          'id_brand': element.idBrand,
          'brand': element.brand,
          'id_hw_model': element.idHwModel,
          'hw_model': element.hwModel,
          'frontback_facing': element.frontbackFacing,
          'id_hw_type': element.idHwType,
          'hw_type': element.hwType,
          'id_mounted_form': element.idMountedForm,
          'mounted_form': element.mountedForm,
          'hw_connect_type': element.hwConnectType,
          'is_enclosure': element.isEnclosure,
          'enclosure_column': element.enclosureColumn,
          'enclosure_row': element.enclosureRow,
          'is_blade': element.isBlade,
          'id_parent': element.idParent,
          'x_in_enclosure': element.xInEnclosure,
          'y_in_enclosure': element.yInEnclosure,
          'hw_name': element.hwName,
          'sn': element.sn,
          'u_height': element.uHeight,
          'u_position': element.uPosition,
          'u_to_u': element.uPosition + element.uHeight - 1,
          'x_position_in_rack': element.xPositionInRack,
          'y_position_in_rack': element.yPositionInRack,
          'cpu_core': element.cpuCore,
          'memory_gb': element.memoryGb,
          'disk_gb': element.diskGb,
          'watt': element.watt,
          'ampere': element.ampere,
          'width': element.width,
          'height': element.height,
          'is_reserved': element.isReserved,
          'require_position': element.requirePosition,
          'image': element.image,
          'notes': element.notes,
          'deleted': element.deleted,
          'create': element.create,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // Dependencies - HwType
  void addHwTypeDependencies() async {
    dcHwTypePloc.inputDcHwType.hwType = inputTextCtrl.hwType.text;
    await dcHwTypePloc.insertData();
    getInputHwTypeSuggestionFromAPI(inputTextCtrl.hwType.text);
    inputTextCtrl.hwType.clear();
    update();
  }

  void inputHwTypeTextSelected(Map<String, dynamic> value) {
    inputTextCtrl.hwType.text = value['hw_type'];
    inputDcHardware.hwType = value['hw_type'];
    inputDcHardware.idHwType = value['id'];
    getInputHwTypeSuggestionFromAPI(value['hw_type']);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputHwTypeSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataHwType(
            searchItem: value, isNeedToRefreshDcHardware: false, fetchLimit: 7)
        .whenComplete(
      () => dcHwTypeTable.dcHwType.forEach((element) {
        match.add({
          'id': element.id,
          'hw_type': element.hwType,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // Dependencies - MountedForm
  void addMountedFormDependencies() async {
    dcMountedFormPloc.inputDcMountedForm.mountedForm =
        inputTextCtrl.mountedForm.text;
    await dcMountedFormPloc.insertData();
    getInputMountedFormSuggestionFromAPI(inputTextCtrl.mountedForm.text);
    inputTextCtrl.mountedForm.clear();
    update();
  }

  void inputMountedFormTextSelected(Map<String, dynamic> value) {
    String mountedFormField = 'mounted_form';
    inputTextCtrl.mountedForm.text = value[mountedFormField];
    inputDcHardware.mountedForm = value[mountedFormField];
    inputDcHardware.idMountedForm = value['id'];
    getInputMountedFormSuggestionFromAPI(value[mountedFormField]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputMountedFormSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataMountedForm(
            searchItem: value, isNeedToRefreshDcHardware: false, fetchLimit: 7)
        .whenComplete(
      () => dcMountedFormTable.dcMountedForm.forEach((element) {
        match.add({
          'id': element.id,
          'mounted_form': element.mountedForm,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  @override
  Future updateData() async {
    dcHardware = DcHardware(
      id: selectedDatasInTable[0].id,
      idOwner: inputDcHardware.idOwner, //!dependencies
      idDcRack: inputDcHardware.idDcRack, //!dependencies
      idBrand: inputDcHardware.idBrand, //!dependencies
      idHwModel: inputDcHardware.idHwModel, //!dependencies
      frontbackFacing: inputDcHardware.frontbackFacing, //?additional
      idHwType: inputDcHardware.idHwType, //!dependencies
      idMountedForm: inputDcHardware.idMountedForm, //!dependencies
      hwConnectType: inputDcHardware.hwConnectType, //?additional
      // enclosure
      isEnclosure: inputDcHardware.isEnclosure, //*basic
      enclosureColumn: inputDcHardware.enclosureColumn, //*basic
      enclosureRow: inputDcHardware.enclosureRow, //*basic
      // blade
      isBlade: inputDcHardware.isBlade, //*basic
      idParent: inputDcHardware.idParent, //*basic
      xInEnclosure: inputDcHardware.xInEnclosure, //*basic
      yInEnclosure: inputDcHardware.yInEnclosure, //*basic
      //standard hardware
      hwName: inputDcHardware.hwName, //*basic
      sn: inputDcHardware.sn, //*basic
      uHeight: inputDcHardware.uHeight, //*basic
      uPosition: inputDcHardware.uPosition, //*basic
      xPositionInRack: inputDcHardware.xPositionInRack, //?additional
      yPositionInRack: inputDcHardware.yPositionInRack, //?additional
      cpuCore: inputDcHardware.cpuCore, //?additional
      memoryGb: inputDcHardware.memoryGb, //?additional
      diskGb: inputDcHardware.diskGb, //?additional
      watt: inputDcHardware.watt, //?additional
      ampere: inputDcHardware.ampere, //?additional
      width: inputDcHardware.width, //?additional
      height: inputDcHardware.height, //?additional
      isReserved: inputDcHardware.isReserved, //*basic
      // requirePosition: inputDcHardware.requirePosition,
      // image: inputDcHardware.image,
      // notes: inputDcHardware.notes,
      // deleted: inputDcHardware.deleted,
      // create: inputDcHardware.create,
    );
    final fetchedData = await Get.find<UpdateDcHardwareTable>()(dcHardware);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHardwareTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcHardwareTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHardwareTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcHardwareTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHardwareTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcHardwareTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHardwareTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcHardwares = dcHardwareTable;
    if (index >= dcHardwares.dcHardware.length) return null;
    final DcHardware dcHardware = dcHardwares.dcHardware[index];
    return DataRow.byIndex(
      index: index,
      selected: dcHardware.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcHardware.id.toString())),
        DataCell(Text(dcHardware.owner ?? '')),
        DataCell(Text(dcHardware.rackName ?? '')),
        DataCell(Text(dcHardware.brand ?? '')),
        DataCell(Text(dcHardware.hwModel ?? '')),
        DataCell(Text(dcHardware.hwType ?? '')),
        DataCell(Text(dcHardware.mountedForm ?? '')),
        DataCell(Text(dcHardware.hwName ?? '')),
        DataCell(Text(dcHardware.sn ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcHardware.owner = s;
      filterDcHardware.rackName = s;
      filterDcHardware.brand = s;
      filterDcHardware.hwModel = s;
      filterDcHardware.hwType = s;
      filterDcHardware.mountedForm = s;
      filterDcHardware.hwName = s;
      filterDcHardware.sn = s;
      if (!(s == "")) {
        selectAndFilterData(
            dataFilterByLogicalOperator: EnumLogicalOperator.or);
      } else
        selectAndFilterData(
            dataFilterByLogicalOperator: EnumLogicalOperator.and);
      update();
    });
  }

  // ! ============== Set Appbar to Search Mode and vice versa ==============
  @override
  void setSearchMode(bool value) async {
    super.setSearchMode(value);
  }

  // ! ============== Filter Function ==============
  void onFilterHwNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.hwName,
        typedValue: typedValue,
        filterValue: filterDcHardware.hwName,
        getFilterSuggesstion: getFilterHwNameSuggestionsFromAPI);
  }

  void onFilterSnSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.sn,
        typedValue: typedValue,
        filterValue: filterDcHardware.sn,
        getFilterSuggesstion: getFilterSnSuggestionsFromAPI);
  }

  void onFilterImageSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.image,
        typedValue: typedValue,
        filterValue: filterDcHardware.image,
        getFilterSuggesstion: getFilterImageSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterDcHardware.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreateSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.create,
        typedValue: typedValue,
        filterValue: filterDcHardware.create,
        getFilterSuggesstion: getFilterCreateSuggestionsFromAPI);
  }

  // Dependencies - Owner
  void onFilterOwnerSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.owner,
        typedValue: typedValue,
        filterValue: filterDcHardware.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  // Dependencies - Rack
  void onFilterRackNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.rackName,
        typedValue: typedValue,
        filterValue: filterDcHardware.rackName,
        getFilterSuggesstion: getFilterRackSuggestionsFromAPI);
  }

  // Dependencies - Brand
  void onFilterBrandSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.brand,
        typedValue: typedValue,
        filterValue: filterDcHardware.brand,
        getFilterSuggesstion: getFilterBrandSuggestionsFromAPI);
  }

  // Dependencies - Hw Model
  void onFilterHwModelSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.hwModel,
        typedValue: typedValue,
        filterValue: filterDcHardware.hwModel,
        getFilterSuggesstion: getFilterHwModelSuggestionsFromAPI);
  }

  // Dependencies - Hw Type
  void onFilterHwTypeSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.hwType,
        typedValue: typedValue,
        filterValue: filterDcHardware.hwType,
        getFilterSuggesstion: getFilterHwTypeSuggestionsFromAPI);
  }

  // Dependencies - Mounted Form
  void onFilterMountedFormSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.mountedForm,
        typedValue: typedValue,
        filterValue: filterDcHardware.mountedForm,
        getFilterSuggesstion: getFilterMountedFormSuggestionsFromAPI);
  }

  // Basic - Enclosure ( Parent of Blade )
  void onFilterSnEnclosureSuggestionSelected(Map<String, dynamic> typedValue) {
    filterEnclosureTextController?.text = typedValue['sn'];
    filterDcHardware.idParent = typedValue['id'];
    getFilterSnEnclosureSuggestionsFromAPI(filterEnclosureTextController.text);
    update();
  }

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcHardware.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHardwareTable.dcHardware.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterHwNameSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHardware.hwName = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHardwareTable.dcHardware.forEach((element) {
        match.add(element.hwName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterSnSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHardware.sn = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHardwareTable.dcHardware.forEach((element) {
        match.add(element.sn);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterImageSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHardware.image = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHardwareTable.dcHardware.forEach((element) {
        match.add(element.image);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHardware.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHardwareTable.dcHardware.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreateSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHardware.create = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHardwareTable.dcHardware.forEach((element) {
        match.add(element.create);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - owner
  Future<List<String>> getFilterOwnerSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcHardware.owner = value;
    List<String> match = [];
    await selectAndFilterDataOwner(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcOwnerTable.dcOwner.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - rack
  Future<List<String>> getFilterRackSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcHardware.rackName = value;
    List<String> match = [];
    await selectAndFilterDataRack(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcRackTable.dcRack.forEach((element) {
        match.add(element.rackName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - brand
  Future<List<String>> getFilterBrandSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcHardware.brand = value;
    List<String> match = [];
    await selectAndFilterDataBrand(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcBrandTable.dcBrand.forEach((element) {
        match.add(element.brand);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - hw model
  Future<List<String>> getFilterHwModelSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcHardware.hwModel = value;
    List<String> match = [];
    await selectAndFilterDataHwModel(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcHwModelTable.dcHwModel.forEach((element) {
        match.add(element.hwModel);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - hw type
  Future<List<String>> getFilterHwTypeSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcHardware.hwType = value;
    List<String> match = [];
    await selectAndFilterDataHwType(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcHwTypeTable.dcHwType.forEach((element) {
        match.add(element.hwType);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - mounted form
  Future<List<String>> getFilterMountedFormSuggestionsFromAPI(
      String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcHardware.hwType = value;
    List<String> match = [];
    await selectAndFilterDataMountedForm(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcMountedFormTable.dcMountedForm.forEach((element) {
        match.add(element.mountedForm);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - mounted form
  Future<List<Map<String, dynamic>>> getFilterSnEnclosureSuggestionsFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataSnEnclosure(searchItem: value, fetchLimit: 7)
        .whenComplete(
      () => dcSnEnclosureTable.dcHardware.forEach((element) {
        match.add({
          'id': element.id,
          'id_owner': element.idOwner,
          'owner': element.owner,
          'id_dc_rack': element.idDcRack,
          'rack_name': element.rackName,
          'id_brand': element.idBrand,
          'brand': element.brand,
          'id_hw_model': element.idHwModel,
          'hw_model': element.hwModel,
          'frontback_facing': element.frontbackFacing,
          'id_hw_type': element.idHwType,
          'hw_type': element.hwType,
          'id_mounted_form': element.idMountedForm,
          'mounted_form': element.mountedForm,
          'hw_connect_type': element.hwConnectType,
          'is_enclosure': element.isEnclosure,
          'enclosure_column': element.enclosureColumn,
          'enclosure_row': element.enclosureRow,
          'is_blade': element.isBlade,
          'id_parent': element.idParent,
          'x_in_enclosure': element.xInEnclosure,
          'y_in_enclosure': element.yInEnclosure,
          'hw_name': element.hwName,
          'sn': element.sn,
          'u_height': element.uHeight,
          'u_position': element.uPosition,
          'u_to_u': element.uPosition + element.uHeight - 1,
          'x_position_in_rack': element.xPositionInRack,
          'y_position_in_rack': element.yPositionInRack,
          'cpu_core': element.cpuCore,
          'memory_gb': element.memoryGb,
          'disk_gb': element.diskGb,
          'watt': element.watt,
          'ampere': element.ampere,
          'width': element.width,
          'height': element.height,
          'is_reserved': element.isReserved,
          'require_position': element.requirePosition,
          'image': element.image,
          'notes': element.notes,
          'deleted': element.deleted,
          'create': element.create,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // ! ============== Fungsi Select checkbox Tabel ==============
  void onSelectedDataChanged({
    @required bool value,
    @required int index,
  }) {
    // final dcOwner = dcOwnerTableToShowOnTable.dcOwner[index];
    final masterData = dcHardwareTable.dcHardware[index];
    if (masterData.selected != value) {
      selectedDataCount += value ? 1 : -1;
      assert(selectedDataCount >= 0);
      masterData.selected = value;
    }
    if (value) {
      selectedDatasInTable.add(masterData);
    } else {
      selectedDatasInTable.remove(masterData);
    }
    update();
  }

  // ! ============== On Page Show ==============

  @override
  void onEditPageShowed(int id) {
    currentInputStep = 0;
    DcHardware val =
        dcHardwareTable.dcHardware.singleWhere((element) => element.id == id);

    // data
    inputDcHardware.id = val.id;
    inputDcHardware.idOwner = val.idOwner;
    inputDcHardware.owner = val.owner;
    inputDcHardware.idDcRack = val.idDcRack;
    inputDcHardware.rackName = val.rackName;
    inputDcHardware.idBrand = val.idBrand;
    inputDcHardware.brand = val.brand;
    inputDcHardware.idHwModel = val.idHwModel;
    inputDcHardware.hwModel = val.hwModel;
    inputDcHardware.frontbackFacing = val.frontbackFacing;
    inputDcHardware.idHwType = val.idHwType;
    inputDcHardware.hwType = val.hwType;
    inputDcHardware.idMountedForm = val.idMountedForm;
    inputDcHardware.mountedForm = val.mountedForm;
    inputDcHardware.hwConnectType = val.hwConnectType;
    inputDcHardware.isEnclosure = val.isEnclosure;
    inputDcHardware.enclosureColumn = val.enclosureColumn;
    inputDcHardware.enclosureRow = val.enclosureRow;
    inputDcHardware.isBlade = val.isBlade;
    inputDcHardware.idParent = val.idParent;
    inputDcHardware.xInEnclosure = val.xInEnclosure;
    inputDcHardware.yInEnclosure = val.yInEnclosure;
    inputDcHardware.hwName = val.hwName;
    inputDcHardware.sn = val.sn;
    inputDcHardware.uHeight = val.uHeight;
    inputDcHardware.uPosition = val.uPosition;
    inputDcHardware.xPositionInRack = val.xPositionInRack;
    inputDcHardware.yPositionInRack = val.yPositionInRack;
    inputDcHardware.cpuCore = val.cpuCore;
    inputDcHardware.memoryGb = val.memoryGb;
    inputDcHardware.diskGb = val.diskGb;
    inputDcHardware.watt = val.watt;
    inputDcHardware.ampere = val.ampere;
    inputDcHardware.width = val.width;
    inputDcHardware.height = val.height;
    inputDcHardware.isReserved = val.isReserved;
    inputDcHardware.requirePosition = val.requirePosition;
    inputDcHardware.image = val.image;
    inputDcHardware.notes = val.notes;
    inputDcHardware.deleted = val.deleted;
    inputDcHardware.create = val.create;

    if (inputDcHardware.isEnclosure == false &&
        inputDcHardware.isBlade == false) {
      hwTypeSelected = 0;
    } else if (inputDcHardware.isEnclosure == true &&
        inputDcHardware.isBlade == false) {
      hwTypeSelected = 1;
    } else if (inputDcHardware.isEnclosure == false &&
        inputDcHardware.isBlade == true) {
      hwTypeSelected = 2;
    } else
      hwTypeSelected = 0;

    // inputDcHardware.isEnclosure = hwTypeSelected == 1;
    // inputDcHardware.enclosureColumn =
    //     hwTypeSelected == 1 ? inputDcHardware.enclosureColumn : null;
    // inputDcHardware.enclosureRow =
    //     hwTypeSelected == 1 ? inputDcHardware.enclosureRow : null;

    // inputDcHardware.isEnclosure = hwTypeSelected == 2;
    // inputEnclosureTextController.text =
    //     hwTypeSelected == 2 ? inputEnclosureTextController.text : null;
    // inputDcHardware.idParent =
    //     hwTypeSelected == 2 ? inputDcHardware.idParent : null;
    // inputDcHardware.xInEnclosure =
    //     hwTypeSelected == 2 ? inputDcHardware.xInEnclosure : null;
    // inputDcHardware.yInEnclosure =
    //     hwTypeSelected == 2 ? inputDcHardware.yInEnclosure : null;

    // text editing Controller
    inputTextCtrl.id.text = inputDcHardware.id.toString();
    inputTextCtrl.idOwner.text = inputDcHardware.idOwner.toString();
    inputTextCtrl.owner.text = inputDcHardware.owner;
    inputTextCtrl.idDcRack.text = inputDcHardware.idDcRack.toString();
    inputTextCtrl.rackName.text = inputDcHardware.rackName;
    inputTextCtrl.idBrand.text = inputDcHardware.idBrand.toString();
    inputTextCtrl.brand.text = inputDcHardware.brand;
    inputTextCtrl.idHwModel.text = inputDcHardware.idHwModel.toString();
    inputTextCtrl.hwModel.text = inputDcHardware.hwModel;
    inputTextCtrl.frontbackFacing.text =
        inputDcHardware.frontbackFacing.toString();
    inputTextCtrl.idHwType.text = inputDcHardware.idHwType.toString();
    inputTextCtrl.hwType.text = inputDcHardware.hwType;
    inputTextCtrl.idMountedForm.text = inputDcHardware.idMountedForm.toString();
    inputTextCtrl.mountedForm.text = inputDcHardware.mountedForm;
    inputTextCtrl.hwConnectType.text = inputDcHardware.hwConnectType.toString();
    inputTextCtrl.isEnclosure.text = inputDcHardware.isEnclosure.toString();
    inputTextCtrl.enclosureColumn.text =
        inputDcHardware.enclosureColumn.toString();
    inputTextCtrl.enclosureRow.text = inputDcHardware.enclosureRow.toString();
    inputTextCtrl.isBlade.text = inputDcHardware.isBlade.toString();
    inputTextCtrl.idParent.text = inputDcHardware.idParent.toString();
    inputTextCtrl.xInEnclosure.text = inputDcHardware.xInEnclosure.toString();
    inputTextCtrl.yInEnclosure.text = inputDcHardware.yInEnclosure.toString();
    inputTextCtrl.hwName.text = inputDcHardware.hwName;
    inputTextCtrl.sn.text = inputDcHardware.sn;
    inputTextCtrl.uHeight.text = inputDcHardware.uHeight.toString();
    inputTextCtrl.uPosition.text = inputDcHardware.uPosition.toString();
    inputTextCtrl.xPositionInRack.text =
        inputDcHardware.xPositionInRack.toString();
    inputTextCtrl.yPositionInRack.text =
        inputDcHardware.yPositionInRack.toString();
    inputTextCtrl.cpuCore.text = inputDcHardware.cpuCore.toString();
    inputTextCtrl.memoryGb.text = inputDcHardware.memoryGb.toString();
    inputTextCtrl.diskGb.text = inputDcHardware.diskGb.toString();
    inputTextCtrl.watt.text = inputDcHardware.watt.toString();
    inputTextCtrl.ampere.text = inputDcHardware.ampere.toString();
    inputTextCtrl.width.text = inputDcHardware.width.toString();
    inputTextCtrl.height.text = inputDcHardware.height.toString();
    inputTextCtrl.isReserved.text = inputDcHardware.isReserved.toString();
    inputTextCtrl.requirePosition.text =
        inputDcHardware.requirePosition.toString();
    inputTextCtrl.image.text = inputDcHardware.image;
    inputTextCtrl.notes.text = inputDcHardware.notes;
    inputTextCtrl.deleted.text = inputDcHardware.deleted.toString();
    inputTextCtrl.create.text = inputDcHardware.create;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    inputDcHardware.isReserved =
        inputDcHardware.isReserved.isNull ? false : inputDcHardware.isReserved;

    inputDcHardware.isEnclosure = hwTypeSelected == 1;
    inputDcHardware.enclosureColumn =
        hwTypeSelected == 1 ? inputDcHardware.enclosureColumn : 0;
    inputDcHardware.enclosureRow =
        hwTypeSelected == 1 ? inputDcHardware.enclosureRow : 0;

    inputDcHardware.isBlade = hwTypeSelected == 2;
    inputEnclosureTextController.text =
        hwTypeSelected == 2 ? inputEnclosureTextController.text : null;
    inputDcHardware.idParent =
        hwTypeSelected == 2 ? inputDcHardware.idParent : null;
    inputDcHardware.xInEnclosure =
        hwTypeSelected == 2 ? inputDcHardware.xInEnclosure : 0;
    inputDcHardware.yInEnclosure =
        hwTypeSelected == 2 ? inputDcHardware.yInEnclosure : 0;
    print('isEnclosure ${inputDcHardware.isEnclosure}');
    print('isBlade ${inputDcHardware.isBlade}');
    return isInputValidated(
            inputDcHardware.hwName.isNull || inputDcHardware.hwName.isEmpty,
            'Hardware (Basic Information)') &&
        isInputValidated(
            inputDcHardware.sn.isNull || inputDcHardware.sn.isEmpty,
            'Serial Number (Basic Information)') &&
        isInputValidated(inputDcHardware.idOwner.isNull,
            'Owner (Dependencies Information)') &&
        isInputValidated(inputDcHardware.idDcRack.isNull,
            'Rack (Dependencies Information)') &&
        isInputValidated(inputDcHardware.idBrand.isNull,
            'Brand (Dependencies Information)') &&
        isInputValidated(inputDcHardware.idHwModel.isNull,
            'Hardware Model (Dependencies Information)') &&
        isInputValidated(inputDcHardware.idHwType.isNull,
            'Hardware Type (Dependencies Information)') &&
        isInputValidated(inputDcHardware.idMountedForm.isNull,
            'Mounted Form (Dependencies Information)') &&
        isInputValidated(
            (hwTypeSelected == 1 && inputDcHardware.enclosureColumn.isNull),
            'Enclosure Column (Basic Information)') &&
        isInputValidated(
            (hwTypeSelected == 1 && inputDcHardware.enclosureRow.isNull),
            'Enclosure Row (Basic Information)') &&
        isInputValidated(
            (hwTypeSelected == 2 && inputDcHardware.idParent.isNull),
            'SN Enclosure (Basic Information)') &&
        isInputValidated(
            (hwTypeSelected == 2 && inputDcHardware.xInEnclosure.isNull),
            'X in Enclosure (Basic Information)') &&
        isInputValidated(
            (hwTypeSelected == 2 && inputDcHardware.yInEnclosure.isNull),
            'Y in Enclosure (Basic Information)');
    // && validateInput(inputDcHardware.idHwType.isNull, 'Owner (Dependencies)');
  }

  void setIsReservedTo(bool value) {
    inputDcHardware.isReserved = value;
    update();
  }

  void setFilterIsReservedTo(bool value) async {
    filterDcHardware.isReserved = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }

  void setFrontBackFacingTo(int value) {
    inputDcHardware.frontbackFacing = value;
    update();
  }

  void setFilterFrontBackFacingTo(int value) async {
    filterDcHardware.frontbackFacing = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }

  void setHwConnectTypeTo(int value) {
    inputDcHardware.hwConnectType = value;
    update();
  }

  void setFilterHwConnectTypeTo(int value) async {
    filterDcHardware.hwConnectType = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }

  void setHwTypeTo(int value) {
    hwTypeSelected = value;
    update();
  }

  void setFilterHwTypeTo(int value) async {
    hwTypeFilterSelected = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }
}
