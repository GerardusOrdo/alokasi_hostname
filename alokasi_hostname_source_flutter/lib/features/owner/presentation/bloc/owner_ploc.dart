import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../owner/domain/entities/owner_table.dart';
import '../../../owner/domain/usecases/select_owner_table.dart';
import '../../domain/entities/owner.dart';
import '../../domain/entities/owner_plus_filter.dart';
import '../../domain/entities/owner_table.dart';
import '../../domain/usecases/clone_owner_table.dart';
import '../../domain/usecases/delete_owner_table.dart';
import '../../domain/usecases/insert_owner_table.dart';
import '../../domain/usecases/select_owner_table.dart';
import '../../domain/usecases/set_delete_owner_table.dart';
import '../../domain/usecases/update_owner_table.dart';
import 'bloc_model/owner_data.dart';
import 'bloc_model/owner_text_ctrl.dart';

class OwnerPloc extends MasterPagePloc {
  // ! Data Related variable
  OwnerTable ownerTable;
  Owner owner;
  OwnerPlusFilter ownerPlusFilterField;
  List<Owner> selectedDatasInTable = [];

  // Data Dependencies Variable
  // OwnerTable ownerTable;
  // OwnerFilter ownerFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Owner';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  OwnerData filterOwner = OwnerData();
  OwnerTextCtrl filterTextCtrl = OwnerTextCtrl(
    id: TextEditingController(),
    owner: TextEditingController(), //basic
    email: TextEditingController(), //basic
    phone: TextEditingController(), //basic
    notes: TextEditingController(), //additional
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  OwnerData inputOwner = OwnerData();
  OwnerTextCtrl inputTextCtrl = OwnerTextCtrl(
    id: TextEditingController(),
    owner: TextEditingController(),
    email: TextEditingController(),
    phone: TextEditingController(),
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
    inputOwner.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterOwner.setNullToAllFields();
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
    ownerPlusFilterField = OwnerPlusFilter(
      id: filterOwner.id,
      owner: getNullIfStringEmpty(filterOwner.owner),
      email: getNullIfStringEmpty(filterOwner.email),
      phone: getNullIfStringEmpty(filterOwner.phone),
      notes: getNullIfStringEmpty(filterOwner.notes),
      deleted: filterOwner.deleted,
      // created: getNullIfStringEmpty(filterOwner.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrOwner =
        await Get.find<SelectOwnerTable>()(ownerPlusFilterField);
    failureOrOwner.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.ownerTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Owner
  // Future selectAndFilterDataOwner({
  //   @required String searchItem,
  //   bool isNeedToRefreshOwner = true,
  //   int fetchLimit,
  // }) async {
  //   fetchLimit ??= masterPageDataFetchLimit;
  //   ownerFilter = OwnerFilter(
  //     owner: ifStringEmpty(searchItem),
  //     limits: fetchLimit,
  //     fieldToOrderBy: masterPageOrderField,
  //     orderByAscending: masterPageOrderAscending,
  //   );

  //   final failureOrOwner =
  //       await Get.find<SelectOwnerTable>()(ownerFilter);
  //   failureOrOwner.fold((failure) {
  //     this.failureMessage = mapFailureToMessage(failure);
  //   }, (data) {
  //     this.ownerTable = data;
  //   });
  //   if (isNeedToRefreshOwner) {
  //     await selectAndFilterData();
  //   }
  // }

  @override
  Future insertData() async {
    owner = Owner(
      id: inputOwner.id,
      owner: inputOwner.owner,
      email: inputOwner.email,
      phone: inputOwner.phone,
      notes: inputOwner.notes,
    );
    final fetchedData = await Get.find<InsertOwnerTable>()(owner);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (ownerTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - Owner
  // void inputOwnerTextSelected(String value) {
  //   inputTextCtrl.owner.text = value;
  //   inputOwner.owner = value;
  //   getInputOwnerSuggestionFromAPI(value);
  //   inputOwner.idOwner =
  //       ownerTable.owner.firstWhere((element) => element.owner == value).id;
  //   update();
  // }

  // Future<List<String>> getInputOwnerSuggestionFromAPI(String value) async {
  //   inputOwner.owner = value;
  //   List<String> match = [];
  //   await selectAndFilterDataOwner(
  //           searchItem: value, isNeedToRefreshOwner: true, fetchLimit: 7)
  //       .whenComplete(() {
  //     ownerTable.owner.forEach((element) {
  //       match.add(element.owner);
  //     });
  //   });
  //   match.removeWhere((element) => element.isNull);
  //   return match;
  // }

  @override
  Future updateData() async {
    owner = Owner(
      id: selectedDatasInTable[0].id,
      owner: inputOwner.owner,
      email: inputOwner.email,
      phone: inputOwner.phone,
      notes: inputOwner.notes,
    );
    final fetchedData = await Get.find<UpdateOwnerTable>()(owner);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (ownerTable) => showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData = await Get.find<CloneOwnerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (ownerTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteOwnerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (ownerTable) => showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteOwnerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (ownerTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final owners = ownerTable;
    if (index >= owners.owner.length) return null;
    final Owner owner = owners.owner[index];
    return DataRow.byIndex(
      index: index,
      selected: owner.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(owner.id.toString())),
        DataCell(Text(owner.owner ?? '')),
        DataCell(Text(owner.email ?? '')),
        DataCell(Text(owner.phone ?? '')),
        DataCell(Text(owner.notes ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterOwner.owner = s;
      filterOwner.email = s;
      filterOwner.phone = s;
      filterOwner.notes = s;
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
        filterValue: filterOwner.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  void onFilterEmailSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.email,
        typedValue: typedValue,
        filterValue: filterOwner.email,
        getFilterSuggesstion: getFilterEmailSuggestionsFromAPI);
  }

  void onFilterPhoneSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.phone,
        typedValue: typedValue,
        filterValue: filterOwner.phone,
        getFilterSuggesstion: getFilterPhoneSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterOwner.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterOwner.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Owner

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterOwnerSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterOwner.owner = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      ownerTable.owner.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterEmailSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterOwner.email = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      ownerTable.owner.forEach((element) {
        match.add(element.email);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterPhoneSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterOwner.phone = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      ownerTable.owner.forEach((element) {
        match.add(element.phone);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterOwner.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      ownerTable.owner.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterOwner.created = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      ownerTable.owner.forEach((element) {
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
  //   filterOwner.owner = value;
  //   List<String> match = [];
  //   await selectAndFilterDataOwner(searchItem: value, fetchLimit: 7)
  //       .whenComplete(() {
  //     ownerTable.owner.forEach((element) {
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
    // final owner = ownerTableToShowOnTable.owner[index];
    final masterData = ownerTable.owner[index];
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
    Owner val = ownerTable.owner.singleWhere((element) => element.id == id);

    // data
    inputOwner.id = val.id;
    inputOwner.owner = val.owner;
    inputOwner.email = val.email;
    inputOwner.phone = val.phone;
    inputOwner.notes = val.notes;
    inputOwner.deleted = val.deleted;
    inputOwner.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputOwner.id.toString();
    inputTextCtrl.owner.text = inputOwner.owner;
    inputTextCtrl.email.text = inputOwner.email;
    inputTextCtrl.phone.text = inputOwner.phone;
    inputTextCtrl.notes.text = inputOwner.notes;
    inputTextCtrl.deleted.text = inputOwner.deleted.toString();
    inputTextCtrl.created.text = inputOwner.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(inputOwner.owner.isNull || inputOwner.owner.isEmpty,
            'Owner (Basic Information)')
        // && validateInput(inputOwner.idOwner.isNull, 'Owner (Dependencies)')
        ;
  }
}
