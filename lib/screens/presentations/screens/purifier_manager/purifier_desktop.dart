import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/screens/presentations/screens/AddPurifier/AddPurifierDesktop.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/purifier_model.dart';
import '../../../../apis/purifier_apis.dart';

class PurifierDesktop extends StatefulWidget {
  const PurifierDesktop({Key? key}) : super(key: key);

  @override
  _PurifierDesktopState createState() => _PurifierDesktopState();
}

class _PurifierDesktopState extends State<PurifierDesktop> {
  final PurifierController purifierController = Get.put(PurifierController());
  late PurifierDataSource purifierDataSource;
  final TextEditingController searchController = TextEditingController();

  String? _sortColumn;
  DataGridSortDirection _sortDirection = DataGridSortDirection.ascending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.3),
      body: Row(
        children: [
          SizedBox(
            width: 250,
            child: sideMenu(),
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: TColors.textWhite,
                  title: Text(
                    "PURIFIER MANAGER",
                    style: GoogleFonts.inknutAntiqua().copyWith(
                      color: TColors.textBlack,
                      fontSize: 25,
                    ),
                  ),
                  centerTitle: false,
                  toolbarHeight: 90,
                  actions: [
                    IconButton(
                      icon: const Icon(Iconsax.notification),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            purifierController.filterPurifiers(value);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search Purifiers...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => AddPurifierDesktop());
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Add Purifier',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (purifierController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    purifierDataSource = PurifierDataSource(
                      purifierData: purifierController.filteredPurifierList,
                      sortColumn: _sortColumn,
                      sortDirection: _sortDirection,
                    );
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SfDataGrid(
                        source: purifierDataSource,
                        columnWidthMode: ColumnWidthMode.fill,
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'id',
                            label: Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('id');
                                  purifierController.sortPurifiers('id');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'SO.No.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    _buildSortIcon('id'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'serialno',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('serialno');
                                  purifierController.sortPurifiers('serialno');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Serial Number',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    _buildSortIcon('serialno'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'systemModelNumber',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('systemModelNumber');
                                  purifierController.sortPurifiers('systemModelNumber');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Sales Model Number',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    _buildSortIcon('systemModelNumber'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'name',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('name');
                                  purifierController.sortPurifiers('name');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Purifier Name',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    _buildSortIcon('name'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'manufactureDate',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('manufactureDate');
                                  purifierController.sortPurifiers('manufactureDate');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'MFR. Date',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    _buildSortIcon('manufactureDate'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'location',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('location');
                                  purifierController.sortPurifiers('location');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Location',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    _buildSortIcon('location'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'status',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: InkWell(
                                onTap: () {
                                  _handleSort('status');
                                  purifierController.sortPurifiers('status');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Status',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    _buildSortIcon('status'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Action',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: TColors.button,
                              child: const Text(
                                'Action',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSort(String columnName) {
    setState(() {
      if (_sortColumn == columnName) {
        _sortDirection = _sortDirection == DataGridSortDirection.ascending
            ? DataGridSortDirection.descending
            : DataGridSortDirection.ascending;
      } else {
        _sortColumn = columnName;
        _sortDirection = DataGridSortDirection.ascending;
      }
    });
  }

  Widget _buildSortIcon(String columnName) {
    if (_sortColumn == columnName) {
      return Icon(
        _sortDirection == DataGridSortDirection.ascending
            ? Icons.arrow_upward
            : Icons.arrow_downward,
        color: Colors.white,
        size: 16,
      );
    }
    return const Icon(Icons.sort, color: Colors.white, size: 16);
  }
}

class PurifierDataSource extends DataGridSource {
  late List<Purifier> _purifierData;

  PurifierDataSource({
    required List<Purifier> purifierData,
    String? sortColumn,
    DataGridSortDirection sortDirection = DataGridSortDirection.ascending,
  }) {
    _purifierData = purifierData;
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void buildDataGridRows() {
    _dataGridRows = _purifierData.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: e.id),
        DataGridCell<String>(columnName: 'serialno', value: e.serialno),
        DataGridCell<String>(columnName: 'systemModelNumber', value: e.systemModelNumber),
        DataGridCell<String>(columnName: 'name', value: e.name),
        DataGridCell<String>(columnName: 'manufactureDate', value: e.manufactureDate),
        DataGridCell<String>(columnName: 'location', value: e.location),
        DataGridCell<String>(columnName: 'status', value: e.status),
        DataGridCell<Widget>(
          columnName: 'Action',
          value: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Iconsax.edit, color: Colors.green),
                onPressed: () {
                  Get.to(() => AddPurifierDesktop(purifier: e));
                },
              ),
              IconButton(
                icon: const Icon(Iconsax.trash, color: Colors.red),
                onPressed: () async {
                  try {
                    await PurifierApi.deletePurifier(e.id);
                    Get.find<PurifierController>().fetchPurifiers();
                                 Get.snackbar(
        'Success',
        'Purifier deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
                  } catch (e) {
                    Get.snackbar('Error', 'Failed to delete purifier: $e');
                  }
                },
              ),
            ],
          ),
        ),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'status') {
          final status = dataCell.value.toString();
          final bgColor = status.toLowerCase() == 'active'
              ? const Color.fromARGB(255, 170, 216, 116)
              : const Color.fromARGB(255, 222, 113, 105);
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        } else if (dataCell.columnName == 'Action') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: dataCell.value as Widget,
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Text(
              dataCell.value.toString(),
              style: TextStyle(color: TColors.textBlack),
            ),
          );
        }
      }).toList(),
    );
  }
}