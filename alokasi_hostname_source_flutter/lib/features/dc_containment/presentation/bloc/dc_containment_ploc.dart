import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_owner/domain/entities/dc_owner_plus_filter.dart';
import '../../../dc_owner/domain/entities/dc_owner_table.dart';
import '../../../dc_owner/domain/usecases/select_dc_owner_table.dart';
import '../../../dc_owner/presentation/bloc/dc_owner_ploc.dart';
import '../../../dc_room/domain/entities/dc_room_plus_filter.dart';
import '../../../dc_room/domain/entities/dc_room_table.dart';
import '../../../dc_room/domain/usecases/select_dc_room_table.dart';
import '../../../dc_room/presentation/bloc/dc_room_ploc.dart';
import '../../domain/entities/dc_containment.dart';
import '../../domain/entities/dc_containment_plus_filter.dart';
import '../../domain/entities/dc_containment_table.dart';
import '../../domain/usecases/clone_dc_containment_table.dart';
import '../../domain/usecases/delete_dc_containment_table.dart';
import '../../domain/usecases/insert_dc_containment_table.dart';
import '../../domain/usecases/select_dc_containment_table.dart';
import '../../domain/usecases/set_delete_dc_containment_table.dart';
import '../../domain/usecases/update_dc_containment_table.dart';
import 'bloc_model/dc_containment_data.dart';
import 'bloc_model/dc_containment_text_ctrl.dart';

class DcContainmentPloc extends MasterPagePloc {
  // ! Data Related variable
  DcContainmentTable dcContainmentTable;
  DcContainment dcContainment;
  DcContainmentPlusFilter dcContainmentPlusFilterField;
  List<DcContainment> selectedDatasInTable = [];
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

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Containment';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcContainmentData filterDcContainment = DcContainmentData();
  DcContainmentTextCtrl filterTextCtrl = DcContainmentTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    idDcRoom: TextEditingController(),
    roomName: TextEditingController(),
    topviewFacing: TextEditingController(),
    containmentName: TextEditingController(),
    x: TextEditingController(),
    y: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    isReserved: TextEditingController(),
    row: TextEditingController(),
    column: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcContainmentData inputDcContainment = DcContainmentData();
  DcContainmentTextCtrl inputTextCtrl = DcContainmentTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    idDcRoom: TextEditingController(),
    roomName: TextEditingController(),
    topviewFacing: TextEditingController(),
    containmentName: TextEditingController(),
    x: TextEditingController(),
    y: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    isReserved: TextEditingController(),
    row: TextEditingController(),
    column: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  DcOwnerPloc dcOwnerPloc = Get.find<DcOwnerPloc>();
  DcRoomPloc dcRoomPloc = Get.find<DcRoomPloc>();

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcContainment.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcContainment.setNullToAllFields();
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
    dcContainmentPlusFilterField = DcContainmentPlusFilter(
      id: filterDcContainment.id,
      idOwner: filterDcContainment.idOwner,
      owner: getNullIfStringEmpty(filterDcContainment.owner),
      idDcRoom: filterDcContainment.idDcRoom,
      roomName: getNullIfStringEmpty(filterDcContainment.roomName),
      topviewFacing: filterDcContainment.topviewFacing,
      containmentName:
          getNullIfStringEmpty(filterDcContainment.containmentName),
      x: filterDcContainment.x,
      y: filterDcContainment.y,
      width: filterDcContainment.width,
      height: filterDcContainment.height,
      isReserved: filterDcContainment.isReserved,
      row: filterDcContainment.row,
      column: filterDcContainment.column,
      image: getNullIfStringEmpty(filterDcContainment.image),
      notes: getNullIfStringEmpty(filterDcContainment.notes),
      deleted: filterDcContainment.deleted,
      created: getNullIfStringEmpty(filterDcContainment.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcContainment = await Get.find<SelectDcContainmentTable>()(
        dcContainmentPlusFilterField);
    failureOrDcContainment.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcContainmentTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Owner
  Future selectAndFilterDataOwner({
    @required String searchItem,
    bool isNeedToRefreshDcContainment = true,
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
    if (isNeedToRefreshDcContainment) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Room
  Future selectAndFilterDataRoom({
    @required String searchItem,
    bool isNeedToRefreshDcContainment = true,
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
    if (isNeedToRefreshDcContainment) {
      await selectAndFilterData();
    }
  }

  @override
  Future insertData() async {
    dcContainment = DcContainment(
      idOwner: inputDcContainment.idOwner,
      idDcRoom: inputDcContainment.idDcRoom,
      topviewFacing: inputDcContainment.topviewFacing,
      containmentName: inputDcContainment.containmentName,
      x: inputDcContainment.x,
      y: inputDcContainment.y,
      width: inputDcContainment.width,
      height: inputDcContainment.height,
      isReserved: inputDcContainment.isReserved,
      row: inputDcContainment.row,
      column: inputDcContainment.column,
      // image: inputDcContainment.image,
      // notes: inputDcContainment.notes,
      // deleted: inputDcContainment.deleted,
      // created: inputDcContainment.created,
    );
    final fetchedData =
        await Get.find<InsertDcContainmentTable>()(dcContainment);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcContainmentTable) =>
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
    String s = 'owner';
    inputTextCtrl.owner.text = value[s];
    inputDcContainment.owner = value[s];
    inputDcContainment.idOwner = value['id'];
    getInputOwnerSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputOwnerSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataOwner(
            searchItem: value,
            isNeedToRefreshDcContainment: false,
            fetchLimit: 7)
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
    inputDcContainment.roomName = value[s];
    inputDcContainment.idDcRoom = value['id'];
    getInputRoomSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputRoomSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataRoom(
            searchItem: value,
            isNeedToRefreshDcContainment: false,
            fetchLimit: 7)
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

  @override
  Future updateData() async {
    dcContainment = DcContainment(
      id: selectedDatasInTable[0].id,
      idOwner: inputDcContainment.idOwner,
      idDcRoom: inputDcContainment.idDcRoom,
      topviewFacing: inputDcContainment.topviewFacing,
      containmentName: inputDcContainment.containmentName,
      x: inputDcContainment.x,
      y: inputDcContainment.y,
      width: inputDcContainment.width,
      height: inputDcContainment.height,
      isReserved: inputDcContainment.isReserved,
      row: inputDcContainment.row,
      column: inputDcContainment.column,
    );
    final fetchedData =
        await Get.find<UpdateDcContainmentTable>()(dcContainment);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcContainmentTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcContainmentTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcContainmentTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcContainmentTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcContainmentTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcContainmentTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcContainmentTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcContainments = dcContainmentTable;
    if (index >= dcContainments.dcContainment.length) return null;
    final DcContainment dcContainment = dcContainments.dcContainment[index];
    return DataRow.byIndex(
      index: index,
      selected: dcContainment.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcContainment.id.toString())),
        DataCell(Text(dcContainment.owner ?? '')),
        DataCell(Text(dcContainment.roomName ?? '')),
        DataCell(Text(dcContainment.containmentName ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcContainment.owner = s;
      filterDcContainment.roomName = s;
      filterDcContainment.containmentName = s;
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
  void onFilterContainmentNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.containmentName,
        typedValue: typedValue,
        filterValue: filterDcContainment.containmentName,
        getFilterSuggesstion: getFilterContainmentNameSuggestionsFromAPI);
  }

  void onFilterImageSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.image,
        typedValue: typedValue,
        filterValue: filterDcContainment.image,
        getFilterSuggesstion: getFilterImageSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterDcContainment.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterDcContainment.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Owner
  void onFilterOwnerSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.owner,
        typedValue: typedValue,
        filterValue: filterDcContainment.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  // Dependencies - Room
  void onFilterRoomNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.roomName,
        typedValue: typedValue,
        filterValue: filterDcContainment.roomName,
        getFilterSuggesstion: getFilterRoomSuggestionsFromAPI);
  }

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcContainment.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcContainmentTable.dcContainment.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterContainmentNameSuggestionsFromAPI(
      String value) async {
    masterPageDataFetchLimit = null;
    filterDcContainment.containmentName = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcContainmentTable.dcContainment.forEach((element) {
        match.add(element.containmentName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterImageSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcContainment.image = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcContainmentTable.dcContainment.forEach((element) {
        match.add(element.image);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcContainment.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcContainmentTable.dcContainment.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcContainment.created = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcContainmentTable.dcContainment.forEach((element) {
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
    filterDcContainment.owner = value;
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

  // dependencies - room
  Future<List<String>> getFilterRoomSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterDcContainment.roomName = value;
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

  // ! ============== Fungsi Select checkbox Tabel ==============
  void onSelectedDataChanged({
    @required bool value,
    @required int index,
  }) {
    // final dcOwner = dcOwnerTableToShowOnTable.dcOwner[index];
    final masterData = dcContainmentTable.dcContainment[index];
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
    DcContainment val = dcContainmentTable.dcContainment
        .singleWhere((element) => element.id == id);

    // data
    inputDcContainment.id = val.id;
    inputDcContainment.idOwner = val.idOwner;
    inputDcContainment.owner = val.owner;
    inputDcContainment.idDcRoom = val.idDcRoom;
    inputDcContainment.roomName = val.roomName;
    inputDcContainment.topviewFacing = val.topviewFacing;
    inputDcContainment.containmentName = val.containmentName;
    inputDcContainment.x = val.x;
    inputDcContainment.y = val.y;
    inputDcContainment.width = val.width;
    inputDcContainment.height = val.height;
    inputDcContainment.isReserved = val.isReserved;
    inputDcContainment.row = val.row;
    inputDcContainment.column = val.column;
    inputDcContainment.image = val.image;
    inputDcContainment.notes = val.notes;
    inputDcContainment.deleted = val.deleted;
    inputDcContainment.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputDcContainment.id.toString();
    inputTextCtrl.idOwner.text = inputDcContainment.idOwner.toString();
    inputTextCtrl.owner.text = inputDcContainment.owner;
    inputTextCtrl.idDcRoom.text = inputDcContainment.idDcRoom.toString();
    inputTextCtrl.roomName.text = inputDcContainment.roomName;
    inputTextCtrl.topviewFacing.text =
        inputDcContainment.topviewFacing.toString();
    inputTextCtrl.containmentName.text = inputDcContainment.containmentName;
    inputTextCtrl.x.text = inputDcContainment.x.toString();
    inputTextCtrl.y.text = inputDcContainment.y.toString();
    inputTextCtrl.width.text = inputDcContainment.width.toString();
    inputTextCtrl.height.text = inputDcContainment.height.toString();
    inputTextCtrl.isReserved.text = inputDcContainment.isReserved.toString();
    inputTextCtrl.row.text = inputDcContainment.row.toString();
    inputTextCtrl.column.text = inputDcContainment.column.toString();
    inputTextCtrl.image.text = inputDcContainment.image;
    inputTextCtrl.notes.text = inputDcContainment.notes;
    inputTextCtrl.deleted.text = inputDcContainment.deleted.toString();
    inputTextCtrl.created.text = inputDcContainment.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    inputDcContainment.isReserved = inputDcContainment.isReserved.isNull
        ? false
        : inputDcContainment.isReserved;
    return isInputValidated(
            inputDcContainment.containmentName.isNull ||
                inputDcContainment.containmentName.isEmpty,
            'Containment (Basic Information)')
        // && validateInput(inputDcContainment.idOwner.isNull, 'Owner (Dependencies)')
        ;
  }

  void setIsReservedTo(bool value) {
    inputDcContainment.isReserved = value;
    update();
  }

  void setFilterIsReservedTo(bool value) async {
    filterDcContainment.isReserved = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }

  void setTopViewFacingTo(int value) {
    inputDcContainment.topviewFacing = value;
    update();
  }

  void setFilterTopViewFacingTo(int value) async {
    filterDcContainment.topviewFacing = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }
}
