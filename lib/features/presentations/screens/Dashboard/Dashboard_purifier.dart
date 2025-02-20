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
  // Dropdown state variables for purifier selection and location filtering
  String? selectedValue = 'PURIFIER 1001';
  String? selected1Value = 'Asia';
  String? selected2Value = 'India';
  String? selected3Value = 'Mumbai';

  final List<String> dropdownOptions = ["PURIFIER 1001", "PURIFIER 1002", "PURIFIER 1003"];
  final List<String> dropdownOptions1 = ["Asia", "Africa", "Russia"];
  final List<String> dropdownOptions2 = ["India", "Russia", "China"];
  final List<String> dropdownOptions3 = ["Delhi", "Mumbai", "Hyderabad"];

  final TextEditingController searchController = TextEditingController();

  late PurifierDataSource purifierDataSource;
  late List<Purifier> purifierList; // Original list of purifiers
  late List<Purifier> filteredPurifierList; // Filtered list of purifiers

  @override
  void initState() {
    super.initState();
    purifierList = [
      Purifier(1, 'Purifier_1', 'City_1', 'Active', '20-11-2024', 1001),
      Purifier(2, 'Purifier_2', 'City_2', 'Inactive', '18-11-2024', 1002),
      Purifier(3, 'Purifier_3', 'City_3', 'Inactive', '11-11-2024', 1003),
    ];
    filteredPurifierList = List.from(purifierList);
    purifierDataSource = PurifierDataSource(purifierData: filteredPurifierList);
  }

  void filterPurifiers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPurifierList = List.from(purifierList);
      } else {
        filteredPurifierList = purifierList.where((purifier) {
          return purifier.name.toLowerCase().contains(query.toLowerCase()) ||
              purifier.Location.toLowerCase().contains(query.toLowerCase()) ||
              purifier.serialno.toString().contains(query) ||
              purifier.date.contains(query);
        }).toList();
      }
      purifierDataSource = PurifierDataSource(purifierData: filteredPurifierList);
    });
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
                // Top AppBar with Purifier selection dropdown & notification icon
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
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: DropdownButton<String>(
                        value: selectedValue,
                        hint: Text(
                          "Select Purifier",
                          style: TextStyle(color: TColors.textBlack, fontSize: 18),
                        ),
                        items: dropdownOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                        dropdownColor: TColors.textWhite,
                        style: TextStyle(color: TColors.textBlack, fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.notification),
                      onPressed: () {
                        // Notification functionality here
                      },
                    ),
                  ],
                ),
                // Row with Location Filter Dropdowns
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Continent Dropdown
                      Container(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Continent",
                              style: GoogleFonts.inknutAntiqua().copyWith(
                                color: TColors.textBlack,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              color: TColors.textWhite,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selected1Value,
                                items: dropdownOptions1.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selected1Value = newValue;
                                  });
                                },
                                dropdownColor: TColors.textWhite,
                                style: TextStyle(color: TColors.textBlack, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Country Dropdown
                      Container(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Country",
                              style: GoogleFonts.inknutAntiqua().copyWith(
                                color: TColors.textBlack,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              color: TColors.textWhite,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selected2Value,
                                items: dropdownOptions2.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selected2Value = newValue;
                                  });
                                },
                                dropdownColor: TColors.textWhite,
                                style: TextStyle(color: TColors.textBlack, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // City Dropdown
                      Container(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select City",
                              style: GoogleFonts.inknutAntiqua().copyWith(
                                color: TColors.textBlack,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              color: TColors.textWhite,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selected3Value,
                                items: dropdownOptions3.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selected3Value = newValue;
                                  });
                                },
                                dropdownColor: TColors.textWhite,
                                style: TextStyle(color: TColors.textBlack, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Row with Search Field and Add Purifier Button
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
                      // SizedBox(
                      //   width: 150,
                      //   height: 45,
                      //   child: ElevatedButton.icon(
                      //     onPressed: () {
                      //       Get.to(() => Addpurifierdesktop());
                      //     },
                      //     icon: const Icon(Icons.add, color: Colors.white),
                      //     label: const Text(
                      //       'Add Purifier',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.green,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // DataGrid Table (without the Action column)
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
                            child: const Text(
                              'SO.No.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'serialno',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: const Text('Serial Number',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'name',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: const Text('Purifier Name',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'date',
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: const Text('MFR. Date',
                                style: TextStyle(color: Colors.white)),
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
                            child: const Text('Status',
                                style: TextStyle(color: Colors.white)),
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
  PurifierDataSource({required List<Purifier> purifierData}) {
    _purifierData = purifierData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<int>(columnName: 'serialno', value: e.serialno),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'Location', value: e.Location),
              DataGridCell<String>(columnName: 'Status', value: e.Status),
            ]))
        .toList();
  }

  List<DataGridRow> _purifierData = [];

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
          color: Colors.white, // Outer container background
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

  }

