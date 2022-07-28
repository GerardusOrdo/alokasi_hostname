import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_owner/domain/entities/dc_owner_table.dart';
import '../../../dc_owner/domain/usecases/select_dc_owner_table.dart';
import '../../domain/entities/dc_owner.dart';
import '../../domain/entities/dc_owner_plus_filter.dart';
import '../../domain/entities/dc_owner_table.dart';
import '../../domain/usecases/clone_dc_owner_table.dart';
import '../../domain/usecases/delete_dc_owner_table.dart';
import '../../domain/usecases/insert_dc_owner_table.dart';
import '../../domain/usecases/select_dc_owner_table.dart';
import '../../domain/usecases/set_delete_dc_owner_table.dart';
import '../../domain/usecases/update_dc_owner_table.dart';
import 'bloc_model/dc_owner_data.dart';
import 'bloc_model/dc_owner_text_ctrl.dart';

class DcOwnerPloc extends MasterPagePloc {
  // ! Data Related variable
  DcOwnerTable dcOwnerTable;
  DcOwner dcOwner;
  DcOwnerPlusFilter dcOwnerPlusFilterField;
  List<DcOwner> selectedDatasInTable = [];

  // Data Dependencies Variable
  // DcOwnerTable dcOwnerTable;
  // DcOwnerFilter dcOwnerFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Owner';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcOwnerData filterDcOwner = DcOwnerData();
  DcOwnerTextCtrl filterTextCtrl = DcOwnerTextCtrl(
    id: TextEditingController(),
    owner: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcOwnerData inputDcOwner = DcOwnerData();
  DcOwnerTextCtrl inputTextCtrl = DcOwnerTextCtrl(
    id: TextEditingController(),
    owner: TextEditingController(),
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
    inputDcOwner.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcOwner.setNullToAllFields();
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
    dcOwnerPlusFilterField = DcOwnerPlusFilter(
      id: filterDcOwner.id,
      owner: getNullIfStringEmpty(filterDcOwner.owner),
      image: getNullIfStringEmpty(filterDcOwner.image),
      notes: getNullIfStringEmpty(filterDcOwner.notes),
      deleted: filterDcOwner.deleted,
      created: getNullIfStringEmpty(filterDcOwner.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcOwner =
        await Get.find<SelectDcOwnerTable>()(dcOwnerPlusFilterField);
    failureOrDcOwner.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcOwnerTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Owner
  // Future selectAndFilterDataOwner({
  //   @required String searchItem,
  //   bool isNeedToRefreshDcOwner = true,
  //   int fetchLimit,
  // }) async {
  //   fetchLimit ??= masterPageDataFetchLimit;
  //   dcOwnerFilter = DcOwnerFilter(
  //     owner: ifStringEmpty(searchItem),
  //     limits: fetchLimit,
  //     fieldToOrderBy: masterPageOrderField,
  //     orderByAscending: masterPageOrderAscending,
  //   );

  //   final failureOrDcOwner =
  //       await Get.find<SelectDcOwnerTable>()(dcOwnerFilter);
  //   failureOrDcOwner.fold((failure) {
  //     this.failureMessage = mapFailureToMessage(failure);
  //   }, (data) {
  //     this.dcOwnerTable = data;
  //   });
  //   if (isNeedToRefreshDcOwner) {
  //     await selectAndFilterData();
  //   }
  // }

  @override
  Future<int> insertData() async {
    dcOwner = DcOwner(
      owner: inputDcOwner.owner,
    );
    final fetchedData = await Get.find<InsertDcOwnerTable>()(dcOwner);
    fetchedData.fold((failure) {
      showSnackbarDataFetchFailed(getMessageFromFailure(failure));
      return -1;
    }, (dcOwnerTable) {
      showSnackbarDataFetchSuccess('Data has been saved');
      return dcOwnerTable[0];
    });
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - Owner
  // void inputOwnerTextSelected(String value) {
  //   inputTextCtrl.owner.text = value;
  //   inputDcOwner.owner = value;
  //   getInputOwnerSuggestionFromAPI(value);
  //   inputDcOwner.idOwner =
  //       dcOwnerTable.dcOwner.firstWhere((element) => element.owner == value).id;
  //   update();
  // }

  // Future<List<String>> getInputOwnerSuggestionFromAPI(String value) async {
  //   inputDcOwner.owner = value;
  //   List<String> match = [];
  //   await selectAndFilterDataOwner(
  //           searchItem: value, isNeedToRefreshDcOwner: true, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcOwnerTable.dcOwner.forEach((element) {
  //       match.add(element.owner);
  //     });
  //   });
  //   match.removeWhere((element) => element.isNull);
  //   return match;
  // }

  @override
  Future updateData() async {
    dcOwner = DcOwner(
      id: selectedDatasInTable[0].id,
      owner: inputDcOwner.owner,
    );
    final fetchedData = await Get.find<UpdateDcOwnerTable>()(dcOwner);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcOwnerTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcOwnerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcOwnerTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcOwnerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcOwnerTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcOwnerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcOwnerTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcOwners = dcOwnerTable;
    if (index >= dcOwners.dcOwner.length) return null;
    final DcOwner dcOwner = dcOwners.dcOwner[index];
    return DataRow.byIndex(
      index: index,
      selected: dcOwner.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcOwner.id.toString())),
        DataCell(Text(dcOwner.owner ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcOwner.owner = s;
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
  void onFilterOwnerSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.owner,
        typedValue: typedValue,
        filterValue: filterDcOwner.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  void onFilterImageSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.image,
        typedValue: typedValue,
        filterValue: filterDcOwner.image,
        getFilterSuggesstion: getFilterImageSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterDcOwner.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterDcOwner.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Owner

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcOwner.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcOwnerTable.dcOwner.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcOwner.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcOwnerTable.dcOwner.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterImageSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcOwner.image = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcOwnerTable.dcOwner.forEach((element) {
        match.add(element.image);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcOwner.notes = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcOwnerTable.dcOwner.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcOwner.created = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcOwnerTable.dcOwner.forEach((element) {
        match.add(element.created);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - owner
  // Future<List<String>> getFilterOwnerSuggestionsFromAPI(String value) async {
  //   // resetDataRelatedVariable();
  //   // masterPageDataFetchLimit = null;
  //   filterDcOwner.owner = value;
  //   List<String> match = [];
  //   await selectAndFilterDataOwner(searchItem: value, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcOwnerTable.dcOwner.forEach((element) {
  //       match.add(element.owner);
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
    // final dcOwner = dcOwnerTableToShowOnTable.dcOwner[index];
    final masterData = dcOwnerTable.dcOwner[index];
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
    DcOwner val =
        dcOwnerTable.dcOwner.singleWhere((element) => element.id == id);

    // data
    inputDcOwner.id = val.id;
    inputDcOwner.owner = val.owner;
    inputDcOwner.image = val.image;
    inputDcOwner.notes = val.notes;
    inputDcOwner.deleted = val.deleted;
    inputDcOwner.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputDcOwner.id.toString();
    inputTextCtrl.owner.text = inputDcOwner.owner;
    inputTextCtrl.image.text = inputDcOwner.image;
    inputTextCtrl.notes.text = inputDcOwner.notes;
    inputTextCtrl.deleted.text = inputDcOwner.deleted.toString();
    inputTextCtrl.created.text = inputDcOwner.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
            inputDcOwner.owner.isNull || inputDcOwner.owner.isEmpty,
            'Owner (Basic Information)')
        // && validateInput(inputDcOwner.idOwner.isNull, 'Owner (Dependencies)')
        ;
  }
}
