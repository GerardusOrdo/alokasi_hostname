import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../error/failures.dart';
import '../../../../helper/debouncer.dart';
import '../../../../helper/helper.dart';
import '../../domain/entities/master_data.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

abstract class MasterPagePloc extends GetxController {
  String failureMessage = 'dafult error message';

  // ! Data Related variable
  bool isDataFetchSuccess = false;

  // ! UI variable
  // ! -> Datatable Widget
  int rowsPerPage = 10;
  int sortColumnIndex = 0;
  bool sortAscending = false;
  int selectedDataCount = 0;

  // ! Utility
  Debouncer debouncer = Debouncer(milliseconds: 300);

  // ! -> AppBar & Search Functionality
  // # UI variable
  String pageName = 'Master Page';
  bool inSearchMode = false;
  bool isBtnCloseSearchVisible = false;
  TextEditingController appBarSearchTextEditingController =
      TextEditingController();

  // ! -> Filter Functionality
  String masterPageOrderField = "id";
  bool masterPageOrderAscending = false;
  int masterPageDataFetchOffset = 0;
  int masterPageDataFetchLimit = 50;

  // ! -> Input page
  List<GlobalKey<FormState>> inputPageFormKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  int currentInputStep = 0;
  bool inputStepComplete = false;
  GlobalKey<FormState> formKeyInputBasic = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyInputDependencies = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyInputAdditional = GlobalKey<FormState>();

  String filePath = '';
  int fileLength = 0;
  String fileString = '';

  // ! -> Bottom Navigation
  int bottomNavigationIndexPage = 0;

  List<DropdownMenuItem<EnumLogicalOperator>> dropdownFilterList = [
    DropdownMenuItem(
      child: Text('And'),
      value: EnumLogicalOperator.and,
    ),
    DropdownMenuItem(
      child: Text('Or'),
      value: EnumLogicalOperator.or,
    )
  ];
  EnumLogicalOperator dataFilterSelection = EnumLogicalOperator.and;

  @override
  void onInit() {
    resetFilteredAndRefreshData();
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  // ! ============== Reset data related variable ==============
  void resetData(List<Object> datas) {
    datas.forEach((element) {
      if (element is String) {
        element = '';
      } else if (element is int) {
        element = 0;
      } else if (element is bool) {
        element = false;
      }
    });
  }

  String getNullIfStringEmpty(String value) {
    if (value == '')
      return null;
    else
      return value;
  }

  void resetToDefaultDataTableParameter() {
    masterPageOrderField = "id";
    masterPageOrderAscending = false;
    masterPageDataFetchOffset = 0;
    masterPageDataFetchLimit = 50;
    currentInputStep = 0;
    dataFilterSelection = EnumLogicalOperator.and;
  }

  // ! ============== Select & Filter Data ==============
  Future selectAndFilterData({
    EnumLogicalOperator dataFilterByLogicalOperator = EnumLogicalOperator.and,
    int fetchLimit,
  }) async {}

  // ! ============== Fungsi Insert Data ==============
  Future insertData() async {}

  // ! ============== Fungsi Update Data (single update) ==============
  Future updateData() async {}

  // ! ============== Fungsi Clone Data ==============
  Future cloneData() async {}

  // ! ============== Fungsi Set Delete Data ==============
  Future setDeleteData() async {}

  // ! ============== Fungsi Delete Data ==============
  Future deleteData() async {}

  // ! ============== UI Related Function ==============
  // ! ============== Merefresh data dcOwnerTable ==============
  void resetInput() {
    currentInputStep = 0;
  }

  void resetInputController() {}

  void resetFilter() {}

  void resetFilterController() {}

  Future resetFilteredAndRefreshData() async {
    resetFilter();
    resetFilterController();
    await selectAndFilterData();
    update();
  }

  // ! ============== Set Appbar to Search Mode and vice versa ==============
  void setSearchMode(bool value) async {
    if (value == false) {
      resetToDefaultDataTableParameter();
      resetFilter();
      resetFilterController();
    }
    inSearchMode = value;
    await resetFilteredAndRefreshData();
    isBtnCloseSearchVisible = value;
    appBarSearchTextEditingController.clear();
    update();
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage ==============
  void searchMainPage(String s) {}

  // ! ============== Filter Function ==============
  void setFilterToTypedValue({
    TextEditingController textEditingController,
    @required String typedValue,
    String filterValue,
    @required Future<List<String>> Function(String) getFilterSuggesstion,
  }) {
    textEditingController?.text = typedValue;
    filterValue = typedValue;
    getFilterSuggesstion(filterValue);
    update();
  }

  // ! ============== Fungsi Paging Tabel ==============
  void setRowPerPage({@required int value}) {
    rowsPerPage = value;
    selectAndFilterData();
    update();
  }

  // ! ============== Fungsi Paging Tabel ==============
  void setRowPerPageFromRESTAPI({@required int value}) {
    masterPageDataFetchLimit = value;
    update();
  }

  // ! ============== Fungsi Sort Data Tabel From Memory (Not Used) ==============
  void sortTable<T>({
    @required Comparable<T> getField(MasterData d),
    @required int columnIndex,
    @required bool ascending,
    @required List<MasterData> masterDataList,
  }) {
    sortData<T>(getField, ascending, masterDataList);

    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    update();
  }

  void sortData<T>(Comparable<T> getField(MasterData d), bool ascending,
      List<MasterData> masterDataList) {
    // dcOwnerTableToShowOnTable.dcOwner.sort((a, b) {
    masterDataList.sort((a, b) {
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }

  // ! ============== Fungsi Sort Data Tabel dengan fetch data dari REST API ==============
  void sortTableUsingRESTAPI({
    @required String fieldName,
    @required int columnIndex,
    @required bool ascending,
  }) async {
    // _sortDataUsingRESTAPI<T>(getField, ascending);
    masterPageOrderField = fieldName;
    masterPageOrderAscending = ascending;
    await selectAndFilterData();

    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    update();
  }

  // ! ============== Snackbar fetced data success ==============
  void showSnackbarDataFetchSuccess(String message) {
    Get.snackbar('Success', message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  // ! ============== Snackbar fetced data failed ==============
  void showSnackbarDataFetchFailed(String message) {
    Get.snackbar('Failed', message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  // ! ============== Bottom Navigation ==============
  void onBottomNavigationChange({@required int index}) {
    bottomNavigationIndexPage = index;
    update();
  }

  bool isInputValid() {
    return false;
  }

  bool isInputValidated(bool whatToValidate, String warning) {
    if (whatToValidate) {
      Get.defaultDialog(
        confirmTextColor: Colors.white,
        onConfirm: () => Get.back(),
        middleText: '$warning must be not null',
      );
      return false;
    } else {
      return true;
    }
  }

  // ! ============== Pengatur Langkah Stepper ==============
  void previousInputStep() {
    if (currentInputStep > 0) {
      currentInputStep--;
    }
    update();
  }

  void onTapInputStep(int step) {
    currentInputStep = step;
    update();
  }

  // ! ============== File Picker for web ==============
  void startWebFilePicker() async {
    // FilePickerCross.pick().then((filePicker) {
    //   filePath = filePicker.path;
    //   fileLength = filePicker.toUint8List().lengthInBytes;
    //   try {
    //     fileString = filePicker.toString();
    //   } catch (e) {
    //     fileString =
    //         'Not a text file. Showing base64.\n\n' + filePicker.toBase64();
    //   }
    // });
  }

  // ! ============== UI Related Function ==============
  String getMessageFromFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  String getValidatedTextFormField(
      {@required String stringToValidate, @required String stringToSave}) {
    if (stringToValidate.isEmpty) {
      return 'Please enter some text';
    } else {
      stringToSave = stringToValidate;
      return 'Success';
    }
  }

  void onInsertPageShowed() {
    // resetDataRelatedVariable();
    resetInput();
    resetInputController();
  }

  void onEditPageShowed(int id) {}

  void onFilterPageShowed() {}

  void setComboboxFilter(EnumLogicalOperator enumDataFilterSelection) {
    dataFilterSelection = enumDataFilterSelection;
    selectAndFilterData();
    update();
  }

  void saveInput(EnumDataManipulation dataManipulationType) {
    // bool isInputStepValid = false;
    // formKeyInputBasic.currentState.validate();
    // formKeyInputDependencies.currentState.validate();
    // formKeyInputAdditional.currentState.validate();
    if (isInputValid()) {
      if (dataManipulationType == EnumDataManipulation.insert) {
        insertData();
      } else if (dataManipulationType == EnumDataManipulation.update) {
        updateData();
      }
      Get.back();
    }
  }

  void saveTabInput(
      TabController controller, EnumDataManipulation dataManipulationType) {
    switch (controller.index) {
      case 0:
        formKeyInputBasic.currentState?.validate();
        break;
      case 1:
        formKeyInputDependencies.currentState?.validate();
        break;
      case 2:
        formKeyInputAdditional.currentState?.validate();
        break;
      default:
    }
    saveInput(dataManipulationType);
  }
}
