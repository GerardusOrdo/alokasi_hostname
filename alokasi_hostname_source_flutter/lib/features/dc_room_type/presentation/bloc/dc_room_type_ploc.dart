import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_room_type/domain/entities/dc_room_type_table.dart';
import '../../../dc_room_type/domain/usecases/select_dc_room_type_table.dart';
import '../../domain/entities/dc_room_type.dart';
import '../../domain/entities/dc_room_type_plus_filter.dart';
import '../../domain/entities/dc_room_type_table.dart';
import '../../domain/usecases/clone_dc_room_type_table.dart';
import '../../domain/usecases/delete_dc_room_type_table.dart';
import '../../domain/usecases/insert_dc_room_type_table.dart';
import '../../domain/usecases/select_dc_room_type_table.dart';
import '../../domain/usecases/set_delete_dc_room_type_table.dart';
import '../../domain/usecases/update_dc_room_type_table.dart';
import 'bloc_model/dc_room_type_data.dart';
import 'bloc_model/dc_room_type_text_ctrl.dart';

class DcRoomTypePloc extends MasterPagePloc {
  // ! Data Related variable
  DcRoomTypeTable dcRoomTypeTable;
  DcRoomType dcRoomType;
  DcRoomTypePlusFilter dcRoomTypePlusFilterField;
  List<DcRoomType> selectedDatasInTable = [];

  // Data Dependencies Variable
  // DcRoomTypeTable dcRoomTypeTable;
  // DcRoomTypeFilter dcRoomTypeFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Room Type';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcRoomTypeData filterDcRoomType = DcRoomTypeData();
  DcRoomTypeTextCtrl filterTextCtrl = DcRoomTypeTextCtrl(
    id: TextEditingController(),
    roomType: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcRoomTypeData inputDcRoomType = DcRoomTypeData();
  DcRoomTypeTextCtrl inputTextCtrl = DcRoomTypeTextCtrl(
    id: TextEditingController(),
    roomType: TextEditingController(),
  );

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcRoomType.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcRoomType.setNullToAllFields();
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
    dcRoomTypePlusFilterField = DcRoomTypePlusFilter(
      id: filterDcRoomType.id,
      roomType: getNullIfStringEmpty(filterDcRoomType.roomType),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcRoomType =
        await Get.find<SelectDcRoomTypeTable>()(dcRoomTypePlusFilterField);
    failureOrDcRoomType.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcRoomTypeTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - RoomType
  // Future selectAndFilterDataRoomType({
  //   @required String searchItem,
  //   bool isNeedToRefreshDcRoomType = true,
  //   int fetchLimit,
  // }) async {
  //   fetchLimit ??= masterPageDataFetchLimit;
  //   dcRoomTypeFilter = DcRoomTypeFilter(
  //     roomType: ifStringEmpty(searchItem),
  //     limits: fetchLimit,
  //     fieldToOrderBy: masterPageOrderField,
  //     orderByAscending: masterPageOrderAscending,
  //   );

  //   final failureOrDcRoomType =
  //       await Get.find<SelectDcRoomTypeTable>()(dcRoomTypeFilter);
  //   failureOrDcRoomType.fold((failure) {
  //     this.failureMessage = mapFailureToMessage(failure);
  //   }, (data) {
  //     this.dcRoomTypeTable = data;
  //   });
  //   if (isNeedToRefreshDcRoomType) {
  //     await selectAndFilterData();
  //   }
  // }

  @override
  Future insertData() async {
    dcRoomType = DcRoomType(
      roomType: inputDcRoomType.roomType,
    );
    final fetchedData = await Get.find<InsertDcRoomTypeTable>()(dcRoomType);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTypeTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - RoomType
  // void inputRoomTypeTextSelected(String value) {
  //   inputTextCtrl.roomType.text = value;
  //   inputDcRoomType.roomType = value;
  //   getInputRoomTypeSuggestionFromAPI(value);
  //   inputDcRoomType.idRoomType =
  //       dcRoomTypeTable.dcRoomType.firstWhere((element) => element.roomType == value).id;
  //   update();
  // }

  // Future<List<String>> getInputRoomTypeSuggestionFromAPI(String value) async {
  //   inputDcRoomType.roomType = value;
  //   List<String> match = [];
  //   await selectAndFilterDataRoomType(
  //           searchItem: value, isNeedToRefreshDcRoomType: true, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcRoomTypeTable.dcRoomType.forEach((element) {
  //       match.add(element.roomType);
  //     });
  //   });
  //   match.removeWhere((element) => element.isNull);
  //   return match;
  // }

  @override
  Future updateData() async {
    dcRoomType = DcRoomType(
      id: selectedDatasInTable[0].id,
      roomType: inputDcRoomType.roomType,
    );
    final fetchedData = await Get.find<UpdateDcRoomTypeTable>()(dcRoomType);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTypeTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcRoomTypeTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTypeTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcRoomTypeTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTypeTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcRoomTypeTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcRoomTypeTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcRoomTypes = dcRoomTypeTable;
    if (index >= dcRoomTypes.dcRoomType.length) return null;
    final DcRoomType dcRoomType = dcRoomTypes.dcRoomType[index];
    return DataRow.byIndex(
      index: index,
      selected: dcRoomType.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcRoomType.id.toString())),
        DataCell(Text(dcRoomType.roomType ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcRoomType.roomType = s;
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
  void onFilterRoomTypeSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.roomType,
        typedValue: typedValue,
        filterValue: filterDcRoomType.roomType,
        getFilterSuggesstion: getFilterRoomTypeSuggestionsFromAPI);
  }

  // Dependencies - RoomType

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterRoomTypeSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcRoomType.roomType = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcRoomTypeTable.dcRoomType.forEach((element) {
        match.add(element.roomType);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - roomType
  // Future<List<String>> getFilterRoomTypeSuggestionsFromAPI(String value) async {
  //   // resetDataRelatedVariable();
  //   // masterPageDataFetchLimit = null;
  //   filterDcRoomType.roomType = value;
  //   List<String> match = [];
  //   await selectAndFilterDataRoomType(searchItem: value, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcRoomTypeTable.dcRoomType.forEach((element) {
  //       match.add(element.roomType);
  //     });
  //   });
  //   match.removeWhere((element) => element.isNull);
  //   return match;
  // }

  // ! ============== Fungsi Select checkbox Tabel ==============
  void onSelectedDataChanged({
    @required bool value,
    @required int index,
  }) {
    // final dcRoomType = dcRoomTypeTableToShowOnTable.dcRoomType[index];
    final masterData = dcRoomTypeTable.dcRoomType[index];
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
    DcRoomType val =
        dcRoomTypeTable.dcRoomType.singleWhere((element) => element.id == id);

    // data
    inputDcRoomType.id = val.id;
    inputDcRoomType.roomType = val.roomType;

    // text editing Controller
    inputTextCtrl.id.text = inputDcRoomType.id.toString();
    inputTextCtrl.roomType.text = inputDcRoomType.roomType;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
            inputDcRoomType.roomType.isNull || inputDcRoomType.roomType.isEmpty,
            'RoomType (Basic Information)')
        // && validateInput(inputDcRoomType.idRoomType.isNull, 'RoomType (Dependencies)')
        ;
  }
}
