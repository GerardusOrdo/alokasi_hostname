import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/template/master_data/presentation/bloc/masterpage_ploc.dart';
import '../../../owner/domain/entities/owner_plus_filter.dart';
import '../../../owner/domain/entities/owner_table.dart';
import '../../../owner/domain/usecases/select_owner_table.dart';
import '../../../owner/presentation/bloc/owner_ploc.dart';
import '../../domain/entities/server.dart';
import '../../domain/entities/server_plus_filter.dart';
import '../../domain/entities/server_table.dart';
import '../../domain/usecases/clone_server_table.dart';
import '../../domain/usecases/delete_server_table.dart';
import '../../domain/usecases/insert_server_table.dart';
import '../../domain/usecases/select_server_table.dart';
import '../../domain/usecases/set_delete_server_table.dart';
import '../../domain/usecases/update_server_table.dart';
import 'bloc_model/server_data.dart';
import 'bloc_model/server_text_ctrl.dart';

class ServerPloc extends MasterPagePloc {
  // ! Data Related variable
  ServerTable serverTable;
  Server server;
  ServerPlusFilter serverPlusFilterField;
  List<Server> selectedDatasInTable = [];

  List<DropdownMenuItem<dynamic>> dropdownStatus = [
    DropdownMenuItem(
      child: Text('Power Off'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('Power On'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Diperpanjang'),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text('Hapus'),
      value: 3,
    ),
  ];
  List<String> status = ['Power Off', 'Power On', 'Diperpanjang', 'Hapus'];

  // Data Dependencies Variable
  OwnerTable ownerTable;
  OwnerPlusFilter ownerPlusFilter;

  DateTime selectedDate = DateTime.now();
  DateTimeRange selectedDateRangePowerOn =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTimeRange selectedDateRangeUserNotif =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTimeRange selectedDateRangePowerOff =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTimeRange selectedDateRangeDeleteServer =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Server';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  ServerData filterServer = ServerData();
  ServerTextCtrl filterTextCtrl = ServerTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    serverName: TextEditingController(),
    ip: TextEditingController(),
    status: TextEditingController(),
    powerOnDate: TextEditingController(),
    userNotifDate: TextEditingController(),
    powerOffDate: TextEditingController(),
    deleteDate: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  ServerData inputServer = ServerData();
  ServerTextCtrl inputTextCtrl = ServerTextCtrl(
    id: TextEditingController(),
    idOwner: TextEditingController(),
    owner: TextEditingController(),
    serverName: TextEditingController(),
    ip: TextEditingController(),
    status: TextEditingController(),
    powerOnDate: TextEditingController(),
    userNotifDate: TextEditingController(),
    powerOffDate: TextEditingController(),
    deleteDate: TextEditingController(),
    notes: TextEditingController(),
    deleted: TextEditingController(),
    created: TextEditingController(),
  );

  // Data Dependencies Variable
  OwnerPloc ownerPloc;

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputServer.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterServer.setNullToAllFields();
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

    serverPlusFilterField = ServerPlusFilter(
      id: filterServer.id,
      idOwner: filterServer.idOwner,
      owner: getNullIfStringEmpty(filterServer.owner),
      serverName: getNullIfStringEmpty(filterServer.serverName),
      ip: getNullIfStringEmpty(filterServer.ip),
      status: filterServer.status,
      powerOnDate: getNullIfStringEmpty(filterServer.powerOnDate),
      powerOnDateFrom: filterServer.powerOnDateFrom,
      powerOnDateTo: filterServer.powerOnDateTo,
      userNotifDate: getNullIfStringEmpty(filterServer.userNotifDate),
      userNotifDateFrom: filterServer.userNotifDateFrom,
      userNotifDateTo: filterServer.userNotifDateTo,
      powerOffDate: getNullIfStringEmpty(filterServer.powerOffDate),
      powerOffDateFrom: filterServer.powerOffDateFrom,
      powerOffDateTo: filterServer.powerOffDateTo,
      deleteDate: getNullIfStringEmpty(filterServer.deleteDate),
      deleteDateFrom: filterServer.deleteDateFrom,
      deleteDateTo: filterServer.deleteDateTo,
      notes: getNullIfStringEmpty(filterServer.notes),
      deleted: filterServer.deleted,
      created: getNullIfStringEmpty(filterServer.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrServer =
        await Get.find<SelectServerTable>()(serverPlusFilterField);
    failureOrServer.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.serverTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - Owner
  Future selectAndFilterDataOwner({
    @required String searchItem,
    bool isNeedToRefreshServer = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    ownerPlusFilter = OwnerPlusFilter(
      owner: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrOwner = await Get.find<SelectOwnerTable>()(ownerPlusFilter);
    failureOrOwner.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.ownerTable = data;
    });
    if (isNeedToRefreshServer) {
      await selectAndFilterData();
    }
  }

  @override
  Future insertData() async {
    var now = DateTime.now();
    var dates = Jiffy(now).format();
    server = Server(
      // id: inputServer.id,
      idOwner: inputServer.idOwner,
      // owner: inputServer.owner,
      serverName: inputServer.serverName,
      ip: inputServer.ip,
      status: inputServer.status,
      powerOnDate: inputServer.powerOnDate ?? dates,
      userNotifDate: inputServer.userNotifDate ?? dates,
      powerOffDate: inputServer.powerOffDate ?? dates,
      deleteDate: inputServer.deleteDate ?? dates,
      notes: inputServer.notes,
      // deleted: inputServer.deleted,
      // created: inputServer.created,
    );
    final fetchedData = await Get.find<InsertServerTable>()(server);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (serverTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - Owner
  void addOwnerDependencies() async {
    ownerPloc.inputOwner.owner = inputTextCtrl.owner.text;
    await ownerPloc.insertData();
    getInputOwnerSuggestionFromAPI(inputTextCtrl.owner.text);
    inputTextCtrl.owner.clear();
    update();
  }

  void inputOwnerTextSelected(Map<String, dynamic> value) {
    String s = 'owner';
    inputTextCtrl.owner.text = value[s];
    inputServer.owner = value[s];
    inputServer.idOwner = value['id'];
    getInputOwnerSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputOwnerSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataOwner(
            searchItem: value, isNeedToRefreshServer: false, fetchLimit: 7)
        .whenComplete(
      () => ownerTable.owner.forEach((element) {
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
    var now = DateTime.now();
    var dates = Jiffy(now).format();
    server = Server(
      id: selectedDatasInTable[0].id,
      idOwner: inputServer.idOwner,
      // owner: inputServer.owner,
      serverName: inputServer.serverName,
      ip: inputServer.ip,
      status: inputServer.status,
      powerOnDate: inputServer.powerOnDate ?? dates,
      userNotifDate: inputServer.userNotifDate ?? dates,
      powerOffDate: inputServer.powerOffDate ?? dates,
      deleteDate: inputServer.deleteDate ?? dates,
      notes: inputServer.notes,
      // deleted: inputServer.deleted,
      // created: inputServer.created,
    );
    final fetchedData = await Get.find<UpdateServerTable>()(server);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (serverTable) => showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneServerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (serverTable) => showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteServerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (serverTable) => showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteServerTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (serverTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final servers = serverTable;
    if (index >= servers.server.length) return null;
    final Server server = servers.server[index];
    return DataRow.byIndex(
      index: index,
      selected: server.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(server.id.toString())),
        DataCell(Text(server.owner ?? '')),
        DataCell(Text(server.serverName ?? '')),
        DataCell(Text(server.ip ?? '')),
        DataCell(Text(status[server.status] ?? '')),
        DataCell(Text(Jiffy(server.powerOnDate).format("dd/MM/yyyy") ?? '')),
        DataCell(Text(Jiffy(server.userNotifDate).format("dd/MM/yyyy") ?? '')),
        DataCell(Text(Jiffy(server.powerOffDate).format("dd/MM/yyyy") ?? '')),
        DataCell(Text(Jiffy(server.deleteDate).format("dd/MM/yyyy") ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterServer.owner = s;
      filterServer.serverName = s;
      filterServer.ip = s;
      // filterServer.status = int.parse(s);
      filterServer.notes = s;
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
  void onFilterServerNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.serverName,
        typedValue: typedValue,
        filterValue: filterServer.serverName,
        getFilterSuggesstion: getFilterServerNameSuggestionsFromAPI);
  }

  void onFilterIpSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.ip,
        typedValue: typedValue,
        filterValue: filterServer.ip,
        getFilterSuggesstion: getFilterIpSuggestionsFromAPI);
  }

  void onFilterPowerOnDateSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.powerOnDate,
        typedValue: typedValue,
        filterValue: filterServer.powerOnDate,
        getFilterSuggesstion: getFilterPowerOnDateSuggestionsFromAPI);
  }

  void onFilterUserNotifDateSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.userNotifDate,
        typedValue: typedValue,
        filterValue: filterServer.userNotifDate,
        getFilterSuggesstion: getFilterUserNotifDateSuggestionsFromAPI);
  }

  void onFilterPowerOffDateSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.powerOffDate,
        typedValue: typedValue,
        filterValue: filterServer.powerOffDate,
        getFilterSuggesstion: getFilterPowerOffDateSuggestionsFromAPI);
  }

  void onFilterDeleteDateSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.deleteDate,
        typedValue: typedValue,
        filterValue: filterServer.deleteDate,
        getFilterSuggesstion: getFilterDeleteDateSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterServer.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterServer.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Owner
  void onFilterOwnerSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.owner,
        typedValue: typedValue,
        filterValue: filterServer.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterServer.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterServerNameSuggestionsFromAPI(
      String value) async {
    masterPageDataFetchLimit = null;
    filterServer.serverName = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.serverName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterIpSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterServer.ip = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.ip);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterPowerOnDateSuggestionsFromAPI(
      String value) async {
    masterPageDataFetchLimit = null;
    filterServer.powerOnDate = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.powerOnDate);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterUserNotifDateSuggestionsFromAPI(
      String value) async {
    masterPageDataFetchLimit = null;
    filterServer.userNotifDate = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.userNotifDate);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterPowerOffDateSuggestionsFromAPI(
      String value) async {
    masterPageDataFetchLimit = null;
    filterServer.powerOffDate = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.powerOffDate);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterDeleteDateSuggestionsFromAPI(
      String value) async {
    masterPageDataFetchLimit = null;
    filterServer.deleteDate = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.deleteDate);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterServer.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterServer.created = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      serverTable.server.forEach((element) {
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
    filterServer.owner = value;
    List<String> match = [];
    await selectAndFilterDataOwner(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      ownerTable.owner.forEach((element) {
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
    // final dcOwner = ownerTableToShowOnTable.dcOwner[index];
    final masterData = serverTable.server[index];
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
    Server val = serverTable.server.singleWhere((element) => element.id == id);

    // data
    inputServer.id = val.id;
    inputServer.idOwner = val.idOwner;
    inputServer.owner = val.owner;
    inputServer.serverName = val.serverName;
    inputServer.ip = val.ip;
    inputServer.status = val.status;
    inputServer.powerOnDate = val.powerOnDate;
    inputServer.userNotifDate = val.userNotifDate;
    inputServer.powerOffDate = val.powerOffDate;
    inputServer.deleteDate = val.deleteDate;
    inputServer.notes = val.notes;
    inputServer.deleted = val.deleted;
    inputServer.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputServer.id.toString();
    inputTextCtrl.idOwner.text = inputServer.idOwner.toString();
    inputTextCtrl.owner.text = inputServer.owner;
    inputTextCtrl.serverName.text = inputServer.serverName;
    inputTextCtrl.ip.text = inputServer.ip;
    inputTextCtrl.status.text = inputServer.status.toString();
    inputTextCtrl.powerOnDate.text =
        Jiffy(inputServer.powerOnDate).format("dd/MM/yyyy");
    inputTextCtrl.userNotifDate.text =
        Jiffy(inputServer.userNotifDate).format("dd/MM/yyyy");
    inputTextCtrl.powerOffDate.text =
        Jiffy(inputServer.powerOffDate).format("dd/MM/yyyy");
    inputTextCtrl.deleteDate.text =
        Jiffy(inputServer.deleteDate).format("dd/MM/yyyy");
    inputTextCtrl.notes.text = inputServer.notes;
    inputTextCtrl.deleted.text = inputServer.deleted.toString();
    inputTextCtrl.created.text = inputServer.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
                inputServer.serverName.isNull || inputServer.serverName.isEmpty,
                'Server (Basic Information)') &&
            isInputValidated(
                inputServer.powerOnDate.isNull ||
                    inputServer.powerOnDate.isEmpty,
                'Server Power On Date (Basic Information)') &&
            isInputValidated(
                inputServer.userNotifDate.isNull ||
                    inputServer.userNotifDate.isEmpty,
                'Before Power Off User Notification Date (Basic Information)') &&
            isInputValidated(
                inputServer.powerOffDate.isNull ||
                    inputServer.powerOffDate.isEmpty,
                'Server Power Off Notification Date (Basic Information)') &&
            isInputValidated(
                inputServer.deleteDate.isNull || inputServer.deleteDate.isEmpty,
                'Delete Server Notification Date (Basic Information)')
        // && validateInput(inputServer.idOwner.isNull, 'Owner (Dependencies)')
        ;
  }

  void setStatusTo(int value) {
    inputServer.status = value;
    update();
  }

  void setFilterStatusTo(int value) async {
    filterServer.status = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }

  Future<Null> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedDate = picked;
      controller.text = DateFormat.yMd().format(selectedDate);
      var dates = Jiffy(picked).format();
      setDates(controller: controller, dates: dates);
    }
  }

  void setDates(
      {@required TextEditingController controller, @required String dates}) {
    if (controller == inputTextCtrl.powerOnDate) {
      inputServer.powerOnDate = dates;
    } else if (controller == inputTextCtrl.userNotifDate) {
      inputServer.userNotifDate = dates;
    } else if (controller == inputTextCtrl.powerOffDate) {
      inputServer.powerOffDate = dates;
    } else if (controller == inputTextCtrl.deleteDate) {
      inputServer.deleteDate = dates;
    }
  }

  Future<Null> selectFilterDateRangePowerOn(
      BuildContext context, TextEditingController controller) async {
    final DateTimeRange picked = await showDateRangePicker(
        context: context,
        initialDateRange: selectedDateRangePowerOn,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null && picked != null) {
      selectedDateRangePowerOn = picked;
      filterServer.powerOnDateFrom = Jiffy(picked.start).format();
      filterServer.powerOnDateTo = Jiffy(picked.end).format();
      controller.text =
          "${DateFormat.yMd().format(picked.start)} - ${DateFormat.yMd().format(picked.end)}";
      await selectAndFilterData(
          dataFilterByLogicalOperator: dataFilterSelection);
      update();
    }
  }

  Future<Null> selectFilterDateRangeUserNotif(
      BuildContext context, TextEditingController controller) async {
    final DateTimeRange picked = await showDateRangePicker(
        context: context,
        initialDateRange: selectedDateRangeUserNotif,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null && picked != null) {
      selectedDateRangeUserNotif = picked;
      filterServer.userNotifDateFrom = Jiffy(picked.start).format();
      filterServer.userNotifDateTo = Jiffy(picked.end).format();
      controller.text =
          "${DateFormat.yMd().format(picked.start)} - ${DateFormat.yMd().format(picked.end)}";
      await selectAndFilterData(
          dataFilterByLogicalOperator: dataFilterSelection);
      update();
    }
  }

  Future<Null> selectFilterDateRangePowerOff(
      BuildContext context, TextEditingController controller) async {
    final DateTimeRange picked = await showDateRangePicker(
        context: context,
        initialDateRange: selectedDateRangePowerOff,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null && picked != null) {
      selectedDateRangePowerOff = picked;
      filterServer.powerOffDateFrom = Jiffy(picked.start).format();
      filterServer.powerOffDateTo = Jiffy(picked.end).format();
      controller.text =
          "${DateFormat.yMd().format(picked.start)} - ${DateFormat.yMd().format(picked.end)}";
      await selectAndFilterData(
          dataFilterByLogicalOperator: dataFilterSelection);
      update();
    }
  }

  Future<Null> selectFilterDateRangeDeleteServer(
      BuildContext context, TextEditingController controller) async {
    final DateTimeRange picked = await showDateRangePicker(
        context: context,
        initialDateRange: selectedDateRangeDeleteServer,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null && picked != null) {
      selectedDateRangeDeleteServer = picked;
      filterServer.deleteDateFrom = Jiffy(picked.start).format();
      filterServer.deleteDateTo = Jiffy(picked.end).format();
      controller.text =
          "${DateFormat.yMd().format(picked.start)} - ${DateFormat.yMd().format(picked.end)}";
      await selectAndFilterData(
          dataFilterByLogicalOperator: dataFilterSelection);
      update();
    }
  }
}
