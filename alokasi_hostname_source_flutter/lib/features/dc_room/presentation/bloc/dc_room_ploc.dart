import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_owner/domain/entities/dc_owner_plus_filter.dart';
import '../../../dc_owner/domain/entities/dc_owner_table.dart';
import '../../../dc_owner/domain/usecases/select_dc_owner_table.dart';
import '../../../dc_owner/presentation/bloc/dc_owner_ploc.dart';
import '../../../dc_room_type/domain/entities/dc_room_type_plus_filter.dart';
import '../../../dc_room_type/domain/entities/dc_room_type_table.dart';
import '../../../dc_room_type/domain/usecases/select_dc_room_type_table.dart';
import '../../../dc_room_type/presentation/bloc/dc_room_type_ploc.dart';
import '../../../dc_site/domain/entities/dc_site_plus_filter.dart';
import '../../../dc_site/domain/entities/dc_site_table.dart';
import '../../../dc_site/domain/usecases/select_dc_site_table.dart';
import '../../../dc_site/presentation/bloc/dc_site_ploc.dart';
import '../../domain/entities/dc_room.dart';
import '../../domain/entities/dc_room_plus_filter.dart';
import '../../domain/entities/dc_room_table.dart';
import '../../domain/usecases/clone_dc_room_table.dart';
import '../../domain/usecases/delete_dc_room_table.dart';
import '../../domain/usecases/insert_dc_room_table.dart';
import '../../domain/usecases/select_dc_room_table.dart';
import '../../domain/usecases/set_delete_dc_room_table.dart';
import '../../domain/usecases/update_dc_room_table.dart';
import 'bloc_model/dc_room_data.dart';
import 'bloc_model/dc_room_text_ctrl.dart';

class DcRoomPloc extends MasterPagePloc {
  // ! Data Related variable
  DcRoomTable dcRoomTable;
  DcRoom dcRoom;
  DcRoomPlusFilter dcRoomPlusFilterField;
  List<DcRoom> selectedDatasInTable = [];

  // Data Dependencies Variable
  DcOwnerTable dcOwnerTable;
  DcOwnerPlusFilter dcOwnerPlusFilter;
  DcSiteTable dcSiteTable;
  DcSitePlusFilter dcSitePlusFilter;
  DcRoomTypeTable dcRoomTypeTable;
  DcRoomTypePlusFilter dcRoomTypePlusFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Room';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcRoomData filterDcRoom = DcRoomData();
  DcRoomTextCtrl filterTextCtrl = DcRoomTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    idDcSite: TextEditingController(),
    dcSiteName: TextEditingController(),
    idRoomType: TextEditingController(),
    roomType: TextEditingController(),
    roomName: TextEditingController(),
    idParentRoom: TextEditingController(),
    x: TextEditingController(),
    y: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    rackCapacity: TextEditingController(),
    isReserved: TextEditingController(),
    map: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcRoomData inputDcRoom = DcRoomData();
  DcRoomTextCtrl inputTextCtrl = DcRoomTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    idDcSite: TextEditingController(),
    dcSiteName: TextEditingController(),
    idRoomType: TextEditingController(),
    roomType: TextEditingController(),
    roomName: TextEditingController(),
    idParentRoom: TextEditingController(),
    x: TextEditingController(),
    y: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    rackCapacity: TextEditingController(),
    isReserved: TextEditingController(),
    map: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  DcOwnerPloc dcOwnerPloc = Get.find<DcOwnerPloc>();
  DcSitePloc dcSitePloc = Get.find<DcSitePloc>();
  DcRoomTypePloc dcRoomTypePloc = Get.find<DcRoomTypePloc>();

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcRoom.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcRoom.setNullToAllFields();
  }

  @override
  void resetFilterController() {
    super.resetFilterController();
    filterTextCtrl.clearAllTextCtrl();
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
    dcRoomPlusFilterField = DcRoomPlusFilter(
      id: filterDcRoom.id,
      idOwner: filterDcRoom.idOwner,
      owner: getNullIfStringEmpty(filterDcRoom.owner),
      idDcSite: filterDcRoom.idDcSite,
      dcSiteName: getNullIfStringEmpty(filterDcRoom.dcSiteName),
      idRoomType: filterDcRoom.idRoomType,
      roomType: getNullIfStringEmpty(filterDcRoom.roomType),
      roomName: getNullIfStringEmpty(filterDcRoom.roomName),
      idParentRoom: filterDcRoom.idParentRoom,
      x: filterDcRoom.x,
      y: filterDcRoom.y,
      width: filterDcRoom.width,
      height: filterDcRoom.height,
      isReserved: filterDcRoom.isReserved,
      map: getNullIfStringEmpty(filterDcRoom.map),
      image: getNullIfStringEmpty(filterDcRoom.image),
      notes: getNullIfStringEmpty(filterDcRoom.notes),
      deleted: filterDcRoom.deleted,
      created: getNullIfStringEmpty(filterDcRoom.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcRoom =
        await Get.find<SelectDcRoomTable>()(dcRoomPlusFilterField);
    failureOrDcRoom.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcRoomTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Owner
  Future selectAndFilterDataOwner({
    @required String searchItem,
    bool isNeedToRefreshDcRoom = true,
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
    if (isNeedToRefreshDcRoom) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Dc Site
  Future selectAndFilterDataDcSite({
    @required String searchItem,
    bool isNeedToRefreshDcRoom = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcSitePlusFilter = DcSitePlusFilter(
      dcSiteName: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcSite =
        await Get.find<SelectDcSiteTable>()(dcSitePlusFilter);
    failureOrDcSite.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcSiteTable = data;
    });
    if (isNeedToRefreshDcRoom) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Room Type
  Future selectAndFilterDataRoomType({
    @required String searchItem,
    bool isNeedToRefreshDcRoom = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcRoomTypePlusFilter = DcRoomTypePlusFilter(
      roomType: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcRoomType =
        await Get.find<SelectDcRoomTypeTable>()(dcRoomTypePlusFilter);
    failureOrDcRoomType.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcRoomTypeTable = data;
    });
    if (isNeedToRefreshDcRoom) {
      await selectAndFilterData();
    }
  }

  @override
  Future insertData() async {
    dcRoom = DcRoom(
      idOwner: inputDcRoom.idOwner,
      idDcSite: inputDcRoom.idDcSite,
      idRoomType: inputDcRoom.idRoomType,
      roomName: inputDcRoom.roomName,
      // idParentRoom: inputDcRoom.idParentRoom,
      x: inputDcRoom.x,
      y: inputDcRoom.y,
      width: inputDcRoom.width,
      height: inputDcRoom.height,
      rackCapacity: inputDcRoom.rackCapacity,
      isReserved: inputDcRoom.isReserved,
      // map: inputDcRoom.map,
      // image: inputDcRoom.image,
      // notes: inputDcRoom.notes,
      // deleted: inputDcRoom.deleted,
      // created: inputDcRoom.created,
    );
    final fetchedData = await Get.find<InsertDcRoomTable>()(dcRoom);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTable) => showSnackbarDataFetchSuccess('Data has been saved'));
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
    String s = 'owner';
    inputTextCtrl.owner.text = value[s];
    inputDcRoom.owner = value[s];
    inputDcRoom.idOwner = value['id'];
    getInputOwnerSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputOwnerSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataOwner(
            searchItem: value, isNeedToRefreshDcRoom: false, fetchLimit: 7)
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

  // Dependencies - DcSite
  void addDcSiteDependencies() async {
    dcSitePloc.inputDcSite.dcSiteName = inputTextCtrl.dcSiteName.text;
    await dcSitePloc.insertData();
    getInputDcSiteSuggestionFromAPI(inputTextCtrl.dcSiteName.text);
    inputTextCtrl.dcSiteName.clear();
    update();
  }

  void inputDcSiteTextSelected(Map<String, dynamic> value) {
    String s = 'dc_site';
    inputTextCtrl.dcSiteName.text = value[s];
    inputDcRoom.dcSiteName = value[s];
    inputDcRoom.idDcSite = value['id'];
    getInputDcSiteSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputDcSiteSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataDcSite(
            searchItem: value, isNeedToRefreshDcRoom: false, fetchLimit: 7)
        .whenComplete(
      () => dcSiteTable.dcSite.forEach((element) {
        match.add({
          'id': element.id,
          'dc_site': element.dcSiteName,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // Dependencies - RoomType
  void addRoomTypeDependencies() async {
    dcRoomTypePloc.inputDcRoomType.roomType = inputTextCtrl.roomType.text;
    await dcSitePloc.insertData();
    getInputDcSiteSuggestionFromAPI(inputTextCtrl.dcSiteName.text);
    inputTextCtrl.dcSiteName.clear();
    update();
  }

  void inputRoomTypeTextSelected(Map<String, dynamic> value) {
    String s = 'room_type';
    inputTextCtrl.roomType.text = value[s];
    inputDcRoom.roomType = value[s];
    inputDcRoom.idRoomType = value['id'];
    getInputRoomTypeSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputRoomTypeSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataRoomType(
            searchItem: value, isNeedToRefreshDcRoom: false, fetchLimit: 7)
        .whenComplete(
      () => dcRoomTypeTable.dcRoomType.forEach((element) {
        match.add({
          'id': element.id,
          'room_type': element.roomType,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  @override
  Future updateData() async {
    dcRoom = DcRoom(
      id: selectedDatasInTable[0].id,
      idOwner: inputDcRoom.idOwner,
      idDcSite: inputDcRoom.idDcSite,
      idRoomType: inputDcRoom.idRoomType,
      roomName: inputDcRoom.roomName,
      // idParentRoom: inputDcRoom.idParentRoom,
      x: inputDcRoom.x,
      y: inputDcRoom.y,
      width: inputDcRoom.width,
      height: inputDcRoom.height,
      rackCapacity: inputDcRoom.rackCapacity,
      isReserved: inputDcRoom.isReserved,
      // map: inputDcRoom.map,
      // image: inputDcRoom.image,
      // notes: inputDcRoom.notes,
      // deleted: inputDcRoom.deleted,
      // created: inputDcRoom.created,
    );
    final fetchedData = await Get.find<UpdateDcRoomTable>()(dcRoom);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTable) => showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcRoomTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcRoomTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTable) => showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcRoomTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcRooms = dcRoomTable;
    if (index >= dcRooms.dcRoom.length) return null;
    final DcRoom dcRoom = dcRooms.dcRoom[index];
    return DataRow.byIndex(
      index: index,
      selected: dcRoom.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcRoom.id.toString())),
        DataCell(Text(dcRoom.owner ?? '')),
        DataCell(Text(dcRoom.roomType ?? '')),
        DataCell(Text(dcRoom.roomName ?? '')),
        DataCell(Text(dcRoom.rackCapacity.toString() ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcRoom.owner = s;
      filterDcRoom.roomType = s;
      filterDcRoom.roomName = s;
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
  void onFilterRoomNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.roomName,
        typedValue: typedValue,
        filterValue: filterDcRoom.roomName,
        getFilterSuggesstion: getFilterRoomNameSuggestionsFromAPI);
  }

  void onFilterMapSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.map,
        typedValue: typedValue,
        filterValue: filterDcRoom.map,
        getFilterSuggesstion: getFilterMapSuggestionsFromAPI);
  }

  void onFilterImageSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.image,
        typedValue: typedValue,
        filterValue: filterDcRoom.image,
        getFilterSuggesstion: getFilterImageSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterDcRoom.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterDcRoom.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Owner
  void onFilterOwnerSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.owner,
        typedValue: typedValue,
        filterValue: filterDcRoom.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  // Dependencies - Dc Site
  void onFilterDcSiteNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.dcSiteName,
        typedValue: typedValue,
        filterValue: filterDcRoom.dcSiteName,
        getFilterSuggesstion: getFilterDcSiteSuggestionsFromAPI);
  }

  // Dependencies - Room Type
  void onFilterRoomTypeSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.roomType,
        typedValue: typedValue,
        filterValue: filterDcRoom.roomType,
        getFilterSuggesstion: getFilterRoomTypeSuggestionsFromAPI);
  }

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcRoom.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRoomTable.dcRoom.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterRoomNameSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRoom.roomName = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRoomTable.dcRoom.forEach((element) {
        match.add(element.roomName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterMapSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRoom.map = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRoomTable.dcRoom.forEach((element) {
        match.add(element.map);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterImageSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRoom.image = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRoomTable.dcRoom.forEach((element) {
        match.add(element.image);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRoom.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRoomTable.dcRoom.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRoom.created = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRoomTable.dcRoom.forEach((element) {
        match.add(element.created);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - owner
  Future<List<String>> getFilterOwnerSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcRoom.owner = value;
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

  // dependencies - Dc Site
  Future<List<String>> getFilterDcSiteSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcRoom.dcSiteName = value;
    List<String> match = [];
    await selectAndFilterDataDcSite(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcSiteTable.dcSite.forEach((element) {
        match.add(element.dcSiteName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - Room Type
  Future<List<String>> getFilterRoomTypeSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcRoom.roomType = value;
    List<String> match = [];
    await selectAndFilterDataRoomType(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcRoomTypeTable.dcRoomType.forEach((element) {
        match.add(element.roomType);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // ! ============== Fungsi Select checkbox Tabel ==============
  void onSelectedDataChanged({
    @required bool value,
    @required int index,
  }) {
    // final dcOwner = dcOwnerTableToShowOnTable.dcOwner[index];
    final masterData = dcRoomTable.dcRoom[index];
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
    DcRoom val = dcRoomTable.dcRoom.singleWhere((element) => element.id == id);

    // data
    inputDcRoom.id = val.id;
    inputDcRoom.idOwner = val.idOwner;
    inputDcRoom.owner = val.owner;
    inputDcRoom.idDcSite = val.idDcSite;
    inputDcRoom.dcSiteName = val.dcSiteName;
    inputDcRoom.idRoomType = val.idRoomType;
    inputDcRoom.roomType = val.roomType;
    inputDcRoom.roomName = val.roomName;
    inputDcRoom.idParentRoom = val.idParentRoom;
    inputDcRoom.x = val.x;
    inputDcRoom.y = val.y;
    inputDcRoom.width = val.width;
    inputDcRoom.height = val.height;
    inputDcRoom.rackCapacity = val.rackCapacity;
    inputDcRoom.isReserved = val.isReserved;
    inputDcRoom.map = val.map;
    inputDcRoom.image = val.image;
    inputDcRoom.notes = val.notes;
    inputDcRoom.deleted = val.deleted;
    inputDcRoom.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputDcRoom.id.toString();
    inputTextCtrl.idOwner.text = inputDcRoom.idOwner.toString();
    inputTextCtrl.owner.text = inputDcRoom.owner;
    inputTextCtrl.idDcSite.text = inputDcRoom.idDcSite.toString();
    inputTextCtrl.dcSiteName.text = inputDcRoom.dcSiteName;
    inputTextCtrl.idRoomType.text = inputDcRoom.idRoomType.toString();
    inputTextCtrl.roomType.text = inputDcRoom.roomType;
    inputTextCtrl.roomName.text = inputDcRoom.roomName;
    inputTextCtrl.idParentRoom.text = inputDcRoom.idParentRoom.toString();
    inputTextCtrl.x.text = inputDcRoom.x.toString();
    inputTextCtrl.y.text = inputDcRoom.y.toString();
    inputTextCtrl.width.text = inputDcRoom.width.toString();
    inputTextCtrl.height.text = inputDcRoom.height.toString();
    inputTextCtrl.rackCapacity.text = inputDcRoom.rackCapacity.toString();
    inputTextCtrl.isReserved.text = inputDcRoom.isReserved.toString();
    inputTextCtrl.map.text = inputDcRoom.map;
    inputTextCtrl.image.text = inputDcRoom.image;
    inputTextCtrl.notes.text = inputDcRoom.notes;
    inputTextCtrl.deleted.text = inputDcRoom.deleted.toString();
    inputTextCtrl.created.text = inputDcRoom.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    inputDcRoom.isReserved =
        inputDcRoom.isReserved.isNull ? false : inputDcRoom.isReserved;
    return isInputValidated(
            inputDcRoom.roomName.isNull || inputDcRoom.roomName.isEmpty,
            'Room Name (Basic Information)')
        // && validateInput(inputDcRoom.idOwner.isNull, 'Owner (Dependencies)')
        ;
  }

  void setIsReservedTo(bool value) {
    inputDcRoom.isReserved = value;
    update();
  }

  void setFilterIsReservedTo(bool value) async {
    filterDcRoom.isReserved = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }
}
