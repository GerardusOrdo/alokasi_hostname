import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield_tap.dart';
import '../bloc/server_ploc.dart';

class ServerFilterBasic extends StatelessWidget {
  ServerFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServerPloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: double.infinity,
            child: DropdownButton(
                isExpanded: true,
                value: _.dataFilterSelection,
                items: _.dropdownFilterList,
                onChanged: (value) {
                  _.setComboboxFilter(value);
                }),
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'Server',
            onSuggestionSelected: (s) =>
                _.onFilterServerNameSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterServerNameSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.serverName,
          ),
          MasterPageStandardTypeAheadTextField(
            labelText: 'IP',
            onSuggestionSelected: (s) => _.onFilterIpSuggestionSelected(s),
            onSuggestionCallback: (pattern) =>
                _.getFilterIpSuggestionsFromAPI(pattern),
            textEditingController: _.filterTextCtrl.ip,
          ),
          MasterPageStandardDropdown(
            text: 'Status',
            value: _.filterServer.status,
            items: _.dropdownStatus,
            onChanged: (value) => _.setFilterStatusTo(value),
          ),
          MasterPageTextFormFieldTap(
            onTap: () {
              _.selectFilterDateRangePowerOn(
                  context, _.filterTextCtrl.powerOnDate);
            },
            textEditingController: _.filterTextCtrl.powerOnDate,
            inputText: "Server Power On Date",
            onChanged: (s) {},
          ),
          MasterPageTextFormFieldTap(
            onTap: () {
              _.selectFilterDateRangeUserNotif(
                  context, _.filterTextCtrl.userNotifDate);
            },
            textEditingController: _.filterTextCtrl.userNotifDate,
            inputText: "Before Server Power Off User Notification Date",
            onChanged: (s) {},
          ),
          MasterPageTextFormFieldTap(
            onTap: () {
              _.selectFilterDateRangePowerOff(
                  context, _.filterTextCtrl.powerOffDate);
            },
            textEditingController: _.filterTextCtrl.powerOffDate,
            inputText: "Server Power Off Notification Date",
            onChanged: (s) {},
          ),
          MasterPageTextFormFieldTap(
            onTap: () {
              _.selectFilterDateRangeDeleteServer(
                  context, _.filterTextCtrl.deleteDate);
            },
            textEditingController: _.filterTextCtrl.deleteDate,
            inputText: "Delete Server Notification Date",
            onChanged: (s) {},
          ),
          // MasterPageStandardTypeAheadTextField(
          //   labelText: 'Status',
          //   onSuggestionSelected: (s) => _.onFilterStatusSuggestionSelected(s),
          //   onSuggestionCallback: (pattern) =>
          //       _.getFilterIpSuggestionsFromAPI(pattern),
          //   textEditingController: _.filterTextCtrl.serverName,
          // ),
        ],
      ),
    );
  }
}
