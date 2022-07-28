import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../dc_brand/domain/entities/dc_brand_table.dart';
import '../../../dc_brand/domain/usecases/select_dc_brand_table.dart';
import '../../domain/entities/dc_brand.dart';
import '../../domain/entities/dc_brand_plus_filter.dart';
import '../../domain/entities/dc_brand_table.dart';
import '../../domain/usecases/clone_dc_brand_table.dart';
import '../../domain/usecases/delete_dc_brand_table.dart';
import '../../domain/usecases/insert_dc_brand_table.dart';
import '../../domain/usecases/select_dc_brand_table.dart';
import '../../domain/usecases/set_delete_dc_brand_table.dart';
import '../../domain/usecases/update_dc_brand_table.dart';
import 'bloc_model/dc_brand_data.dart';
import 'bloc_model/dc_brand_text_ctrl.dart';

class DcBrandPloc extends MasterPagePloc {
  // ! Data Related variable
  DcBrandTable dcBrandTable;
  DcBrand dcBrand;
  DcBrandPlusFilter dcBrandPlusFilterField;
  List<DcBrand> selectedDatasInTable = [];

  // Data Dependencies Variable
  // DcBrandTable dcBrandTable;
  // DcBrandFilter dcBrandFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Brand';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  DcBrandData filterDcBrand = DcBrandData();
  DcBrandTextCtrl filterTextCtrl = DcBrandTextCtrl(
    id: TextEditingController(),
    brand: TextEditingController(),
    image: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  DcBrandData inputDcBrand = DcBrandData();
  DcBrandTextCtrl inputTextCtrl = DcBrandTextCtrl(
    id: TextEditingController(),
    brand: TextEditingController(),
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
    inputDcBrand.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterDcBrand.setNullToAllFields();
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
    dcBrandPlusFilterField = DcBrandPlusFilter(
      id: filterDcBrand.id,
      brand: getNullIfStringEmpty(filterDcBrand.brand),
      image: getNullIfStringEmpty(filterDcBrand.image),
      notes: getNullIfStringEmpty(filterDcBrand.notes),
      deleted: filterDcBrand.deleted,
      created: getNullIfStringEmpty(filterDcBrand.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrDcBrand =
        await Get.find<SelectDcBrandTable>()(dcBrandPlusFilterField);
    failureOrDcBrand.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.dcBrandTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Brand
  // Future selectAndFilterDataBrand({
  //   @required String searchItem,
  //   bool isNeedToRefreshDcBrand = true,
  //   int fetchLimit,
  // }) async {
  //   fetchLimit ??= masterPageDataFetchLimit;
  //   dcBrandFilter = DcBrandFilter(
  //     brand: ifStringEmpty(searchItem),
  //     limits: fetchLimit,
  //     fieldToOrderBy: masterPageOrderField,
  //     orderByAscending: masterPageOrderAscending,
  //   );

  //   final failureOrDcBrand =
  //       await Get.find<SelectDcBrandTable>()(dcBrandFilter);
  //   failureOrDcBrand.fold((failure) {
  //     this.failureMessage = mapFailureToMessage(failure);
  //   }, (data) {
  //     this.dcBrandTable = data;
  //   });
  //   if (isNeedToRefreshDcBrand) {
  //     await selectAndFilterData();
  //   }
  // }

  @override
  Future insertData() async {
    dcBrand = DcBrand(
      brand: inputDcBrand.brand,
      // image: inputDcBrand.image,
      // notes: inputDcBrand.notes,
      // deleted: inputDcBrand.deleted,
      // created: inputDcBrand.created,
    );
    final fetchedData = await Get.find<InsertDcBrandTable>()(dcBrand);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcBrandTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - Brand
  // void inputBrandTextSelected(String value) {
  //   inputTextCtrl.brand.text = value;
  //   inputDcBrand.brand = value;
  //   getInputBrandSuggestionFromAPI(value);
  //   inputDcBrand.idBrand =
  //       dcBrandTable.dcBrand.firstWhere((element) => element.brand == value).id;
  //   update();
  // }

  // Future<List<String>> getInputBrandSuggestionFromAPI(String value) async {
  //   inputDcBrand.brand = value;
  //   List<String> match = [];
  //   await selectAndFilterDataBrand(
  //           searchItem: value, isNeedToRefreshDcBrand: true, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcBrandTable.dcBrand.forEach((element) {
  //       match.add(element.brand);
  //     });
  //   });
  //   match.removeWhere((element) => element.isNull);
  //   return match;
  // }

  @override
  Future updateData() async {
    dcBrand = DcBrand(
      id: selectedDatasInTable[0].id,
      brand: inputDcBrand.brand,
    );
    final fetchedData = await Get.find<UpdateDcBrandTable>()(dcBrand);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcBrandTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneDcBrandTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcBrandTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteDcBrandTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcBrandTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteDcBrandTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (dcBrandTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final dcBrands = dcBrandTable;
    if (index >= dcBrands.dcBrand.length) return null;
    final DcBrand dcBrand = dcBrands.dcBrand[index];
    return DataRow.byIndex(
      index: index,
      selected: dcBrand.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(dcBrand.id.toString())),
        DataCell(Text(dcBrand.brand ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterDcBrand.brand = s;
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
  void onFilterBrandSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.brand,
        typedValue: typedValue,
        filterValue: filterDcBrand.brand,
        getFilterSuggesstion: getFilterBrandSuggestionsFromAPI);
  }

  void onFilterImageSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.image,
        typedValue: typedValue,
        filterValue: filterDcBrand.image,
        getFilterSuggesstion: getFilterImageSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterDcBrand.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterDcBrand.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Brand

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdBrandSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterDcBrand.brand = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcBrandTable.dcBrand.forEach((element) {
        match.add(element.brand);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterBrandSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcBrand.brand = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcBrandTable.dcBrand.forEach((element) {
        match.add(element.brand);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterImageSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcBrand.image = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcBrandTable.dcBrand.forEach((element) {
        match.add(element.image);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcBrand.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcBrandTable.dcBrand.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterDcBrand.created = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      dcBrandTable.dcBrand.forEach((element) {
        match.add(element.created);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - brand
  // Future<List<String>> getFilterBrandSuggestionsFromAPI(String value) async {
  //   // resetDataRelatedVariable();
  //   // masterPageDataFetchLimit = null;
  //   filterDcBrand.brand = value;
  //   List<String> match = [];
  //   await selectAndFilterDataBrand(searchItem: value, fetchLimit: 7)
  //       .whenComplete(() {
  //     dcBrandTable.dcBrand.forEach((element) {
  //       match.add(element.brand);
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
    // final dcBrand = dcBrandTableToShowOnTable.dcBrand[index];
    final masterData = dcBrandTable.dcBrand[index];
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
    DcBrand val =
        dcBrandTable.dcBrand.singleWhere((element) => element.id == id);

    // data
    inputDcBrand.id = val.id;
    inputDcBrand.brand = val.brand;
    inputDcBrand.image = val.image;
    inputDcBrand.notes = val.notes;
    inputDcBrand.deleted = val.deleted;
    inputDcBrand.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputDcBrand.id.toString();
    inputTextCtrl.brand.text = inputDcBrand.brand;
    inputTextCtrl.image.text = inputDcBrand.image;
    inputTextCtrl.notes.text = inputDcBrand.notes;
    inputTextCtrl.deleted.text = inputDcBrand.deleted.toString();
    inputTextCtrl.created.text = inputDcBrand.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
            inputDcBrand.brand.isNull || inputDcBrand.brand.isEmpty,
            'Brand (Basic Information)')
        // && validateInput(inputDcBrand.idBrand.isNull, 'Brand (Dependencies)')
        ;
  }
}
