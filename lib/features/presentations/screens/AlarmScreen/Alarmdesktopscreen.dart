// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//
// import '../../../../common/sideMenu.dart';
// import '../../../../utils/constants/colors.dart';
//
// class Alarmdesktopscreen extends StatefulWidget {
//   const Alarmdesktopscreen({super.key});
//
//   @override
//   State<Alarmdesktopscreen> createState() => _AlarmdesktopscreenState();
// }
//
// class _AlarmdesktopscreenState extends State<Alarmdesktopscreen> {
//   late AlarmDataSource alarmDataSource;
//   String? selectedValue;
//   final List<String> dropdownOptions = ["PURIFIER 1001", "PURIFIER 1002", "PURIFIER 1003"];
//
//   @override
//   void initState() {
//     super.initState();
//     alarmDataSource = AlarmDataSource(alarmData: [
//       Alarm(1, 'Alarm_1', '9:21AM', '2024-01-01', 'Feed Pump Fault', 'Critical', 'More details'),
//       Alarm(2, 'Alarm_2', '9:21AM', '2024-01-01', 'Feed Pump Fault', 'Warning', 'More details'),
//       Alarm(3, 'Alarm_3', '9:21AM', '2024-01-01', 'Feed Pump Fault', 'Information', 'More details'),
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Row(children: [
//           Container(
//             width: 250,
//             child: sideMenu(),
//           ),
//           Expanded(
//             child: Column(
//               children: [
//                 AppBar(
//                   backgroundColor: TColors.textWhite,
//                   title: Text(
//                     "ALARM HISTORY",
//                     style: GoogleFonts.inknutAntiqua().copyWith(
//                       color: TColors.textBlack, // Custom text color
//                       fontSize: 25, // Custom font size
//                     ),
//                   ),
//                   centerTitle: false,
//                   toolbarHeight: 90,
//                   actions: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 650.0),
//                       child: DropdownButton<String>(
//                         value: selectedValue,
//                         hint: Text(
//                           "Select Purifier",
//                           style: TextStyle(color: TColors.textBlack, fontSize: 18),
//                         ),
//                         items: dropdownOptions.map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedValue = newValue;
//                           });
//                         },
//                         dropdownColor: TColors.textWhite,
//                         style: TextStyle(color: TColors.textBlack, fontSize: 18),
//                       ),
//                     ),
//
//                     IconButton(
//                       icon: const Icon(Iconsax.notification),
//                       onPressed: () {
//                         // Add your notification functionality here
//                       },
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SfDataGrid(
//                           source: alarmDataSource,
//                           columnWidthMode: ColumnWidthMode.fill,
//                           columns: <GridColumn>[
//                             GridColumn(
//                               columnName: 'id',
//                               label: Container(
//                                 padding: EdgeInsets.all(16.0),
//                                 alignment: Alignment.center,
//                                 color: TColors.button,
//                                 child: Text(
//                                   'SR.No.',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                             GridColumn(
//                               columnName: 'name',
//                               label: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 color: TColors.button,
//                                 child: Text('ALARM',
//                                     style: TextStyle(color: Colors.white)),
//                               ),
//                             ),
//                             GridColumn(
//                               columnName: 'DateTime',
//                               label: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 color: TColors.button,
//                                 child: Text(
//                                   'TIME',
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                             GridColumn(
//                               columnName: 'date',
//                               label: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 color: TColors.button,
//                                 child: Text('DATE',
//                                     style: TextStyle(color: Colors.white)),
//                               ),
//                             ),
//                             GridColumn(
//                               columnName: 'description',
//                               label: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 color: TColors.button,
//                                 child: Text('DESC..',
//                                     style: TextStyle(color: Colors.white)),
//                               ),
//                             ),
//                             GridColumn(
//                               columnName: 'alarmLevel',
//                               label: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 color: TColors.button,
//                                 child: Text('ALARM LEVELS',
//                                     style: TextStyle(color: Colors.white)),
//                               ),
//                             ),
//                             GridColumn(
//                               columnName: 'moreDetails',
//                               label: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 color: TColors.button,
//                                 child: Text('',
//                                     style: TextStyle(color: Colors.white)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ]));
//   }
// }
//
// class Alarm {
//   Alarm(this.id, this.name, this.DateTime, this.date, this.description, this.alarmLevel, this.moreDetails);
//
//   final int id;
//   final String name;
//   final String DateTime;
//   final String date;
//   final String description;
//   final String alarmLevel;
//   final String moreDetails;
// }
//
// class AlarmDataSource extends DataGridSource {
//   AlarmDataSource({required List<Alarm> alarmData}) {
//     _alarmData = alarmData
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//       DataGridCell<int>(columnName: 'id', value: e.id),
//       DataGridCell<String>(columnName: 'name', value: e.name),
//       DataGridCell<String>(columnName: 'DateTime', value: e.DateTime),
//       DataGridCell<String>(columnName: 'date', value: e.date),
//       DataGridCell<String>(columnName: 'description', value: e.description),
//       DataGridCell<String>(columnName: 'alarmLevel', value: e.alarmLevel),
//       DataGridCell<String>(columnName: 'moreDetails', value: e.moreDetails),
//     ]))
//         .toList();
//   }
//
//   List<DataGridRow> _alarmData = [];
//
//   @override
//   List<DataGridRow> get rows => _alarmData;
//
//
//
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((e) {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(8.0),
//             color: Colors.white,
//             child: Text(
//               e.value.toString(),
//               style: TextStyle(color: TColors.textBlack),
//             ),
//           );
//         }).toList());
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';

class Alarmdesktopscreen extends StatefulWidget {
  const Alarmdesktopscreen({super.key});

  @override
  State<Alarmdesktopscreen> createState() => _AlarmdesktopscreenState();
}

class _AlarmdesktopscreenState extends State<Alarmdesktopscreen> {
  late AlarmDataSource alarmDataSource;
  String? selectedValue;
  TextEditingController searchController = TextEditingController();
  final List<String> dropdownOptions = ["PURIFIER 1001", "PURIFIER 1002", "PURIFIER 1003"];
  List<Alarm> originalAlarmData = [];

  @override
  void initState() {
    super.initState();
    originalAlarmData = [
      Alarm(1, 'Alarm_1', '9:21AM', '2024-01-01', 'Feed Pump Fault', 'Critical', 'More details'),
      Alarm(2, 'Alarm_2', '9:21AM', '2024-01-01', 'Feed Pump Fault', 'Warning', 'More details'),
      Alarm(3, 'Alarm_3', '9:21AM', '2024-01-01', 'Feed Pump Fault', 'Information', 'More details'),
    ];
    alarmDataSource = AlarmDataSource(alarmData: originalAlarmData);
  }

  void filterData(String query) {
    List<Alarm> filteredData = originalAlarmData
        .where((alarm) => alarm.name.toLowerCase().contains(query.toLowerCase()) ||
        alarm.description.toLowerCase().contains(query.toLowerCase()) ||
        alarm.alarmLevel.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      alarmDataSource = AlarmDataSource(alarmData: filteredData);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      child: DropdownButton<String>(
                        value: selectedValue,
                        hint: Text("Select Purifier",
                            style: TextStyle(color: TColors.textBlack, fontSize: 18)),
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
                        // Add notification functionality here
                      },
                    ),
                  ],
                ),
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
                      IconButton(onPressed: (){}, icon: Icon(Iconsax.notification))
                    ],
                  ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfDataGrid(
                      source: alarmDataSource,
                      columnWidthMode: ColumnWidthMode.fill,
                      columns: <GridColumn>[
                        GridColumn(
                          columnName: 'id',
                          label: Container(
                            padding: EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('SR.No.', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'name',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('ALARM', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'DateTime',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('TIME', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'date',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('DATE', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'description',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('DESC..', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'alarmLevel',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('ALARM LEVELS', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'moreDetails',
                          label: Container(
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            color: TColors.button,
                            child: Text('', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Alarm {
  Alarm(this.id, this.name, this.DateTime, this.date, this.description, this.alarmLevel, this.moreDetails);

  final int id;
  final String name;
  final String DateTime;
  final String date;
  final String description;
  final String alarmLevel;
  final String moreDetails;
}

class AlarmDataSource extends DataGridSource {
  AlarmDataSource({required List<Alarm> alarmData}) {
    _alarmData = alarmData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(columnName: 'DateTime', value: e.DateTime),
      DataGridCell<String>(columnName: 'date', value: e.date),
      DataGridCell<String>(columnName: 'description', value: e.description),
      DataGridCell<String>(columnName: 'alarmLevel', value: e.alarmLevel),
      DataGridCell<String>(columnName: 'moreDetails', value: e.moreDetails),
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
            padding: EdgeInsets.all(8.0),
            color: Colors.white,
            child: Text(
              e.value.toString(),
              style: TextStyle(color: TColors.textBlack),
            ),
          );
        }).toList());
  }
}
