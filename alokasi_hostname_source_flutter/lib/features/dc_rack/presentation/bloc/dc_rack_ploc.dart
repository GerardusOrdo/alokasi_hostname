import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_containment/domain/entities/dc_containment_plus_filter.dart';
import '../../../dc_containment/domain/entities/dc_containment_table.dart';
import '../../../dc_containment/domain/usecases/select_dc_containment_table.dart';
import '../../../dc_containment/presentation/bloc/dc_containment_ploc.dart';
import '../../../dc_owner/domain/entities/dc_owner_plus_filter.dart';
import '../../../dc_owner/domain/entities/dc_owner_table.dart';
import '../../../dc_owner/domain/usecases/select_dc_owner_table.dart';
import '../../../dc_owner/presentation/bloc/dc_owner_ploc.dart';
import '../../../dc_room/domain/entities/dc_room_plus_filter.dart';
import '../../../dc_room/domain/entities/dc_room_table.dart';
import '../../../dc_room/domain/usecases/select_dc_room_table.dart';
import '../../../dc_room/presentation/bloc/dc_room_ploc.dart';
import '../../domain/entities/dc_rack.dart';
import '../../domain/entities/dc_rack_plus_filter.dart';
import '../../domain/entities/dc_rack_table.dart';
import '../../domain/usecases/clone_dc_rack_table.dart';
import '../../domain/usecases/delete_dc_rack_table.dart';
import '../../domain/usecases/insert_dc_rack_table.dart';
import '../../domain/usecases/select_dc_rack_table.dart';
import '../../domain/usecases/set_delete_dc_rack_table.dart';
import '../../domain/usecases/update_dc_rack_table.dart';
import 'bloc_model/dc_rack_data.dart';
import 'bloc_model/dc_rack_text_ctrl.dart';

class DcRackPloc extends MasterPagePloc {
  // ! Data Related variable
  DcRackTable dcRackTable;
  DcRack dcRack;
  DcRackPlusFilter dcRackPlusFilterField;
  List<DcRack> selectedDatasInTable = [];
  List<DropdownMenuItem<dynamic>> dropdownTopViewFacing = [
    DropdownMenuItem(
      child: Text('Left'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('Top'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Right'),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text('Down'),
      value: 3,
    ),
  ];

  // Data Dependencies Variable
  DcOwnerTable dcOwnerTable;
  DcOwnerPlusFilter dcOwnerPlusFilter;
  DcRoomTable dcRoomTable;
  DcRoomPlusFilter dcRoomPlusFilter;
  DcContainmentTable dcContainmentTable;
  DcContainmentPlusFilter dcContainmentPlusFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Rack';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcRackData filterDcRack = DcRackData();
  DcRackTextCtrl filterTextCtrl = DcRackTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    idRoom: TextEditingController(),
    roomName: TextEditingController(),
    idContainment: TextEditingController(),
    containmentName: TextEditingController(),
    topviewFacing: TextEditingController(),
    rackName: TextEditingController(),
    description: TextEditingController(),
    x: TextEditingController(),
    y: TextEditingController(),
    maxUHeight: TextEditingController(),
    requirePosition: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    isReserved: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcRackData inputDcRack = DcRackData();
  DcRackTextCtrl inputTextCtrl = DcRackTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    idRoom: TextEditingController(),
    roomName: TextEditingController(),
    idContainment: TextEditingController(),
    containmentName: TextEditingController(),
    topviewFacing: TextEditingController(),
    rackName: TextEditingController(),
    description: TextEditingController(),
    x: TextEditingController(),
    y: TextEditingController(),
    maxUHeight: TextEditingController(),
    requirePosition: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    isReserved: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  DcOwnerPloc dcOwnerPloc = Get.find<DcOwnerPloc>();
  DcRoomPloc dcRoomPloc = Get.find<DcRoomPloc>();
  DcContainmentPloc dcContainmentPloc = Get.find<DcContainmentPloc>();

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcRack.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcRack.setNullToAllFields();
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
    dcRackPlusFilterField = DcRackPlusFilter(
      id: filterDcRack.id,
      idOwner: filterDcRack.idOwner,
      owner: getNullIfStringEmpty(filterDcRack.owner),
      idRoom: filterDcRack.idRoom,
      roomName: getNullIfStringEmpty(filterDcRack.roomName),
      idContainment: filterDcRack.idContainment,
      containmentName: getNullIfStringEmpty(filterDcRack.containmentName),
      topviewFacing: filterDcRack.topviewFacing,
      rackName: getNullIfStringEmpty(filterDcRack.rackName),
      description: getNullIfStringEmpty(filterDcRack.description),
      x: filterDcRack.x,
      y: filterDcRack.y,
      maxUHeight: filterDcRack.maxUHeight,
      requirePosition: filterDcRack.requirePosition,
      width: filterDcRack.width,
      height: filterDcRack.height,
      isReserved: filterDcRack.isReserved,
      image: getNullIfStringEmpty(filterDcRack.image),
      notes: getNullIfStringEmpty(filterDcRack.notes),
      deleted: filterDcRack.deleted,
      created: getNullIfStringEmpty(filterDcRack.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcRack =
        await Get.find<SelectDcRackTable>()(dcRackPlusFilterField);
    failureOrDcRack.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcRackTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Owner
  Future selectAndFilterDataOwner({
    @required String searchItem,
    bool isNeedToRefreshDcRack = true,
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
    if (isNeedToRefreshDcRack) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Room
  Future selectAndFilterDataRoom({
    @required String searchItem,
    bool isNeedToRefreshDcRack = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcRoomPlusFilter = DcRoomPlusFilter(
      roomName: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcRoom =
        await Get.find<SelectDcRoomTable>()(dcRoomPlusFilter);
    failureOrDcRoom.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcRoomTable = data;
    });
    if (isNeedToRefreshDcRack) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Containment
  Future selectAndFilterDataContainment({
    @required String searchItem,
    bool isNeedToRefreshDcRack = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    dcContainmentPlusFilter = DcContainmentPlusFilter(
      containmentName: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcContainment =
        await Get.find<SelectDcContainmentTable>()(dcContainmentPlusFilter);
    failureOrDcContainment.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcContainmentTable = data;
    });
    if (isNeedToRefreshDcRack) {
      await selectAndFilterData();
    }
  }

  @override
  Future insertData() async {
    dcRack = DcRack(
      idOwner: inputDcRack.idOwner,
      owner: inputDcRack.owner,
      idRoom: inputDcRack.idRoom,
      roomName: inputDcRack.roomName,
      idContainment: inputDcRack.idContainment,
      containmentName: inputDcRack.containmentName,
      topviewFacing: inputDcRack.topviewFacing,
      rackName: inputDcRack.rackName,
      description: inputDcRack.description,
      x: inputDcRack.x,
      y: inputDcRack.y,
      maxUHeight: inputDcRack.maxUHeight,
      // requirePosition: inputDcRack.requirePosition,
      width: inputDcRack.width,
      height: inputDcRack.height,
      isReserved: inputDcRack.isReserved,
      // image: inputDcRack.image,
      // notes: inputDcRack.notes,
      // deleted: inputDcRack.deleted,
      // created: inputDcRack.created,
    );
    final fetchedData = await Get.find<InsertDcRackTable>()(dcRack);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRackTable) => showSnackbarDataFetchSuccess('Data has been saved'));
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
    inputDcRack.owner = value[s];
    inputDcRack.idOwner = value['id'];
    getInputOwnerSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputOwnerSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataOwner(
            searchItem: value, isNeedToRefreshDcRack: false, fetchLimit: 7)
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

  // Dependencies - Room
  void addRoomDependencies() async {
    dcRoomPloc.inputDcRoom.roomName = inputTextCtrl.roomName.text;
    await dcRoomPloc.insertData();
    getInputRoomSuggestionFromAPI(inputTextCtrl.roomName.text);
    inputTextCtrl.roomName.clear();
    update();
  }

  void inputRoomTextSelected(Map<String, dynamic> value) {
    String s = 'room';
    inputTextCtrl.roomName.text = value[s];
    inputDcRack.roomName = value[s];
    inputDcRack.idRoom = value['id'];
    getInputRoomSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputRoomSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataRoom(
            searchItem: value, isNeedToRefreshDcRack: false, fetchLimit: 7)
        .whenComplete(
      () => dcRoomTable.dcRoom.forEach((element) {
        match.add({
          'id': element.id,
          'room': element.roomName,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // Dependencies - Containment
  void addContainmentDependencies() async {
    dcContainmentPloc.inputDcContainment.containmentName =
        inputTextCtrl.containmentName.text;
    await dcContainmentPloc.insertData();
    getInputContainmentSuggestionFromAPI(inputTextCtrl.containmentName.text);
    inputTextCtrl.containmentName.clear();
    update();
  }

  void inputContainmentTextSelected(Map<String, dynamic> value) {
    String s = 'containment';
    inputTextCtrl.containmentName.text = value[s];
    inputDcRack.containmentName = value[s];
    inputDcRack.idContainment = value['id'];
    getInputContainmentSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputContainmentSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataContainment(
            searchItem: value, isNeedToRefreshDcRack: false, fetchLimit: 7)
        .whenComplete(
      () => dcContainmentTable.dcContainment.forEach((element) {
        match.add({
          'id': element.id,
          'containment': element.containmentName,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
  }

  @override
  Future updateData() async {
    dcRack = DcRack(
      id: selectedDatasInTable[0].id,
      idOwner: inputDcRack.idOwner,
      // owner: inputDcRack.owner,
      idRoom: inputDcRack.idRoom,
      // roomName: inputDcRack.roomName,
      idContainment: inputDcRack.idContainment,
      // containmentName: inputDcRack.containmentName,
      topviewFacing: inputDcRack.topviewFacing,
      rackName: inputDcRack.rackName,
      description: inputDcRack.description,
      x: inputDcRack.x,
      y: inputDcRack.y,
      maxUHeight: inputDcRack.maxUHeight,
      // requirePosition: inputDcRack.requirePosition,
      width: inputDcRack.width,
      height: inputDcRack.height,
      isReserved: inputDcRack.isReserved,
    );
    final fetchedData = await Get.find<UpdateDcRackTable>()(dcRack);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRackTable) => showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcRackTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRackTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcRackTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRackTable) => showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcRackTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRackTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcRacks = dcRackTable;
    if (index >= dcRacks.dcRack.length) return null;
    final DcRack dcRack = dcRacks.dcRack[index];
    return DataRow.byIndex(
      index: index,
      selected: dcRack.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcRack.id.toString())),
        DataCell(Text(dcRack.owner ?? '')),
        DataCell(Text(dcRack.roomName ?? '')),
        // DataCell(Text(dcRack.containmentName ?? '')),
        DataCell(Text(dcRack.rackName ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcRack.owner = s;
      filterDcRack.roomName = s;
      filterDcRack.containmentName = s;
      filterDcRack.rackName = s;
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
  void onFilterRackNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.rackName,
        typedValue: typedValue,
        filterValue: filterDcRack.rackName,
        getFilterSuggesstion: getFilterRackNameSuggestionsFromAPI);
  }

  void onFilterDescriptionSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.description,
        typedValue: typedValue,
        filterValue: filterDcRack.description,
        getFilterSuggesstion: getFilterDescriptionSuggestionsFromAPI);
  }

  void onFilterImageSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.image,
        typedValue: typedValue,
        filterValue: filterDcRack.image,
        getFilterSuggesstion: getFilterImageSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterDcRack.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterDcRack.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Owner
  void onFilterOwnerSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.owner,
        typedValue: typedValue,
        filterValue: filterDcRack.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  // Dependencies - Room
  void onFilterRoomNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.roomName,
        typedValue: typedValue,
        filterValue: filterDcRack.roomName,
        getFilterSuggesstion: getFilterRoomSuggestionsFromAPI);
  }

  // Dependencies - Containment
  void onFilterContainmentNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.containmentName,
        typedValue: typedValue,
        filterValue: filterDcRack.containmentName,
        getFilterSuggesstion: getFilterContainmentSuggestionsFromAPI);
  }

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcRack.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRackTable.dcRack.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterRackNameSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRack.rackName = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRackTable.dcRack.forEach((element) {
        match.add(element.rackName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterDescriptionSuggestionsFromAPI(
      String value) async {
    masterPageDataFetchLimit = null;
    filterDcRack.description = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRackTable.dcRack.forEach((element) {
        match.add(element.description);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterImageSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRack.image = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRackTable.dcRack.forEach((element) {
        match.add(element.image);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRack.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRackTable.dcRack.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRack.created = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRackTable.dcRack.forEach((element) {
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
    filterDcRack.owner = value;
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

  // dependencies - Room
  Future<List<String>> getFilterRoomSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcRack.roomName = value;
    List<String> match = [];
    await selectAndFilterDataRoom(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcRoomTable.dcRoom.forEach((element) {
        match.add(element.roomName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - containment
  Future<List<String>> getFilterContainmentSuggestionsFromAPI(
      String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcRack.containmentName = value;
    List<String> match = [];
    await selectAndFilterDataContainment(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcContainmentTable.dcContainment.forEach((element) {
        match.add(element.containmentName);
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
    final masterData = dcRackTable.dcRack[index];
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
    DcRack val = dcRackTable.dcRack.singleWhere((element) => element.id == id);

    // data
    inputDcRack.id = val.id;
    inputDcRack.idOwner = val.idOwner;
    inputDcRack.owner = val.owner;
    inputDcRack.idRoom = val.idRoom;
    inputDcRack.roomName = val.roomName;
    inputDcRack.idContainment = val.idContainment;
    inputDcRack.containmentName = val.containmentName;
    inputDcRack.topviewFacing = val.topviewFacing;
    inputDcRack.rackName = val.rackName;
    inputDcRack.description = val.description;
    inputDcRack.x = val.x;
    inputDcRack.y = val.y;
    inputDcRack.maxUHeight = val.maxUHeight;
    inputDcRack.requirePosition = val.requirePosition;
    inputDcRack.width = val.width;
    inputDcRack.height = val.height;
    inputDcRack.isReserved = val.isReserved;
    inputDcRack.image = val.image;
    inputDcRack.notes = val.notes;
    inputDcRack.deleted = val.deleted;
    inputDcRack.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputDcRack.id.toString();
    inputTextCtrl.idOwner.text = inputDcRack.idOwner.toString();
    inputTextCtrl.owner.text = inputDcRack.owner;
    inputTextCtrl.idRoom.text = inputDcRack.idRoom.toString();
    inputTextCtrl.roomName.text = inputDcRack.roomName;
    inputTextCtrl.idContainment.text = inputDcRack.idContainment.toString();
    inputTextCtrl.containmentName.text = inputDcRack.containmentName;
    inputTextCtrl.topviewFacing.text = inputDcRack.topviewFacing.toString();
    inputTextCtrl.rackName.text = inputDcRack.rackName;
    inputTextCtrl.description.text = inputDcRack.description;
    inputTextCtrl.x.text = inputDcRack.x.toString();
    inputTextCtrl.y.text = inputDcRack.y.toString();
    inputTextCtrl.maxUHeight.text = inputDcRack.maxUHeight.toString();
    inputTextCtrl.requirePosition.text = inputDcRack.requirePosition.toString();
    inputTextCtrl.width.text = inputDcRack.width.toString();
    inputTextCtrl.height.text = inputDcRack.height.toString();
    inputTextCtrl.isReserved.text = inputDcRack.isReserved.toString();
    inputTextCtrl.image.text = inputDcRack.image;
    inputTextCtrl.notes.text = inputDcRack.notes;
    inputTextCtrl.deleted.text = inputDcRack.deleted.toString();
    inputTextCtrl.created.text = inputDcRack.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    inputDcRack.isReserved =
        inputDcRack.isReserved.isNull ? false : inputDcRack.isReserved;
    return isInputValidated(
            inputDcRack.rackName.isNull || inputDcRack.rackName.isEmpty,
            'Rack (Basic Information)')
        // && validateInput(inputDcRack.idOwner.isNull, 'Owner (Dependencies)')
        ;
  }

  void setIsReservedTo(bool value) {
    inputDcRack.isReserved = value;
    update();
  }

  void setFilterIsReservedTo(bool value) async {
    filterDcRack.isReserved = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }

  void setTopViewFacingTo(int value) {
    inputDcRack.topviewFacing = value;
    update();
  }

  void setFilterTopViewFacingTo(int value) {
    filterDcRack.topviewFacing = value;
    update();
  }
}
