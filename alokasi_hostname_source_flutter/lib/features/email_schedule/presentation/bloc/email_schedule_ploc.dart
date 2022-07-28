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
import '../../../server/domain/entities/server_plus_filter.dart';
import '../../../server/domain/entities/server_table.dart';
import '../../../server/domain/usecases/select_server_table.dart';
import '../../../server/presentation/bloc/server_ploc.dart';
import '../../domain/entities/email_schedule.dart';
import '../../domain/entities/email_schedule_plus_filter.dart';
import '../../domain/entities/email_schedule_table.dart';
import '../../domain/usecases/clone_email_schedule_table.dart';
import '../../domain/usecases/delete_email_schedule_table.dart';
import '../../domain/usecases/insert_email_schedule_table.dart';
import '../../domain/usecases/select_email_schedule_table.dart';
import '../../domain/usecases/set_delete_email_schedule_table.dart';
import '../../domain/usecases/update_email_schedule_table.dart';
import 'bloc_model/email_schedule_data.dart';
import 'bloc_model/email_schedule_text_ctrl.dart';

class EmailSchedulePloc extends MasterPagePloc {
  // ! Data Related variable
  EmailScheduleTable emailScheduleTable;
  EmailSchedule emailSchedule;
  EmailSchedulePlusFilter emailSchedulePlusFilterField;
  List<EmailSchedule> selectedDatasInTable = [];

  List<DropdownMenuItem<dynamic>> dropdownState = [
    DropdownMenuItem(
      child: Text('Power On Date'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('User Notif Date'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Power Off Date'),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text('Delete Date'),
      value: 3,
    ),
  ];
  List<String> state = [
    'Power On Date',
    'User Notif Date',
    'Power Off Date',
    'Delete Date'
  ];

  List<DropdownMenuItem<dynamic>> dropdownStatus = [
    DropdownMenuItem(
      child: Text('Not Sent'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('Sent'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('Fail to Sent'),
      value: 2,
    ),
  ];
  List<String> status = ['Not Sent', 'Sent', 'Fail to Sent'];

  // Data Dependencies Variable
  OwnerTable dcOwnerTable;
  OwnerPlusFilter ownerPlusFilter;
  ServerTable serverTable;
  ServerPlusFilter serverPlusFilter;

  // ! UI variable
  // ! -> AppBar & Search Functionality
  // # UI variable
  @override
  String pageName = 'Email Schedule';

  // ! -> Filter Functionality
  // yg ada di sini, pastikan ada juga di function resetFilter() dan resetFilterController()
  EmailScheduleData filterEmailSchedule = EmailScheduleData();
  EmailScheduleTextCtrl filterTextCtrl = EmailScheduleTextCtrl(
    id: TextEditingController(),
    idServer: TextEditingController(),
    serverName: TextEditingController(),
    ip: TextEditingController(),
    owner: TextEditingController(),
    email: TextEditingController(),
    date: TextEditingController(),
    state: TextEditingController(),
    status: TextEditingController(),
    notes: TextEditingController(),
    created: TextEditingController(),
  );

  // ! -> Input page
  // yg ada di sini, pastikan ada juga di function resetInput() dan resetInputController()
  EmailScheduleData inputEmailSchedule = EmailScheduleData();
  EmailScheduleTextCtrl inputTextCtrl = EmailScheduleTextCtrl(
    id: TextEditingController(),
    idServer: TextEditingController(),
    serverName: TextEditingController(),
    ip: TextEditingController(),
    owner: TextEditingController(),
    email: TextEditingController(),
    date: TextEditingController(),
    state: TextEditingController(),
    status: TextEditingController(),
    notes: TextEditingController(),
    created: TextEditingController(),
  );

  ServerPloc serverPloc;
  OwnerPloc ownerPloc;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  DateTimeRange selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  // TextEditingController dateController = TextEditingController();
  // TextEditingController timeController = TextEditingController();
  String hour, minute, time;
  String setTime, setDate;

  @override
  void onInit() {
    super.onInit();
  }

  // ! ============== Data Related Function ==============
  @override
  void resetInput() {
    super.resetInput();
    inputEmailSchedule.setNullToAllFields();
  }

  @override
  void resetInputController() {
    super.resetInputController();
    inputTextCtrl.clearAllTextCtrl();
  }

  @override
  void resetFilter() {
    super.resetFilter();
    filterEmailSchedule.setNullToAllFields();
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
    // var now = DateTime.now();
    // var dates = Jiffy(now).format();
    fetchLimit ??= masterPageDataFetchLimit;
    emailSchedulePlusFilterField = EmailSchedulePlusFilter(
      id: filterEmailSchedule.id,
      idServer: filterEmailSchedule.idServer,
      serverName: getNullIfStringEmpty(filterEmailSchedule.serverName),
      ip: getNullIfStringEmpty(filterEmailSchedule.ip),
      owner: getNullIfStringEmpty(filterEmailSchedule.owner),
      email: getNullIfStringEmpty(filterEmailSchedule.email),
      date: getNullIfStringEmpty(filterEmailSchedule.date),
      dateFrom: filterEmailSchedule.dateFrom,
      dateTo: filterEmailSchedule.dateTo,
      state: filterEmailSchedule.state,
      status: filterEmailSchedule.status,
      notes: getNullIfStringEmpty(filterEmailSchedule.notes),
      created: getNullIfStringEmpty(filterEmailSchedule.created),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
      dataFilterByLogicalOperator: dataFilterByLogicalOperator,
    );

    final failureOrEmailSchedule = await Get.find<SelectEmailScheduleTable>()(
        emailSchedulePlusFilterField);
    failureOrEmailSchedule.fold((failure) {
      isDataFetchSuccess = false;
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      isDataFetchSuccess = true;
      this.emailScheduleTable = data;
    });
    resetSelectedData();
    update();
  }

  // Dependencies - ServerName
  Future selectAndFilterDataServerName({
    @required String searchItem,
    bool isNeedToRefreshEmailSchedule = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    serverPlusFilter = ServerPlusFilter(
      serverName: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcServerName =
        await Get.find<SelectServerTable>()(serverPlusFilter);
    failureOrDcServerName.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.serverTable = data;
    });
    if (isNeedToRefreshEmailSchedule) {
      await selectAndFilterData();
    }
  }

  // Dependencies - Owner
  Future selectAndFilterDataOwner({
    @required String searchItem,
    bool isNeedToRefreshEmailSchedule = true,
    int fetchLimit,
  }) async {
    fetchLimit ??= masterPageDataFetchLimit;
    ownerPlusFilter = OwnerPlusFilter(
      owner: getNullIfStringEmpty(searchItem),
      limits: fetchLimit,
      fieldToOrderBy: masterPageOrderField,
      orderByAscending: masterPageOrderAscending,
    );

    final failureOrDcOwner =
        await Get.find<SelectOwnerTable>()(ownerPlusFilter);
    failureOrDcOwner.fold((failure) {
      this.failureMessage = getMessageFromFailure(failure);
    }, (data) {
      this.dcOwnerTable = data;
    });
    if (isNeedToRefreshEmailSchedule) {
      await selectAndFilterData();
    }
  }

  @override
  Future insertData() async {
    emailSchedule = EmailSchedule(
      // id: inputEmailSchedule.id,
      idServer: inputEmailSchedule.idServer, //dependencies
      // serverName: inputEmailSchedule.serverName,
      // ip: inputEmailSchedule.ip,
      // owner: inputEmailSchedule.owner,
      // email: inputEmailSchedule.email,
      date: inputEmailSchedule.date, //basic
      state: inputEmailSchedule.state, //basic
      status: inputEmailSchedule.status, //basic
      notes: inputEmailSchedule.notes, //additional
      // created: inputEmailSchedule.created,
    );
    final fetchedData =
        await Get.find<InsertEmailScheduleTable>()(emailSchedule);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (emailScheduleTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  // Dependencies - ServerName
  void addServerNameDependencies() async {
    serverPloc.inputServer.serverName = inputTextCtrl.serverName.text;
    await serverPloc.insertData();
    getInputServerNameSuggestionFromAPI(inputTextCtrl.serverName.text);
    inputTextCtrl.serverName.clear();
    update();
  }

  void inputServerTextSelected(Map<String, dynamic> value) {
    String s = 'server_name';
    inputTextCtrl.serverName.text = value[s];
    inputEmailSchedule.serverName = value[s];
    inputEmailSchedule.idServer = value['id'];
    getInputServerNameSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputServerNameSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataServerName(
            searchItem: value,
            isNeedToRefreshEmailSchedule: false,
            fetchLimit: 7)
        .whenComplete(
      () => serverTable.server.forEach((element) {
        match.add({
          'id': element.id,
          'server_name': element.serverName,
        });
      }),
    );
    match.removeWhere((element) => element.isNull);
    return match;
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
    inputEmailSchedule.owner = value[s];
    // inputEmailSchedule.idOwner = value['id'];
    getInputOwnerSuggestionFromAPI(value[s]);
    update();
  }

  Future<List<Map<String, dynamic>>> getInputOwnerSuggestionFromAPI(
      String value) async {
    List<Map<String, dynamic>> match = [];
    await selectAndFilterDataOwner(
            searchItem: value,
            isNeedToRefreshEmailSchedule: false,
            fetchLimit: 7)
        .whenComplete(
      () => dcOwnerTable.owner.forEach((element) {
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
    emailSchedule = EmailSchedule(
      id: selectedDatasInTable[0].id,
      idServer: inputEmailSchedule.idServer,
      // serverName: inputEmailSchedule.serverName,
      // ip: inputEmailSchedule.ip,
      // owner: inputEmailSchedule.owner,
      // email: inputEmailSchedule.email,
      date: inputEmailSchedule.date,
      state: inputEmailSchedule.state,
      status: inputEmailSchedule.status,
      notes: inputEmailSchedule.notes,
      // created: inputEmailSchedule.created,
    );
    final fetchedData =
        await Get.find<UpdateEmailScheduleTable>()(emailSchedule);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (emailScheduleTable) =>
            showSnackbarDataFetchSuccess('Data has been updated'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future cloneData() async {
    final fetchedData =
        await Get.find<CloneEmailScheduleTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (emailScheduleTable) =>
            showSnackbarDataFetchSuccess('Data has been saved'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future setDeleteData() async {
    final fetchedData =
        await Get.find<SetDeleteEmailScheduleTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (emailScheduleTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted'));
    await resetFilteredAndRefreshData();
    update();
  }

  @override
  Future deleteData() async {
    final fetchedData =
        await Get.find<DeleteEmailScheduleTable>()(selectedDatasInTable);
    fetchedData.fold(
        (failure) =>
            showSnackbarDataFetchFailed(getMessageFromFailure(failure)),
        (emailScheduleTable) =>
            showSnackbarDataFetchSuccess('Data has been deleted forever'));
    await resetFilteredAndRefreshData();
    update();
  }

  // ! ============== Fungsi Select checkbox Tabel dan field datatable ==============
  DataRow getDataTableRow(int index) {
    assert(index >= 0);
    final emailSchedules = emailScheduleTable;
    if (index >= emailSchedules.emailSchedule.length) return null;
    final EmailSchedule emailSchedule = emailSchedules.emailSchedule[index];
    return DataRow.byIndex(
      index: index,
      selected: emailSchedule.selected,
      onSelectChanged: (value) =>
          onSelectedDataChanged(value: value, index: index),
      cells: [
        DataCell(Text(emailSchedule.id.toString())),
        DataCell(Text(emailSchedule.serverName ?? '')),
        DataCell(Text(emailSchedule.ip ?? '')),
        DataCell(Text(emailSchedule.owner ?? '')),
        DataCell(Text(emailSchedule.email ?? '')),
        DataCell(Text(Jiffy(emailSchedule.date).format("dd/MM/yyyy") ?? '')),
        DataCell(Text(state[emailSchedule.state] ?? '')),
        DataCell(Text(status[emailSchedule.status] ?? '')),
      ],
    );
  }

  // ! ============== Menampilkan data ke tabel ketika user mengetik di search mainpage
  void searchMainPage(String s) {
    debouncer.run(() {
      filterEmailSchedule.owner = s;
      filterEmailSchedule.serverName = s;
      filterEmailSchedule.ip = s;
      filterEmailSchedule.owner = s;
      filterEmailSchedule.email = s;
      // filterEmailSchedule.date = s;
      // filterEmailSchedule.state = int.parse(s);
      // filterEmailSchedule.status = int.parse(s);
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
  void onFilterIpSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.ip,
        typedValue: typedValue,
        filterValue: filterEmailSchedule.ip,
        getFilterSuggesstion: getFilterIpSuggestionsFromAPI);
  }

  void onFilterEmailSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.email,
        typedValue: typedValue,
        filterValue: filterEmailSchedule.email,
        getFilterSuggesstion: getFilterEmailSuggestionsFromAPI);
  }

  void onFilterDateSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.date,
        typedValue: typedValue,
        filterValue: filterEmailSchedule.date,
        getFilterSuggesstion: getFilterDateSuggestionsFromAPI);
  }

  void onFilterNotesSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.notes,
        typedValue: typedValue,
        filterValue: filterEmailSchedule.notes,
        getFilterSuggesstion: getFilterNotesSuggestionsFromAPI);
  }

  void onFilterCreatedSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.created,
        typedValue: typedValue,
        filterValue: filterEmailSchedule.created,
        getFilterSuggesstion: getFilterCreatedSuggestionsFromAPI);
  }

  // Dependencies - Server
  void onFilterServerNameSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.serverName,
        typedValue: typedValue,
        filterValue: filterEmailSchedule.serverName,
        getFilterSuggesstion: getFilterServerNameSuggestionsFromAPI);
  }

  // Dependencies - Owner
  void onFilterOwnerSuggestionSelected(String typedValue) {
    setFilterToTypedValue(
        textEditingController: filterTextCtrl.owner,
        typedValue: typedValue,
        filterValue: filterEmailSchedule.owner,
        getFilterSuggesstion: getFilterOwnerSuggestionsFromAPI);
  }

  // ! ============== Get Suggestion for Filter page from REST API ==============
  Future<List<String>> getFilterIdOwnerSuggestionsFromAPI(String query) async {
    masterPageDataFetchLimit = null;
    filterEmailSchedule.owner = query;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      emailScheduleTable.emailSchedule.forEach((element) {
        match.add(element.owner);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterIpSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterEmailSchedule.ip = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      emailScheduleTable.emailSchedule.forEach((element) {
        match.add(element.ip);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterEmailSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterEmailSchedule.email = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      emailScheduleTable.emailSchedule.forEach((element) {
        match.add(element.email);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterDateSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterEmailSchedule.date = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      emailScheduleTable.emailSchedule.forEach((element) {
        match.add(element.date);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterNotesSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterEmailSchedule.notes = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      emailScheduleTable.emailSchedule.forEach((element) {
        match.add(element.notes);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  Future<List<String>> getFilterCreatedSuggestionsFromAPI(String value) async {
    masterPageDataFetchLimit = null;
    filterEmailSchedule.created = value;
    List<String> match = [];
    await selectAndFilterData(
            fetchLimit: 7, dataFilterByLogicalOperator: dataFilterSelection)
        .whenComplete(() {
      emailScheduleTable.emailSchedule.forEach((element) {
        match.add(element.created);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - serverName
  Future<List<String>> getFilterServerNameSuggestionsFromAPI(
      String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterEmailSchedule.serverName = value;
    List<String> match = [];
    await selectAndFilterDataServerName(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      serverTable.server.forEach((element) {
        match.add(element.serverName);
      });
    });
    match.removeWhere((element) => element.isNull);
    return match;
  }

  // dependencies - owner
  Future<List<String>> getFilterOwnerSuggestionsFromAPI(String value) async {
    // resetDataRelatedVariable();
    // masterPageDataFetchLimit = null;
    filterEmailSchedule.owner = value;
    List<String> match = [];
    await selectAndFilterDataOwner(searchItem: value, fetchLimit: 7)
        .whenComplete(() {
      dcOwnerTable.owner.forEach((element) {
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
    final masterData = emailScheduleTable.emailSchedule[index];
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
    EmailSchedule val = emailScheduleTable.emailSchedule
        .singleWhere((element) => element.id == id);

    // data
    inputEmailSchedule.id = val.id;
    inputEmailSchedule.idServer = val.idServer;
    inputEmailSchedule.serverName = val.serverName;
    inputEmailSchedule.ip = val.ip;
    inputEmailSchedule.owner = val.owner;
    inputEmailSchedule.email = val.email;
    inputEmailSchedule.date = val.date;
    inputEmailSchedule.state = val.state;
    inputEmailSchedule.status = val.status;
    inputEmailSchedule.notes = val.notes;
    inputEmailSchedule.created = val.created;

    // text editing Controller
    inputTextCtrl.id.text = inputEmailSchedule.id.toString();
    inputTextCtrl.idServer.text = inputEmailSchedule.idServer.toString();
    inputTextCtrl.serverName.text = inputEmailSchedule.serverName;
    inputTextCtrl.ip.text = inputEmailSchedule.ip;
    inputTextCtrl.owner.text = inputEmailSchedule.owner;
    inputTextCtrl.email.text = inputEmailSchedule.email;
    inputTextCtrl.date.text =
        Jiffy(inputEmailSchedule.date).format("dd/MM/yyyy");
    inputTextCtrl.state.text = inputEmailSchedule.state.toString();
    inputTextCtrl.status.text = inputEmailSchedule.status.toString();
    inputTextCtrl.notes.text = inputEmailSchedule.notes;
    inputTextCtrl.created.text = inputEmailSchedule.created;
  }

  @override
  void onFilterPageShowed() {}

  // ! ============== Validate data before saving ==============
  @override
  bool isInputValid() {
    return isInputValidated(
            inputEmailSchedule.date.isNull || inputEmailSchedule.date.isEmpty,
            'EmailSchedule (Basic Information)')
        // && validateInput(inputEmailSchedule.idOwner.isNull, 'Owner (Dependencies)')
        ;
  }

  void setStateTo(int value) {
    inputEmailSchedule.state = value;
    update();
  }

  void setFilterStateTo(int value) async {
    filterEmailSchedule.state = value;
    await selectAndFilterData(dataFilterByLogicalOperator: dataFilterSelection);
    update();
  }

  void setStatusTo(int value) {
    inputEmailSchedule.status = value;
    update();
  }

  void setFilterStatusTo(int value) async {
    filterEmailSchedule.status = value;
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
    }
  }

  Future<Null> selectFilterDateRange(
      BuildContext context, TextEditingController controller) async {
    final DateTimeRange picked = await showDateRangePicker(
        context: context,
        initialDateRange: selectedDateRange,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null && picked != null) {
      selectedDateRange = picked;
      filterEmailSchedule.dateFrom = Jiffy(picked.start).format();
      filterEmailSchedule.dateTo = Jiffy(picked.end).format();
      controller.text =
          "${DateFormat.yMd().format(picked.start)} - ${DateFormat.yMd().format(picked.end)}";
      await selectAndFilterData(
          dataFilterByLogicalOperator: dataFilterSelection);
      update();
    }
  }

  // Future<Null> selectTime(BuildContext context) async {
  //   final TimeOfDay picked = await showTimePicker(
  //     context: context,
  //     initialTime: selectedTime,
  //   );
  //   if (picked != null) {
  //     selectedTime = picked;
  //     hour = selectedTime.hour.toString();
  //     minute = selectedTime.minute.toString();
  //     time = hour + ' : ' + minute;
  //     timeController.text = time;
  //     timeController.text = formatDate(
  //         DateTime(2021, 01, 1, selectedTime.hour, selectedTime.minute),
  //         [hh, ':', nn, " ", am]).toString();
  //   }
  // }
}
