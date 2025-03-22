import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';

import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:get/get.dart';

// -------------------------------------------------------------------------
// ALARM MODEL
// -------------------------------------------------------------------------
class Alarm {
  final int id;
  final int? alarmNo;
  final String? alarmName;
  final String time;
  final String date;
  final String? description;
  final String? alarmLevel;
  final int purifierId;

  Alarm({
    required this.id,
    required this.alarmNo,
    required this.alarmName,
    required this.time,
    required this.date,
    required this.description,
    required this.alarmLevel,
    required this.purifierId,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      id: json['id'],
      alarmNo: json['alarm_no'] ?? 0,
      alarmName: json['alarm_name'],
      time: json['time'] ?? "",
      date: json['date'] ?? "",
      description: json['description'],
      alarmLevel: json['alarm_level'],
      purifierId: json['purifier_id'] ?? 0,
    );
  }
  
  // For filtering display purposes
  String get name => alarmName ?? "Alarm";
  String get moreDetails => description ?? "";
}

// -------------------------------------------------------------------------
// ALARM HISTORY CONTROLLER
// -------------------------------------------------------------------------
class AlarmHistoryController extends GetxController {
  var isLoading = false.obs;
  var alarmList = <Alarm>[].obs;
  final GetConnect _getConnect = GetConnect();

  Future<void> fetchAlarmHistory(String purifierId) async {
    try {
      isLoading.value = true;
      final response = await _getConnect.get("http://3.82.225.92:8000/alarm_history/$purifierId/");
      if (response.statusCode == 200) {
        // Parse the list of alarms from the JSON array.
        List<dynamic> jsonData = response.body;
        alarmList.value = jsonData.map((json) => Alarm.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to load alarm history");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

// -------------------------------------------------------------------------
// ALARM DATA SOURCE FOR DATA GRID
// -------------------------------------------------------------------------
class AlarmDataSource extends DataGridSource {
  AlarmDataSource({required List<Alarm> alarmData}) {
    _alarmData = alarmData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
            DataGridCell<String>(
                columnName: 'time', value: e.time.split('.')[0]),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'description', value: e.description ?? ""),
              DataGridCell<String>(columnName: 'alarmLevel', value: e.alarmLevel ?? ""),
            //  DataGridCell<String>(columnName: 'moreDetails', value: e.moreDetails),
            ]))
        .toList();
  }

  List<DataGridRow> _alarmData = [];

  @override
  List<DataGridRow> get rows => _alarmData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Text(
          e.value.toString(),
          style: TextStyle(color: TColors.textBlack),
        ),
      );
    }).toList());
  }
}

// -------------------------------------------------------------------------
// ALARM HISTORY DESKTOP SCREEN
// -------------------------------------------------------------------------
class Alarmdesktopscreen extends StatefulWidget {
  const Alarmdesktopscreen({super.key});

  @override
  State<Alarmdesktopscreen> createState() => _AlarmDesktopScreenState();
}

class _AlarmDesktopScreenState extends State<Alarmdesktopscreen> {
  late AlarmDataSource alarmDataSource;
  TextEditingController searchController = TextEditingController();

  // Global controllers for purifier list and selection.
  final PurifierController purifierController = Get.put(PurifierController());
  final PurifierSelectionController purifierSelectionController = Get.put(PurifierSelectionController());
  final AlarmHistoryController alarmHistoryController = Get.put(AlarmHistoryController());

  @override
  void initState() {
    super.initState();
    // Initially fetch alarm history if a purifier is selected.
    if (purifierSelectionController.selectedPurifierId.value.isNotEmpty) {
      alarmHistoryController.fetchAlarmHistory(purifierSelectionController.selectedPurifierId.value);
    }
    // Listen for changes in selected purifier and update alarm history.
    ever(purifierSelectionController.selectedPurifierId, (String id) {
      if (id.isNotEmpty) {
        alarmHistoryController.fetchAlarmHistory(id);
      }
    });
  }

  void filterData(String query) {
    List<Alarm> filteredData = alarmHistoryController.alarmList
        .where((alarm) =>
            (alarm.alarmName ?? "").toLowerCase().contains(query.toLowerCase()) ||
            (alarm.description ?? "").toLowerCase().contains(query.toLowerCase()) ||
            (alarm.alarmLevel ?? "").toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      alarmDataSource = AlarmDataSource(alarmData: filteredData);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Wrap UI in a Scaffold with a Row containing the side menu.
    return Scaffold(
      body: Row(
        children: [
          Container(width: 250, child: sideMenu()),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: TColors.textWhite,
                  title: Text(
                    "ALARM HISTORY",
                    style: GoogleFonts.inknutAntiqua().copyWith(
                      color: TColors.textBlack,
                      fontSize: 25,
                    ),
                  ),
                  centerTitle: false,
                  toolbarHeight: 90,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 650.0),
                      child: Obx(() {
                        // Use global purifier selection.
                        String currentPurifier = purifierSelectionController.selectedPurifierId.value;
                        if (purifierController.isLoading.value) {
                          return const CircularProgressIndicator();
                        } else if (purifierController.filteredPurifierList.isEmpty) {
                          return Text(
                            "No Purifiers",
                            style: TextStyle(color: TColors.textBlack, fontSize: 18),
                          );
                        } else {
                          return DropdownButton<String>(
                            value: currentPurifier.isEmpty ? null : currentPurifier,
                            hint: Text(
                              "Select Purifier",
                              style: TextStyle(color: TColors.textBlack, fontSize: 18),
                            ),
                            items: purifierController.filteredPurifierList
                                .map<DropdownMenuItem<String>>((purifier) {
                              return DropdownMenuItem<String>(
                                value: purifier.id.toString(),
                                child: Text(
                                  "${purifier.name} ${purifier.location}",
                                  style: TextStyle(color: TColors.textBlack, fontSize: 18),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                purifierSelectionController.updateSelection(newValue);
                              }
                            },
                            dropdownColor: TColors.textWhite,
                            style: TextStyle(color: TColors.textBlack, fontSize: 18),
                          );
                        }
                      }),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.notification),
                      onPressed: () {
                        // Notification functionality here.
                      },
                    ),
                  ],
                ),
                // Search bar row.
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: searchController,
                        onChanged: filterData,
                        decoration: InputDecoration(
                          hintText: "Search Alarm...",
                          prefixIcon: Icon(Icons.search, color: TColors.textBlack),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.notification),
                    )
                  ],
                ),
                // Data grid display.
                Expanded(
                  child: Obx(() {
                    if (alarmHistoryController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      // Create DataGridSource from fetched alarm list.
                      alarmDataSource = AlarmDataSource(alarmData: alarmHistoryController.alarmList);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SfDataGrid(
                          source: alarmDataSource,
                          columnWidthMode: ColumnWidthMode.fill,
                          columns: <GridColumn>[
                            GridColumn(
                              columnName: 'id',
                              label: Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                color: TColors.button,
                                child: const Text('SR.No.', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            GridColumn(
                              columnName: 'name',
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                color: TColors.button,
                                child: const Text('ALARM', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            GridColumn(
                              columnName: 'time',
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                color: TColors.button,
                                child: const Text('TIME', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            GridColumn(
                              columnName: 'date',
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                color: TColors.button,
                                child: const Text('DATE', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            GridColumn(
                              columnName: 'description',
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                color: TColors.button,
                                child: const Text('DESCRIPTION', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            GridColumn(
                              columnName: 'alarmLevel',
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                color: TColors.button,
                                child: const Text('ALARM LEVELS', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            // GridColumn(
                            //   columnName: 'moreDetails',
                            //   label: Container(
                            //     padding: const EdgeInsets.all(8.0),
                            //     alignment: Alignment.center,
                            //     color: TColors.button,
                            //     child: const Text('', style: TextStyle(color: Colors.white)),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
