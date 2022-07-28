import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_owner/domain/entities/dc_owner_plus_filter.dart';
import '../../../dc_owner/domain/entities/dc_owner_table.dart';
import '../../../dc_owner/domain/usecases/select_dc_owner_table.dart';
import '../../../dc_owner/presentation/bloc/dc_owner_ploc.dart';
import '../../domain/entities/dc_site.dart';
import '../../domain/entities/dc_site_plus_filter.dart';
import '../../domain/entities/dc_site_table.dart';
import '../../domain/usecases/clone_dc_site_table.dart';
import '../../domain/usecases/delete_dc_site_table.dart';
import '../../domain/usecases/insert_dc_site_table.dart';
import '../../domain/usecases/select_dc_site_table.dart';
import '../../domain/usecases/set_delete_dc_site_table.dart';
import '../../domain/usecases/update_dc_site_table.dart';
import 'bloc_model/dc_site_data.dart';
import 'bloc_model/dc_site_text_ctrl.dart';

class DcSitePloc extends MasterPagePloc {
  // ! Data Related variable
  DcSiteTable dcSiteTable;
  DcSite dcSite;
  DcSitePlusFilter dcSitePlusFilterField;
  List<DcSite> selectedDatasInTable = [];

  // Data Dependencies Variable
  DcOwnerTable dcOwnerTable;
  DcOwnerPlusFilter dcOwnerPlusFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Site';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcSiteData filterDcSite = DcSiteData();
  DcSiteTextCtrl filterTextCtrl = DcSiteTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    dcSiteName: TextEditingController(),
    address: TextEditingController(),
    map: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcSiteData inputDcSite = DcSiteData();
  DcSiteTextCtrl inputTextCtrl = DcSiteTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    dcSiteName: TextEditingController(),
    address: TextEditingController(),
    map: TextEditingController(),
    width: TextEditingController(),
    height: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  DcOwnerPloc dcOwnerPloc = Get.find<DcOwnerPloc>();

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputDcSite.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcSite.setNullToAllFields();
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
    dcSitePlusFilterField = DcSitePlusFilter(
      id: filterDcSite.id,
      idOwner: filterDcSite.idOwner,
      owner: getNullIfStringEmpty(filterDcSite.owner),
      dcSiteName: getNullIfStringEmpty(filterDcSite.dcSiteName),
      address: getNullIfStringEmpty(filterDcSite.address),
      map: getNullIfStringEmpty(filterDcSite.map),
      width: filterDcSite.width,
      height: filterDcSite.height,
      image: getNullIfStringEmpty(filterDcSite.image),
      notes: getNullIfStringEmpty(filterDcSite.notes),
      deleted: filterDcSite.deleted,
      created: getNullIfStringEmpty(filterDcSite.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcSite =
        await Get.find<SelectDcSiteTable>()(dcSitePlusFilterField);
    failureOrDcSite.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcSiteTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Owner
  Future selectAndFilterDataOwner({
    @required String searchItem,
    bool isNeedToRefreshDcSite = true,
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
    if (isNeedToRefreshDcSite) {
      await selectAndFilterData();
    }
  }

  @override
  Future insertData() async {
    dcSite = DcSite(
      idOwner: inputDcSite.idOwner,
      dcSiteName: inputDcSite.dcSiteName,
      address: inputDcSite.address,
    );
    final fetchedData = await Get.find<InsertDcSiteTable>()(dcSite);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcSiteTable) => showSnackbarDataFetchSuccess('Data has been saved'));
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
    inputDcSite.owner = value['owner'];
    inputDcSite.idOwner = value['id'];
    getInputOwnerSuggestionFromAPI(value['owner']);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputOwnerSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataOwner(
            searchItem: value, isNeedToRefreshDcSite: false, fetchLimit: 7)
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

  @override
  Future updateData() async {
    dcSite = DcSite(
      id: selectedDatasInTable[0].id,
      idOwner: inputDcSite.idOwner,
      dcSiteName: inputDcSite.dcSiteName,
      address: inputDcSite.address,
    );
    final fetchedData = await Get.find<UpdateDcSiteTable>()(dcSite);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcSiteTable) => showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcSiteTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcSiteTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcSiteTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcSiteTable) => showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcSiteTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcSiteTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcSites = dcSiteTable;
    if (index >= dcSites.dcSite.length) return null;
    final DcSite dcSite = dcSites.dcSite[index];
    return DataRow.byIndex(
      index: index,
      selected: dcSite.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcSite.id.toString())),
        DataCell(Text(dcSite.owner ?? '')),
        DataCell(Text(dcSite.dcSiteName ?? '')),
        DataCell(Text(dcSite.address ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcSite.owner = s;
      filterDcSite.dcSiteName = s;
      filterDcSite.address = s;
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
  void onFilterDcSiteNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.dcSiteName,
        typedValue: typedValue,
        filterValue: filterDcSite.dcSiteName,
        getFilterSuggesstion: getFilterDcSiteNameSuggestionsFromAPI);
  }

  void onFilterAddressSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.address,
        typedValue: typedValue,
        filterValue: filterDcSite.address,
        getFilterSuggesstion: getFilterAddressSuggestionsFromAPI);
  }

  void onFilterMapSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.map,
        typedValue: typedValue,
        filterValue: filterDcSite.map,
        getFilterSuggesstion: getFilterMapSuggestionsFromAPI);
  }

  void onFilterImageSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.image,
        typedValue: typedValue,
        filterValue: filterDcSite.image,
        getFilterSuggesstion: getFilterImageSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterDcSite.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterDcSite.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Owner
  void onFilterOwnerSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.owner,
        typedValue: typedValue,
        filterValue: filterDcSite.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcSite.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcSiteTable.dcSite.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterDcSiteNameSuggestionsFromAPI(
      String query) async {
    masterPageDataFetchLimit = null;
    filterDcSite.dcSiteName = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcSiteTable.dcSite.forEach((element) {
        match.add(element.dcSiteName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterAddressSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcSite.address = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcSiteTable.dcSite.forEach((element) {
        match.add(element.address);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterMapSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcSite.map = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcSiteTable.dcSite.forEach((element) {
        match.add(element.map);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterImageSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcSite.image = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcSiteTable.dcSite.forEach((element) {
        match.add(element.image);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcSite.notes = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcSiteTable.dcSite.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcSite.created = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcSiteTable.dcSite.forEach((element) {
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
    filterDcSite.owner = value;
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

  // ! ============== Fungsi Select checkbox Tabel ==============
  void onSelectedDataChanged({
    @required bool value,
    @required int index,
  }) {
    // final dcOwner = dcOwnerTableToShowOnTable.dcOwner[index];
    final masterData = dcSiteTable.dcSite[index];
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
    DcSite val = dcSiteTable.dcSite.singleWhere((element) => element.id == id);

    // data
    inputDcSite.id = val.id;
    inputDcSite.idOwner = val.idOwner;
    inputDcSite.owner = val.owner;
    inputDcSite.dcSiteName = val.dcSiteName;
    inputDcSite.address = val.address;
    inputDcSite.map = val.map;
    inputDcSite.width = val.width;
    inputDcSite.height = val.height;
    inputDcSite.image = val.image;
    inputDcSite.notes = val.notes;
    inputDcSite.deleted = val.deleted;
    inputDcSite.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputDcSite.id.toString();
    inputTextCtrl.idOwner.text = inputDcSite.idOwner.toString();
    inputTextCtrl.owner.text = inputDcSite.owner;
    inputTextCtrl.dcSiteName.text = inputDcSite.dcSiteName;
    inputTextCtrl.address.text = inputDcSite.address;
    inputTextCtrl.map.text = inputDcSite.map;
    inputTextCtrl.width.text = inputDcSite.width.toString();
    inputTextCtrl.height.text = inputDcSite.height.toString();
    inputTextCtrl.image.text = inputDcSite.image;
    inputTextCtrl.notes.text = inputDcSite.notes;
    inputTextCtrl.deleted.text = inputDcSite.deleted.toString();
    inputTextCtrl.created.text = inputDcSite.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
            inputDcSite.dcSiteName.isNull || inputDcSite.dcSiteName.isEmpty,
            'Site (Basic Information)')
        // && validateInput(inputDcSite.idOwner.isNull, 'Owner (Dependencies)')
        ;
  }
}
