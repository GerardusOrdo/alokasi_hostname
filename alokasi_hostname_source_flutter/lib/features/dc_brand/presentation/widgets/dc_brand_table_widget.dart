import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_brand_ploc.dart';
import '../pages/dc_brand_edit_page_tab.dart';

class DcBrandTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcBrandPloc>(
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
                //   label: Text('ID Brand'),
                //   numeric: true,
                //   // ! sort data memanggil REST API dengan query order by
                //   onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                //     fieldName: "id_brand",
                //     ascending: ascending,
                //     columnIndex: columnIndex,
                //   ),
                // ),
                DataColumn(
                  label: Text('Brand'),
                  // ! sort data memanggil REST API dengan query order by
                  onSort: (columnIndex, ascending) => _.sortTableUsingRESTAPI(
                        fieldName: "brand",
                        ascending: ascending,
                        columnIndex: columnIndex,
                      ),
                ),
              ],
              source: _DcBrandDataSourceRestAPI(),
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
                        DcBrandEditPageTab(),
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
class _DcBrandDataSourceRestAPI extends DataTableSource {
  @override
  DataRow getRow(int index) => Get.find<DcBrandPloc>().getDataTableRow(index);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => Get.find<DcBrandPloc>().dcBrandTable.dcBrand.length;

  @override
  int get selectedRowCount => Get.find<DcBrandPloc>().selectedDataCount;
}
