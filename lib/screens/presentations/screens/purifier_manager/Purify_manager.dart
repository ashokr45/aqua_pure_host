import 'package:aqua_pure/common/QAppBar.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/screens/presentations/screens/purifier_manager/add%20purifier/addPurifierPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final PurifierController purifierController = Get.put(PurifierController());
  late PurifierDataSource purifierDataSource;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with an empty list; it will be updated once the API data is loaded.
    purifierDataSource = PurifierDataSource(purifierData: []);
  }

  void _filterPurifiers(String query) {
    purifierController.filterPurifiers(query);
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
        title: 'Purifier Manager',
      ),
      drawer: sideMenu(),
      body: Obx(() {
        if (purifierController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // Update the data source using the filtered purifier list from the controller.
        purifierDataSource.updateData(purifierController.filteredPurifierList);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Home / Purifier Manager"),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterPurifiers,
                        decoration: InputDecoration(
                          hintText: 'Search purifiers...',
                          prefixIcon: Icon(Iconsax.search_normal, color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.green.shade300,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => AddPurifierPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Iconsax.add, size: 18, color: Colors.white),
                    label: const Text('Add Purifier'),
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
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      color: TColors.button,
                      child: const Text(
                        'SO.NO.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'name',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      color: TColors.button,
                      child: const Text(
                        'Purifier Name',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Location',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      color: TColors.button,
                      child: const Text(
                        'Location',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Status',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      color: TColors.button,
                      child: const Text(
                        'Status',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'Edit',
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
          ],
        );
      }),
    );
  }
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
              DataGridCell<String>(columnName: 'Location', value: e.location),
              DataGridCell<String>(columnName: 'Status', value: e.status),
              DataGridCell<Row>(
                columnName: 'Edit',
                value: Row(
                  children: const [
                    Icon(Iconsax.edit),
                    SizedBox(width: 4),
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
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Edit button clicked for ${row.getCells()[1].value}');
                  },
                  child: const Icon(Iconsax.edit, size: 16, color: Colors.green),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    print('Delete button clicked for ${row.getCells()[1].value}');
                  },
                  child: const Icon(Iconsax.trash, size: 16, color: Colors.red),
                ),
              ],
            ),
          );
        } else if (e.columnName == 'Status') {
          bool isActive = e.value.toString().toLowerCase() == 'active';
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: isActive ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
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
            padding: const EdgeInsets.all(6.0),
            color: Colors.white,
            child: Text(
              e.value.toString(),
              style: const TextStyle(color: TColors.textBlack, fontSize: 12),
            ),
          );
        }
      }).toList(),
    );
  }
}
