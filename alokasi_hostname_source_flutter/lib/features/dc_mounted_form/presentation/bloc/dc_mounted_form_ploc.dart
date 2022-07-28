import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_mounted_form/domain/entities/dc_mounted_form_table.dart';
import '../../../dc_mounted_form/domain/usecases/select_dc_mounted_form_table.dart';
import '../../domain/entities/dc_mounted_form.dart';
import '../../domain/entities/dc_mounted_form_plus_filter.dart';
import '../../domain/entities/dc_mounted_form_table.dart';
import '../../domain/usecases/clone_dc_mounted_form_table.dart';
import '../../domain/usecases/delete_dc_mounted_form_table.dart';
import '../../domain/usecases/insert_dc_mounted_form_table.dart';
import '../../domain/usecases/select_dc_mounted_form_table.dart';
import '../../domain/usecases/set_delete_dc_mounted_form_table.dart';
import '../../domain/usecases/update_dc_mounted_form_table.dart';
import 'bloc_model/dc_mounted_form_data.dart';
import 'bloc_model/dc_mounted_form_text_ctrl.dart';

class DcMountedFormPloc extends MasterPagePloc {
  // ! Data Related variable
  DcMountedFormTable dcMountedFormTable;
  DcMountedForm dcMountedForm;
  DcMountedFormPlusFilter dcMountedFormPlusFilterField;
  List<DcMountedForm> selectedDatasInTable = [];

  // Data Dependencies Variable
  // DcMountedFormTable dcMountedFormTable;
  // DcMountedFormFilter dcMountedFormFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Mounted Form';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcMountedFormData filterDcMountedForm = DcMountedFormData();
  DcMountedFormTextCtrl filterTextCtrl = DcMountedFormTextCtrl(
    id: TextEditingController(),
    mountedForm: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcMountedFormData inputDcMountedForm = DcMountedFormData();
  DcMountedFormTextCtrl inputTextCtrl = DcMountedFormTextCtrl(
    id: TextEditingController(),
    mountedForm: TextEditingController(),
  );

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcMountedForm.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcMountedForm.setNullToAllFields();
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
    dcMountedFormPlusFilterField = DcMountedFormPlusFilter(
      id: filterDcMountedForm.id,
      mountedForm: getNullIfStringEmpty(filterDcMountedForm.mountedForm),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcMountedForm = await Get.find<SelectDcMountedFormTable>()(
        dcMountedFormPlusFilterField);
    failureOrDcMountedForm.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcMountedFormTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - MountedForm
  // Future selectAndFilterDataMountedForm({
  //   @required String searchItem,
  //   bool isNeedToRefreshDcMountedForm = true,
  //   int fetchLimit,
  // }) async {
  //   fetchLimit ??= masterPageDataFetchLimit;
  //   dcMountedFormFilter = DcMountedFormFilter(
  //     mountedForm: ifStringEmpty(searchItem),
  //     limits: fetchLimit,
  //     fieldToOrderBy: masterPageOrderField,
  //     orderByAscending: masterPageOrderAscending,
  //   );

  //   final failureOrDcMountedForm =
  //       await Get.find<SelectDcMountedFormTable>()(dcMountedFormFilter);
  //   failureOrDcMountedForm.fold((failure) {
  //     this.failureMessage = mapFailureToMessage(failure);
  //   }, (data) {
  //     this.dcMountedFormTable = data;
  //   });
  //   if (isNeedToRefreshDcMountedForm) {
  //     await selectAndFilterData();
  //   }
  // }

  @override
  Future insertData() async {
    dcMountedForm = DcMountedForm(
      mountedForm: inputDcMountedForm.mountedForm,
    );
    final fetchedData =
        await Get.find<InsertDcMountedFormTable>()(dcMountedForm);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcMountedFormTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - MountedForm
  // void inputMountedFormTextSelected(String value) {
  //   inputTextCtrl.mountedForm.text = value;
  //   inputDcMountedForm.mountedForm = value;
  //   getInputMountedFormSuggestionFromAPI(value);
  //   inputDcMountedForm.idMountedForm =
  //       dcMountedFormTable.dcMountedForm.firstWhere((element) => element.mountedForm == value).id;
  //   update();
  // }

  // Future<List<String>> getInputMountedFormSuggestionFromAPI(String value) async {
  //   inputDcMountedForm.mountedForm = value;
  //   List<String> match = [];
  //   await selectAndFilterDataMountedForm(
  //           searchItem: value, isNeedToRefreshDcMountedForm: true, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcMountedFormTable.dcMountedForm.forEach((element) {
  //       match.add(element.mountedForm);
  //     });
  //   });
  //   match.removeWhere((element) => element.isNull);
  //   return match;
  // }

  @override
  Future updateData() async {
    dcMountedForm = DcMountedForm(
      id: selectedDatasInTable[0].id,
      mountedForm: inputDcMountedForm.mountedForm,
    );
    final fetchedData =
        await Get.find<UpdateDcMountedFormTable>()(dcMountedForm);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcMountedFormTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcMountedFormTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcMountedFormTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcMountedFormTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcMountedFormTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcMountedFormTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcMountedFormTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcMountedForms = dcMountedFormTable;
    if (index >= dcMountedForms.dcMountedForm.length) return null;
    final DcMountedForm dcMountedForm = dcMountedForms.dcMountedForm[index];
    return DataRow.byIndex(
      index: index,
      selected: dcMountedForm.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcMountedForm.id.toString())),
        DataCell(Text(dcMountedForm.mountedForm ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcMountedForm.mountedForm = s;
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
  void onFilterMountedFormSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.mountedForm,
        typedValue: typedValue,
        filterValue: filterDcMountedForm.mountedForm,
        getFilterSuggesstion: getFilterMountedFormSuggestionsFromAPI);
  }

  // Dependencies - MountedForm

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterMountedFormSuggestionsFromAPI(
      String value) async {
    masterPageDataFetchLimit = null;
    filterDcMountedForm.mountedForm = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcMountedFormTable.dcMountedForm.forEach((element) {
        match.add(element.mountedForm);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - mountedForm
  // Future<List<String>> getFilterMountedFormSuggestionsFromAPI(String value) async {
  //   // resetDataRelatedVariable();
  //   // masterPageDataFetchLimit = null;
  //   filterDcMountedForm.mountedForm = value;
  //   List<String> match = [];
  //   await selectAndFilterDataMountedForm(searchItem: value, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcMountedFormTable.dcMountedForm.forEach((element) {
  //       match.add(element.mountedForm);
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
    // final dcMountedForm = dcMountedFormTableToShowOnTable.dcMountedForm[index];
    final masterData = dcMountedFormTable.dcMountedForm[index];
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
    DcMountedForm val = dcMountedFormTable.dcMountedForm
        .singleWhere((element) => element.id == id);

    // data
    inputDcMountedForm.id = val.id;
    inputDcMountedForm.mountedForm = val.mountedForm;

    // text editing Controller
    inputTextCtrl.id.text = inputDcMountedForm.id.toString();
    inputTextCtrl.mountedForm.text = inputDcMountedForm.mountedForm;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
            inputDcMountedForm.mountedForm.isNull ||
                inputDcMountedForm.mountedForm.isEmpty,
            'MountedForm (Basic Information)')
        // && validateInput(inputDcMountedForm.idMountedForm.isNull, 'MountedForm (Dependencies)')
        ;
  }
}
