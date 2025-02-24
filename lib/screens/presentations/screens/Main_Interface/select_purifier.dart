import 'package:aqua_pure/common/QAppBar.dart';
import 'package:aqua_pure/screens/presentations/screens/Main_Interface/main_interfaceResponsive.dart';
import 'package:aqua_pure/screens/presentations/screens/purifier_manager/Purify_manager.dart';
import 'package:aqua_pure/screens/presentations/screens/purifier_manager/add%20purifier/addPurifierPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';

class MainInterFaceSelectPurifier extends StatefulWidget {
  MainInterFaceSelectPurifier({Key? key}) : super(key: key);

  @override
  _MainInterFaceSelectPurifierState createState() =>
      _MainInterFaceSelectPurifierState();
}

class _MainInterFaceSelectPurifierState
    extends State<MainInterFaceSelectPurifier> {
  late PurifierDataSource purifierDataSource;

  // Sample data for the table
  List<Purifier> _originalData = [
    Purifier(1, 'Purifier_1', 'City_1', 'Active'),
    Purifier(2, 'Purifier_2', 'City_2', 'Inactive'),
    Purifier(3, 'Purifier_3', 'City_3', 'Inactive'),
  ];

  // Dropdown for selecting a purifier
  List<String> purifierList = ['Purifier_1', 'Purifier_2', 'Purifier_3'];
  String? selectedPurifier;

  // Dropdowns for continent, country, and city
  List<String> continents = ['Asia', 'Africa', 'Europe'];
  String? selectedContinent;

  List<String> countries = ['Country A', 'Country B', 'Country C'];
  String? selectedCountry;

  List<String> cities = ['City X', 'City Y', 'City Z'];
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    // Initialize the selected values with the first element from each list
    selectedPurifier = purifierList[0];
    selectedContinent = continents[0];
    selectedCountry = countries[0];
    selectedCity = cities[0];

    purifierDataSource = PurifierDataSource(purifierData: _originalData);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("Home / Purifier Manager"),
          ),
          const SizedBox(height: 10),
          // Centered dropdown for selecting a purifier with border
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPurifier,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPurifier = newValue;
                    });
                    // Navigate to purifier screen when a purifier is selected
                    Get.to(() => Interfaceresponsive());
                  },
                  items: purifierList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Card with three dropdown buttons (Select Continent, Country, City)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedContinent,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedContinent = newValue;
                            });
                          },
                          items: continents
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          hint: const Text('Select Continent',
                              style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCountry,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountry = newValue;
                            });
                          },
                          items: countries
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          hint: const Text('Select Country',
                              style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCity,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCity = newValue;
                            });
                          },
                          items: cities
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          hint: const Text('Select City',
                              style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Expanded table (without the action column)
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
        if (e.columnName == 'Status') {
          bool isActive = e.value.toString().toLowerCase() == 'active';
          return Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 2),
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
            padding: const EdgeInsets.all(6.0),
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
