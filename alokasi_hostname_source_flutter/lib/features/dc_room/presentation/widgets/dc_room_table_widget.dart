import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_room_ploc.dart';
import '../pages/dc_room_edit_page_tab.dart';

class DcRoomTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomPloc>(
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
              label: Text(' Room Type'),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "room_type",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            DataColumn(
              label: Text(_.pageName),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "room_name",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
            DataColumn(
              label: Text('Rack Capacity'),
              // ! sort data memanggil REST API dengan query order by
              onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                fieldName: "rack_capacity",
                ascending: ascending,
                columnIndex: columnIndex,
              ),
            ),
          ],
          source: _DcRoomDataSourceRestAPI(),
          rowsPerPage: _.rowsPerPage,
          onRowsPerPageChanged: (value) {
            _.setRowPerPage(value: value);
          },
          sortColumnIndex: _.sortColumnIndex,
          sortAscending: _.sortAscending,
          actions: [
            Visibility(
              visible: _.selectedDataCount > 0,
              child: IconButton(
                icon: Icon(Icons.content_copy),
                tooltip: 'Clone selected data',
                onPressed: () {
                  Get.defaultDialog(
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      _.cloneData();
                      Get.back();
                    },
                    onCancel: () {},
                    middleText: 'Sure to CLONE this data?',
                  );
                },
              ),
            ),
            Visibility(
              visible: _.selectedDataCount > 0 && _.selectedDataCount <= 1,
              child: IconButton(
                icon: Icon(Icons.create),
                tooltip: 'Edit selected data',
                onPressed: () {
                  _.onEditPageShowed(_.selectedDatasInTable[0].id);
                  Get.to(
                    DcRoomEditPageTab(),
                    transition: Transition.cupertino,
                  );
                },
              ),
            ),
            Visibility(
              visible: _.selectedDataCount > 0,
              child: IconButton(
                icon: Icon(Icons.delete),
                tooltip: 'Delete selected data',
                onPressed: () {
                  Get.defaultDialog(
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      _.setDeleteData();
                      Get.back();
                    },
                    onCancel: () {},
                    middleText: 'Sure to DELETE this data?',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ! Datasource jika menggunakan REST API
class _DcRoomDataSourceRestAPI extends DataTableSource {
  @override
  DataRow getRow(int index) => Get.find<DcRoomPloc>().getDataTableRow(index);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => Get.find<DcRoomPloc>().dcRoomTable.dcRoom.length;

  @override
  int get selectedRowCount => Get.find<DcRoomPloc>().selectedDataCount;
}
