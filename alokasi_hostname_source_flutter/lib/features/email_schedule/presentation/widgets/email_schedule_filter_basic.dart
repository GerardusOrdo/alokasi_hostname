import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_dropdown.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield_tap.dart';
import '../bloc/email_schedule_ploc.dart';

class EmailScheduleFilterBasic extends StatelessWidget {
  EmailScheduleFilterBasic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSchedulePloc>(
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
          // MasterPageStandardTypeAheadTextField(
          //   labelText: 'Date',
          //   onSuggestionSelected: (s) => _.onFilterDateSuggestionSelected(s),
          //   onSuggestionCallback: (pattern) =>
          //       _.getFilterDateSuggestionsFromAPI(pattern),
          //   textEditingController: _.filterTextCtrl.date,
          // ),
          MasterPageTextFormFieldTap(
            onTap: () {
              _.selectFilterDateRange(context, _.filterTextCtrl.date);
            },
            textEditingController: _.filterTextCtrl.date,
            inputText: "Date",
            onChanged: (s) {},
          ),
          MasterPageStandardDropdown(
            text: 'State',
            value: _.filterEmailSchedule.state,
            items: _.dropdownState,
            onChanged: (value) => _.setFilterStateTo(value),
          ),
          MasterPageStandardDropdown(
            text: 'Status',
            value: _.filterEmailSchedule.status,
            items: _.dropdownStatus,
            onChanged: (value) => _.setFilterStatusTo(value),
          ),
        ],
      ),
    );
  }
}
