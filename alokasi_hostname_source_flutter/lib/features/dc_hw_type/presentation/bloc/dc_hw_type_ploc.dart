import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_hw_type/domain/entities/dc_hw_type_table.dart';
import '../../../dc_hw_type/domain/usecases/select_dc_hw_type_table.dart';
import '../../domain/entities/dc_hw_type.dart';
import '../../domain/entities/dc_hw_type_plus_filter.dart';
import '../../domain/entities/dc_hw_type_table.dart';
import '../../domain/usecases/clone_dc_hw_type_table.dart';
import '../../domain/usecases/delete_dc_hw_type_table.dart';
import '../../domain/usecases/insert_dc_hw_type_table.dart';
import '../../domain/usecases/select_dc_hw_type_table.dart';
import '../../domain/usecases/set_delete_dc_hw_type_table.dart';
import '../../domain/usecases/update_dc_hw_type_table.dart';
import 'bloc_model/dc_hw_type_data.dart';
import 'bloc_model/dc_hw_type_text_ctrl.dart';

class DcHwTypePloc extends MasterPagePloc {
  // ! Data Related variable
  DcHwTypeTable dcHwTypeTable;
  DcHwType dcHwType;
  DcHwTypePlusFilter dcHwTypePlusFilterField;
  List<DcHwType> selectedDatasInTable = [];

  // Data Dependencies Variable
  // DcHwTypeTable dcHwTypeTable;
  // DcHwTypeFilter dcHwTypeFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Hardware Type';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcHwTypeData filterDcHwType = DcHwTypeData();
  DcHwTypeTextCtrl filterTextCtrl = DcHwTypeTextCtrl(
    id: TextEditingController(),
    hwType: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcHwTypeData inputDcHwType = DcHwTypeData();
  DcHwTypeTextCtrl inputTextCtrl = DcHwTypeTextCtrl(
    id: TextEditingController(),
    hwType: TextEditingController(),
  );

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcHwType.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcHwType.setNullToAllFields();
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
    dcHwTypePlusFilterField = DcHwTypePlusFilter(
      id: filterDcHwType.id,
      hwType: getNullIfStringEmpty(filterDcHwType.hwType),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcHwType =
        await Get.find<SelectDcHwTypeTable>()(dcHwTypePlusFilterField);
    failureOrDcHwType.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcHwTypeTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - HwType
  // Future selectAndFilterDataHwType({
  //   @required String searchItem,
  //   bool isNeedToRefreshDcHwType = true,
  //   int fetchLimit,
  // }) async {
  //   fetchLimit ??= masterPageDataFetchLimit;
  //   dcHwTypeFilter = DcHwTypeFilter(
  //     hwType: ifStringEmpty(searchItem),
  //     limits: fetchLimit,
  //     fieldToOrderBy: masterPageOrderField,
  //     orderByAscending: masterPageOrderAscending,
  //   );

  //   final failureOrDcHwType =
  //       await Get.find<SelectDcHwTypeTable>()(dcHwTypeFilter);
  //   failureOrDcHwType.fold((failure) {
  //     this.failureMessage = mapFailureToMessage(failure);
  //   }, (data) {
  //     this.dcHwTypeTable = data;
  //   });
  //   if (isNeedToRefreshDcHwType) {
  //     await selectAndFilterData();
  //   }
  // }

  @override
  Future insertData() async {
    dcHwType = DcHwType(
      hwType: inputDcHwType.hwType,
    );
    final fetchedData = await Get.find<InsertDcHwTypeTable>()(dcHwType);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwTypeTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - HwType
  // void inputHwTypeTextSelected(String value) {
  //   inputTextCtrl.hwType.text = value;
  //   inputDcHwType.hwType = value;
  //   getInputHwTypeSuggestionFromAPI(value);
  //   inputDcHwType.idHwType =
  //       dcHwTypeTable.dcHwType.firstWhere((element) => element.hwType == value).id;
  //   update();
  // }

  // Future<List<String>> getInputHwTypeSuggestionFromAPI(String value) async {
  //   inputDcHwType.hwType = value;
  //   List<String> match = [];
  //   await selectAndFilterDataHwType(
  //           searchItem: value, isNeedToRefreshDcHwType: true, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcHwTypeTable.dcHwType.forEach((element) {
  //       match.add(element.hwType);
  //     });
  //   });
  //   match.removeWhere((element) => element.isNull);
  //   return match;
  // }

  @override
  Future updateData() async {
    dcHwType = DcHwType(
      id: selectedDatasInTable[0].id,
      hwType: inputDcHwType.hwType,
    );
    final fetchedData = await Get.find<UpdateDcHwTypeTable>()(dcHwType);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwTypeTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcHwTypeTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwTypeTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcHwTypeTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwTypeTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcHwTypeTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwTypeTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcHwTypes = dcHwTypeTable;
    if (index >= dcHwTypes.dcHwType.length) return null;
    final DcHwType dcHwType = dcHwTypes.dcHwType[index];
    return DataRow.byIndex(
      index: index,
      selected: dcHwType.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcHwType.id.toString())),
        DataCell(Text(dcHwType.hwType ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcHwType.hwType = s;
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
  void onFilterHwTypeSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.hwType,
        typedValue: typedValue,
        filterValue: filterDcHwType.hwType,
        getFilterSuggesstion: getFilterHwTypeSuggestionsFromAPI);
  }

  // Dependencies - HwType

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterHwTypeSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHwType.hwType = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHwTypeTable.dcHwType.forEach((element) {
        match.add(element.hwType);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - hwType
  // Future<List<String>> getFilterHwTypeSuggestionsFromAPI(String value) async {
  //   // resetDataRelatedVariable();
  //   // masterPageDataFetchLimit = null;
  //   filterDcHwType.hwType = value;
  //   List<String> match = [];
  //   await selectAndFilterDataHwType(searchItem: value, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcHwTypeTable.dcHwType.forEach((element) {
  //       match.add(element.hwType);
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
    // final dcHwType = dcHwTypeTableToShowOnTable.dcHwType[index];
    final masterData = dcHwTypeTable.dcHwType[index];
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
    DcHwType val =
        dcHwTypeTable.dcHwType.singleWhere((element) => element.id == id);

    // data
    inputDcHwType.id = val.id;
    inputDcHwType.hwType = val.hwType;

    // text editing Controller
    inputTextCtrl.id.text = inputDcHwType.id.toString();
    inputTextCtrl.hwType.text = inputDcHwType.hwType;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
            inputDcHwType.hwType.isNull || inputDcHwType.hwType.isEmpty,
            'HwType (Basic Information)')
        // && validateInput(inputDcHwType.idHwType.isNull, 'HwType (Dependencies)')
        ;
  }
}
