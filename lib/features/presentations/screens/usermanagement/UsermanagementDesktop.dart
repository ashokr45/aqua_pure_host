import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adduser.dart';

class Usermanagementdesktop extends StatefulWidget {
  const Usermanagementdesktop({super.key});

  @override
  _UsermanagementdesktopState createState() => _UsermanagementdesktopState();
}

class _UsermanagementdesktopState extends State<Usermanagementdesktop> {
  late PurifierDataSource purifierDataSource;
  late List<Purifier> allPurifiers;
  TextEditingController searchController = TextEditingController();
  String? _sortColumn;
  DataGridSortDirection _sortDirection = DataGridSortDirection.ascending;

  @override
  void initState() {
    super.initState();
    // Note: Passing context in the Purifier constructor is preserved to keep functionality.
    allPurifiers = [
      Purifier(1, 'UserName1', 'Name1', 'Customer', '1', context, 'CityName_1', 'Active'),
      Purifier(2, 'UserName2', 'Name2', 'Manager', '1', context, 'CityName_2', 'Active'),
      Purifier(3, 'UserName3', 'Name3', 'Operator', '2', context, 'CityName_3', 'Inactive'),
      Purifier(4, 'UserName4', 'Name4', 'Pure Aqua User', '1', context, 'CityName_4', 'Inactive'),
    ];
    purifierDataSource = PurifierDataSource(
      purifierData: allPurifiers,
      context: context,
      sortColumn: _sortColumn,
      sortDirection: _sortDirection,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterPurifiers(String query) {
    final filteredPurifiers = allPurifiers.where((purifier) =>
        purifier.CustomerName.toLowerCase().contains(query.toLowerCase()) ||
        purifier.UserName.toLowerCase().contains(query.toLowerCase()) ||
        purifier.Status.toLowerCase().contains(query.toLowerCase())).toList();

    setState(() {
      purifierDataSource = PurifierDataSource(
        purifierData: filteredPurifiers,
        context: context,
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
        purifierData: purifierDataSource.purifierList,
        context: context,
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
    return Icon(Icons.sort, color: Colors.white, size: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.3),
      body: Row(
        children: [
          Container(
            width: 250,
            child: sideMenu(),
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: TColors.textWhite,
                  title: Text(
                    "USER MANAGEMENT",
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
                          onChanged: filterPurifiers,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search by name, username or role...',
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AddUserDialog(),
                            );
                          },
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text('Add User', style: TextStyle(color: Colors.white)),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfDataGrid(
                      source: purifierDataSource,
                      columnWidthMode: ColumnWidthMode.fill,
                      columns: <GridColumn>[
                        GridColumn(
                          columnName: 'id',
                          label: Container(
                            padding: EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('ID', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'CustomerName',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('CustomerName'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Customer Name', style: TextStyle(color: Colors.white)),
                                  _buildSortIcon('CustomerName'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'User Name',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('User Name'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Username', style: TextStyle(color: Colors.white)),
                                  _buildSortIcon('User Name'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Role',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('Role'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Role', style: TextStyle(color: Colors.white)),
                                  _buildSortIcon('Role'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'No. of System',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('No. of System'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('No. of System', style: TextStyle(color: Colors.white)),
                                  _buildSortIcon('No. of System'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Location',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('Location'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Location', style: TextStyle(color: Colors.white)),
                                  _buildSortIcon('Location'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Status',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: InkWell(
                              onTap: () => _handleSort('Status'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Status', style: TextStyle(color: Colors.white)),
                                  _buildSortIcon('Status'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Action',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('Action', style: TextStyle(color: Colors.white)),
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
  Purifier(this.id, this.CustomerName, this.UserName, this.Status, this.Date, this.context, this.System, this.Location);

  final int id;
  final String CustomerName;
  final String UserName;
  final String Status;
  final String Date;
  final String System;
  final String Location;
  final BuildContext context;
}

class PurifierDataSource extends DataGridSource {
  late List<Purifier> _originalPurifierData;
  List<DataGridRow> _purifierData = [];
  final BuildContext context;
  final String? sortColumn;
  final DataGridSortDirection sortDirection;

  PurifierDataSource({
    required List<Purifier> purifierData,
    required this.context,
    this.sortColumn,
    this.sortDirection = DataGridSortDirection.ascending,
  }) {
    _originalPurifierData = purifierData;
    _purifierData = _sortPurifiers(purifierData, sortColumn, sortDirection)
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'CustomerName', value: e.CustomerName),
              DataGridCell<String>(columnName: 'User Name', value: e.UserName),
              // 'Role' column displays the Status field
              DataGridCell<String>(columnName: 'Role', value: e.Status),
              // 'No. of System' column displays the Date field (assumed numeric)
              DataGridCell<String>(columnName: 'No. of System', value: e.Date),
              // 'Location' column displays the System field (assumed to hold a city name)
              DataGridCell<String>(columnName: 'Location', value: e.System),
              // 'Status' column displays the Location field (assumed Active/Inactive)
              DataGridCell<String>(columnName: 'Status', value: e.Location),
              DataGridCell<Widget>(
                columnName: 'Action',
                value: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Iconsax.edit, color: Colors.green),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddUserDialog(
                              CustomerName: e.CustomerName,
                              userName: e.UserName,
                              email: "Example@example.com",
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Iconsax.trash, color: Colors.red),
                      onPressed: () {
                        print('Delete button clicked for ${e.UserName}');
                      },
                    ),
                  ],
                ),
              ),
            ]))
        .toList();
  }

  // Getter to retrieve the original (or filtered) list of Purifier objects
  List<Purifier> get purifierList => _originalPurifierData;

  @override
  List<DataGridRow> get rows => _purifierData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        // Wrap all cell content in a white Container to ensure uniform appearance.
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          child: dataGridCell.value is Widget
              ? dataGridCell.value as Widget
              : Text(
                  dataGridCell.value.toString(),
                  style: TextStyle(color: TColors.textBlack),
                ),
        );
      }).toList(),
    );
  }

  List<Purifier> _sortPurifiers(List<Purifier> purifiers, String? sortColumn, DataGridSortDirection sortDirection) {
    if (sortColumn == null) return purifiers;

    List<Purifier> sorted = List.from(purifiers);
    sorted.sort((a, b) {
      dynamic aValue;
      dynamic bValue;
      switch (sortColumn) {
        case 'CustomerName':
          aValue = a.CustomerName;
          bValue = b.CustomerName;
          break;
        case 'User Name':
          aValue = a.UserName;
          bValue = b.UserName;
          break;
        case 'Role':
          aValue = a.Status;
          bValue = b.Status;
          break;
        case 'No. of System':
          aValue = int.tryParse(a.Date) ?? 0;
          bValue = int.tryParse(b.Date) ?? 0;
          break;
        case 'Location':
          aValue = a.System;
          bValue = b.System;
          break;
        case 'Status':
          aValue = a.Location;
          bValue = b.Location;
          break;
        default:
          return 0;
      }

      int compareResult;
      if (aValue is String && bValue is String) {
        compareResult = aValue.compareTo(bValue);
      } else if (aValue is int && bValue is int) {
        compareResult = aValue.compareTo(bValue);
      } else {
        compareResult = 0;
      }

      return sortDirection == DataGridSortDirection.ascending ? compareResult : -compareResult;
    });

    return sorted;
  }
}
