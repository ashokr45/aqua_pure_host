import 'package:aqua_pure/common/QAppBar.dart';
import 'package:aqua_pure/features/presentations/screens/purifier_manager/add%20purifier/addPurifierPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';

class PurifierMobile extends StatefulWidget {
  PurifierMobile({Key? key}) : super(key: key);

  @override
  _PurifierMobileState createState() => _PurifierMobileState();
}

class _PurifierMobileState extends State<PurifierMobile> {
  late PurifierDataSource purifierDataSource;
  final TextEditingController _searchController = TextEditingController();
  List<Purifier> _originalData = [
    Purifier(1, 'Purifier_1', 'City_1', 'Active'),
    Purifier(2, 'Purifier_2', 'City_2', 'Inactive'),
    Purifier(3, 'Purifier_3', 'City_3', 'Inactive'),
  ];

  @override
  void initState() {
    super.initState();
    purifierDataSource = PurifierDataSource(purifierData: _originalData);
  }

  void _filterPurifiers(String query) {
    if (query.isEmpty) {
      purifierDataSource.updateData(_originalData);
      return;
    }

    final filtered = _originalData.where((purifier) {
      return purifier.name.toLowerCase().contains(query.toLowerCase()) ||
          purifier.Location.toLowerCase().contains(query.toLowerCase()) ||
          purifier.Status.toLowerCase().contains(query.toLowerCase());
    }).toList();

    purifierDataSource.updateData(filtered);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: QAppBar(
          menuIcon: Iconsax.menu_1,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          notificationIcon: Iconsax.notification,
          userIcon: Iconsax.user,
          title: 'Purifier Manager'),
      drawer: sideMenu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("Home / Purifier Manager"),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      height: 40, // Set custom height
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        color: Colors.white, // Set background color here
                        borderRadius: BorderRadius.circular(
                            8), // Optional: round the corners
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterPurifiers,
                        decoration: InputDecoration(
                          hintText: 'Search purifiers...',
                          prefixIcon:
                              Icon(Iconsax.search_normal, color: Colors.green),
                          // Set the border color and width
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.green, // Set border color here
                              width: 1, // Set border width here
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors
                                  .green.shade700, // Border color when focused
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.green
                                  .shade300, // Border color when not focused
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                        ),
                      )),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => AddPurifierPage());
                    // Add purifier logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(
                    Iconsax.add,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text('Add Purifier'),
                ),
              ],
            ),
          ),
          Expanded(
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
                        child: Text(
                          'SO.NO.',
                          style: TextStyle(color: Colors.white),
                        ))),
                GridColumn(
                    columnName: 'name',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: Text('Purifier Name',
                            style: TextStyle(color: Colors.white)))),
                GridColumn(
                    columnName: 'Location',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: Text(
                          'Location',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ))),
                GridColumn(
                    columnName: 'Status',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: Text('Status',
                            style: TextStyle(color: Colors.white)))),
                GridColumn(
                    columnName: 'Edit',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        color: TColors.button,
                        child: Text('Action',
                            style: TextStyle(color: Colors.white)))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Purifier {
  Purifier(this.id, this.name, this.Location, this.Status);

  final int id;
  final String name;
  final String Location;
  final String Status;
}

class PurifierDataSource extends DataGridSource {
  PurifierDataSource({required List<Purifier> purifierData}) {
    updateData(purifierData);
  }

  List<DataGridRow> _purifierData = [];

  void updateData(List<Purifier> purifierData) {
    _purifierData = purifierData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'Location', value: e.Location),
              DataGridCell<String>(columnName: 'Status', value: e.Status),
              DataGridCell<Row>(
                columnName: 'Edit',
                value: Row(
                  children: [
                    Icon(Iconsax.edit),
                    Icon(Iconsax.trash),
                  ],
                ),
              ),
            ]))
        .toList();
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => _purifierData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'Edit') {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Edit button clicked for ${row.getCells()[1].value}');
                  },
                  child: Icon(Iconsax.edit, size: 16, color: Colors.green),
                ),
                SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    print(
                        'Delete button clicked for ${row.getCells()[1].value}');
                  },
                  child: Icon(Iconsax.trash, size: 16, color: Colors.red),
                ),
              ],
            ),
          );
        } else if (e.columnName == 'Status') {
          bool isActive = e.value.toString().toLowerCase() == 'active';
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              e.value.toString(),
              style: TextStyle(
                color: isActive ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(6.0),
            color: Colors.white,
            child: Text(
              e.value.toString(),
              style: TextStyle(color: TColors.textBlack, fontSize: 12),
            ),
          );
        }
      }).toList(),
    );
  }
}
