import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_hw_model/domain/entities/dc_hw_model_table.dart';
import '../../../dc_hw_model/domain/usecases/select_dc_hw_model_table.dart';
import '../../domain/entities/dc_hw_model.dart';
import '../../domain/entities/dc_hw_model_plus_filter.dart';
import '../../domain/entities/dc_hw_model_table.dart';
import '../../domain/usecases/clone_dc_hw_model_table.dart';
import '../../domain/usecases/delete_dc_hw_model_table.dart';
import '../../domain/usecases/insert_dc_hw_model_table.dart';
import '../../domain/usecases/select_dc_hw_model_table.dart';
import '../../domain/usecases/set_delete_dc_hw_model_table.dart';
import '../../domain/usecases/update_dc_hw_model_table.dart';
import 'bloc_model/dc_hw_model_data.dart';
import 'bloc_model/dc_hw_model_text_ctrl.dart';

class DcHwModelPloc extends MasterPagePloc {
  // ! Data Related variable
  DcHwModelTable dcHwModelTable;
  DcHwModel dcHwModel;
  DcHwModelPlusFilter dcHwModelPlusFilterField;
  List<DcHwModel> selectedDatasInTable = [];

  // Data Dependencies Variable
  // DcHwModelTable dcHwModelTable;
  // DcHwModelFilter dcHwModelFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Hardware Model';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcHwModelData filterDcHwModel = DcHwModelData();
  DcHwModelTextCtrl filterTextCtrl = DcHwModelTextCtrl(
    id: TextEditingController(),
    hwModel: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcHwModelData inputDcHwModel = DcHwModelData();
  DcHwModelTextCtrl inputTextCtrl = DcHwModelTextCtrl(
    id: TextEditingController(),
    hwModel: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcHwModel.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcHwModel.setNullToAllFields();
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
    dcHwModelPlusFilterField = DcHwModelPlusFilter(
      id: filterDcHwModel.id,
      hwModel: getNullIfStringEmpty(filterDcHwModel.hwModel),
      image: getNullIfStringEmpty(filterDcHwModel.image),
      notes: getNullIfStringEmpty(filterDcHwModel.notes),
      deleted: filterDcHwModel.deleted,
      created: getNullIfStringEmpty(filterDcHwModel.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcHwModel =
        await Get.find<SelectDcHwModelTable>()(dcHwModelPlusFilterField);
    failureOrDcHwModel.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcHwModelTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - HwModel
  // Future selectAndFilterDataHwModel({
  //   @required String searchItem,
  //   bool isNeedToRefreshDcHwModel = true,
  //   int fetchLimit,
  // }) async {
  //   fetchLimit ??= masterPageDataFetchLimit;
  //   dcHwModelFilter = DcHwModelFilter(
  //     hwModel: ifStringEmpty(searchItem),
  //     limits: fetchLimit,
  //     fieldToOrderBy: masterPageOrderField,
  //     orderByAscending: masterPageOrderAscending,
  //   );

  //   final failureOrDcHwModel =
  //       await Get.find<SelectDcHwModelTable>()(dcHwModelFilter);
  //   failureOrDcHwModel.fold((failure) {
  //     this.failureMessage = mapFailureToMessage(failure);
  //   }, (data) {
  //     this.dcHwModelTable = data;
  //   });
  //   if (isNeedToRefreshDcHwModel) {
  //     await selectAndFilterData();
  //   }
  // }

  @override
  Future insertData() async {
    dcHwModel = DcHwModel(
      hwModel: inputDcHwModel.hwModel,
      // image: inputDcHwModel.image,
      // notes: inputDcHwModel.notes,
      // deleted: inputDcHwModel.deleted,
      // created: inputDcHwModel.created,
    );
    final fetchedData = await Get.find<InsertDcHwModelTable>()(dcHwModel);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwModelTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - HwModel
  // void inputHwModelTextSelected(String value) {
  //   inputTextCtrl.hwModel.text = value;
  //   inputDcHwModel.hwModel = value;
  //   getInputHwModelSuggestionFromAPI(value);
  //   inputDcHwModel.idHwModel =
  //       dcHwModelTable.dcHwModel.firstWhere((element) => element.hwModel == value).id;
  //   update();
  // }

  // Future<List<String>> getInputHwModelSuggestionFromAPI(String value) async {
  //   inputDcHwModel.hwModel = value;
  //   List<String> match = [];
  //   await selectAndFilterDataHwModel(
  //           searchItem: value, isNeedToRefreshDcHwModel: true, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcHwModelTable.dcHwModel.forEach((element) {
  //       match.add(element.hwModel);
  //     });
  //   });
  //   match.removeWhere((element) => element.isNull);
  //   return match;
  // }

  @override
  Future updateData() async {
    dcHwModel = DcHwModel(
      id: selectedDatasInTable[0].id,
      hwModel: inputDcHwModel.hwModel,
    );
    final fetchedData = await Get.find<UpdateDcHwModelTable>()(dcHwModel);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwModelTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcHwModelTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwModelTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcHwModelTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwModelTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcHwModelTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcHwModelTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcHwModels = dcHwModelTable;
    if (index >= dcHwModels.dcHwModel.length) return null;
    final DcHwModel dcHwModel = dcHwModels.dcHwModel[index];
    return DataRow.byIndex(
      index: index,
      selected: dcHwModel.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcHwModel.id.toString())),
        DataCell(Text(dcHwModel.hwModel ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcHwModel.hwModel = s;
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
  void onFilterHwModelSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.hwModel,
        typedValue: typedValue,
        filterValue: filterDcHwModel.hwModel,
        getFilterSuggesstion: getFilterHwModelSuggestionsFromAPI);
  }

  void onFilterImageSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.image,
        typedValue: typedValue,
        filterValue: filterDcHwModel.image,
        getFilterSuggesstion: getFilterImageSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterDcHwModel.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterDcHwModel.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - HwModel

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterHwModelSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHwModel.hwModel = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHwModelTable.dcHwModel.forEach((element) {
        match.add(element.hwModel);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterImageSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHwModel.image = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHwModelTable.dcHwModel.forEach((element) {
        match.add(element.image);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHwModel.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHwModelTable.dcHwModel.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcHwModel.created = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcHwModelTable.dcHwModel.forEach((element) {
        match.add(element.created);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - hwModel
  // Future<List<String>> getFilterHwModelSuggestionsFromAPI(String value) async {
  //   // resetDataRelatedVariable();
  //   // masterPageDataFetchLimit = null;
  //   filterDcHwModel.hwModel = value;
  //   List<String> match = [];
  //   await selectAndFilterDataHwModel(searchItem: value, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcHwModelTable.dcHwModel.forEach((element) {
  //       match.add(element.hwModel);
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
    // final dcHwModel = dcHwModelTableToShowOnTable.dcHwModel[index];
    final masterData = dcHwModelTable.dcHwModel[index];
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
    DcHwModel val =
        dcHwModelTable.dcHwModel.singleWhere((element) => element.id == id);

    // data
    inputDcHwModel.id = val.id;
    inputDcHwModel.hwModel = val.hwModel;
    inputDcHwModel.image = val.image;
    inputDcHwModel.notes = val.notes;
    inputDcHwModel.deleted = val.deleted;
    inputDcHwModel.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputDcHwModel.id.toString();
    inputTextCtrl.hwModel.text = inputDcHwModel.hwModel;
    inputTextCtrl.image.text = inputDcHwModel.image;
    inputTextCtrl.notes.text = inputDcHwModel.notes;
    inputTextCtrl.deleted.text = inputDcHwModel.deleted.toString();
    inputTextCtrl.created.text = inputDcHwModel.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
            inputDcHwModel.hwModel.isNull || inputDcHwModel.hwModel.isEmpty,
            'HwModel (Basic Information)')
        // && validateInput(inputDcHwModel.idHwModel.isNull, 'HwModel (Dependencies)')
        ;
  }
}
