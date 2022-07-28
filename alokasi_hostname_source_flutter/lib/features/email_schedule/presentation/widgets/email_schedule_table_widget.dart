import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/email_schedule_ploc.dart';
import '../pages/email_schedule_edit_page_tab.dart';

class EmailScheduleTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSchedulePloc>(
      builder: (_) => SingleChildScrollView(
        child: PaginatedDataTable(
          header: Text(_.pageName),
          columns: <DataColumn>[
            DataColumn(
              label: Text('ID'),
              numeric: true,
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "id",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            // DataColumn(
            //   label: Text('ID Owner'),
            //   numeric: true,
            //   // ! sort data memanggil REST API dengan query order by
            //   onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
            //     fieldName: "id_owner",
            //     ascending: ascending,
            //     columnIndex: columnIndex,
            //   ),
            // ),
            // DataColumn(
            //   label: Text('Owner'),
            //   // ! sort data memanggil REST API dengan query order by
            //   onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
            //     fieldName: "owner",
            //     ascending: ascending,
            //     columnIndex: columnIndex,
            //   ),
            // ),
            DataColumn(
              label: Text('Server'),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "server_name",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            DataColumn(
              label: Text('IP'),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "ip",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            DataColumn(
              label: Text('Owner'),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "owner",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            DataColumn(
              label: Text('Email'),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "email",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            DataColumn(
              label: Text(_.pageName),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "date",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            DataColumn(
              label: Text('State'),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "state",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            DataColumn(
              label: Text('Status'),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "status",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
          ],
          source: _EmailScheduleDataSourceRestAPI(),
          rowsPerPage: _.rowsPerPage,
          onRowsPerPageChanged: (value) {
            _.setRowPerPage(value: value);
          },
          sortColumnIndex: _.sortColumnIndex,
          sortAscending: _.sortAscending,
          actions: [
            // Visibility(
            //   visible: _.selectedDataCount > 0,
            //   child: IconButton(
            //     icon: Icon(Icons.content_copy),
            //     tooltip: 'Clone selected data',
            //     onPressed: () {
            //       Get.defaultDialog(
            //         confirmTextColor: Colors.white,
            //         onConfirm: () {
            //           _.cloneData();
            //           Get.back();
            //         },
            //         onCancel: () {},
            //         middleText: 'Sure to CLONE this data?',
            //       );
            //     },
            //   ),
            // ),
            Visibility(
              visible: _.selectedDataCount > 0 && _.selectedDataCount <= 1,
              child: IconButton(
                icon: Icon(Icons.create),
                tooltip: 'Edit selected data',
                onPressed: () {
                  _.onEditPageShowed(_.selectedDatasInTable[0].id);
                  Get.to(
                    EmailScheduleEditPageTab(),
                    transition: Transition.cupertino,
                  );
                },
              ),
            ),
            // Visibility(
            //   visible: _.selectedDataCount > 0,
            //   child: IconButton(
            //     icon: Icon(Icons.delete),
            //     tooltip: 'Delete selected data',
            //     onPressed: () {
            //       Get.defaultDialog(
            //         confirmTextColor: Colors.white,
            //         onConfirm: () {
            //           _.setDeleteData();
            //           Get.back();
            //         },
            //         onCancel: () {},
            //         middleText: 'Sure to DELETE this data?',
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// ! Datasource jika menggunakan REST API
class _EmailScheduleDataSourceRestAPI extends DataTableSource {
  @override
  DataRow getRow(int index) =>
      Get.find<EmailSchedulePloc>().getDataTableRow(index);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount =>
      Get.find<EmailSchedulePloc>().emailScheduleTable.emailSchedule.length;

  @override
  int get selectedRowCount => Get.find<EmailSchedulePloc>().selectedDataCount;
}
