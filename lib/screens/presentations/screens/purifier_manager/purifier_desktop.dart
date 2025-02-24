import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';
import '../AddPurifier/AddPurifierDesktop.dart';

class PurifierDesktop extends StatefulWidget {
  const PurifierDesktop({super.key});

  @override
  _PurifierDesktopState createState() => _PurifierDesktopState();
}

class _PurifierDesktopState extends State<PurifierDesktop> {
  late PurifierDataSource purifierDataSource;
  late List<Purifier> purifierList; // Original list of purifiers
  late List<Purifier> filteredPurifierList; // Filtered list of purifiers
  final TextEditingController searchController = TextEditingController();

  // Sorting state variables
  String? _sortColumn;
  DataGridSortDirection _sortDirection = DataGridSortDirection.ascending;

  @override
  void initState() {
    super.initState();
    purifierList = [
      Purifier(1, 'Purifier_1', 'City_1', 'Active', '20-11-2024', 1001),
      Purifier(2, 'Purifier_2', 'City_2', 'Inactive', '18-11-2024', 1002),
      Purifier(3, 'Purifier_3', 'City_3', 'Inactive', '11-11-2024', 1003),
    ];
    filteredPurifierList = List.from(purifierList);
    purifierDataSource = PurifierDataSource(
      purifierData: filteredPurifierList,
      sortColumn: _sortColumn,
      sortDirection: _sortDirection,
    );
  }

  void filterPurifiers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPurifierList = List.from(purifierList);
      } else {
        filteredPurifierList = purifierList
            .where((purifier) =>
                purifier.name.toLowerCase().contains(query.toLowerCase()) ||
                purifier.Location.toLowerCase().contains(query.toLowerCase()) ||
                purifier.serialno.toString().contains(query) ||
                purifier.date.contains(query))
            .toList();
      }
      purifierDataSource = PurifierDataSource(
        purifierData: filteredPurifierList,
        sortColumn: _sortColumn,
        sortDirection: _sortDirection,
      );
    });
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
      purifierDataSource = PurifierDataSource(
        purifierData: filteredPurifierList,
        sortColumn: _sortColumn,
        sortDirection: _sortDirection,
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.3),
      body: Row(
        children: [
          // Side Menu
          Container(
            width: 250,
            child: sideMenu(),
          ),
          // Main Content Area
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
                      onPressed: () {
                        // Notification functionality here
                      },
                    ),
                  ],
                ),
                // Search Field and Add Button
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
                          onChanged: filterPurifiers,
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
                // DataGrid Table
                Expanded(
                  child: Padding(
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
                              onTap: () => _handleSort('id'),
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
                              onTap: () => _handleSort('serialno'),
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
                          columnName: 'name',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('name'),
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
                          columnName: 'date',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('date'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'MFR. Date',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  _buildSortIcon('date'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Location',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('Location'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Location',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  _buildSortIcon('Location'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Status',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('Status'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Status',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  _buildSortIcon('Status'),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Purifier {
  Purifier(this.id, this.name, this.Location, this.Status, this.date, this.serialno);

  final int id;
  final int serialno;
  final String name;
  final String Location;
  final String Status;
  final String date;
}

class PurifierDataSource extends DataGridSource {
  late List<Purifier> _originalPurifierData;
  List<DataGridRow> _purifierData = [];

  PurifierDataSource({
    required List<Purifier> purifierData,
    String? sortColumn,
    DataGridSortDirection sortDirection = DataGridSortDirection.ascending,
  }) {
    _originalPurifierData = purifierData;
    List<Purifier> sorted =
        _sortPurifiers(purifierData, sortColumn, sortDirection);
    _purifierData = sorted
        .map<DataGridRow>(
          (e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: 'id', value: e.id),
            DataGridCell<int>(columnName: 'serialno', value: e.serialno),
            DataGridCell<String>(columnName: 'name', value: e.name),
            DataGridCell<String>(columnName: 'date', value: e.date),
            DataGridCell<String>(columnName: 'Location', value: e.Location),
            DataGridCell<String>(columnName: 'Status', value: e.Status),
            DataGridCell<Widget>(
              columnName: 'Action',
              value: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.edit, color: Colors.green),
                    onPressed: () {
                      print('Edit button clicked for ${e.name}');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.trash, color: Colors.red),
                    onPressed: () {
                      print('Delete button clicked for ${e.name}');
                    },
                  ),
                ],
              ),
            ),
          ]),
        )
        .toList();
  }

  List<Purifier> get purifierList => _originalPurifierData;

  @override
  List<DataGridRow> get rows => _purifierData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'Status') {
          final status = e.value.toString();
          final bgColor = status.toLowerCase() == 'active'
              ? const Color.fromARGB(255, 170, 216, 116)
              : const Color.fromARGB(255, 222, 113, 105);
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
        } else if (e.columnName == 'Action') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: e.value as Widget,
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Text(
              e.value.toString(),
              style: TextStyle(color: TColors.textBlack),
            ),
          );
        }
      }).toList(),
    );
  }

  List<Purifier> _sortPurifiers(
      List<Purifier> purifiers, String? sortColumn, DataGridSortDirection sortDirection) {
    if (sortColumn == null) return purifiers;
    List<Purifier> sorted = List.from(purifiers);
    sorted.sort((a, b) {
      dynamic aValue;
      dynamic bValue;
      switch (sortColumn) {
        case 'id':
          aValue = a.id;
          bValue = b.id;
          break;
        case 'serialno':
          aValue = a.serialno;
          bValue = b.serialno;
          break;
        case 'name':
          aValue = a.name;
          bValue = b.name;
          break;
        case 'date':
          aValue = a.date;
          bValue = b.date;
          break;
        case 'Location':
          aValue = a.Location;
          bValue = b.Location;
          break;
        case 'Status':
          aValue = a.Status;
          bValue = b.Status;
          break;
        default:
          return 0;
      }
      int compareResult;
      if (aValue is int && bValue is int) {
        compareResult = aValue.compareTo(bValue);
      } else {
        compareResult = aValue.toString().compareTo(bValue.toString());
      }
      return sortDirection == DataGridSortDirection.ascending
          ? compareResult
          : -compareResult;
    });
    return sorted;
  }
}
