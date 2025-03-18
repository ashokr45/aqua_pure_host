// // import 'package:aqua_pure/common/sideMenu.dart';
// // import 'package:aqua_pure/features/presentations/screens/Dashboard/Graph.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:iconsax/iconsax.dart';
// //
// // import '../../../../common/QAppBar.dart';
// // import '../../../../utils/constants/colors.dart';
// //
// // class DataTableDesktop extends StatefulWidget {
// //   DataTableDesktop({super.key});
// //
// //   @override
// //   _DataTableDesktopState createState() => _DataTableDesktopState();
// // }
// //
// // class _DataTableDesktopState extends State<DataTableDesktop> {
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// //   String? selectedValue;
// //   final List<String> dropdownOptions = ["PURIFIER 1001", "PURIFIER 1002", "PURIFIER 1003"];
// //
// //
// //   final Map<String, bool> _expandedRows = {
// //     'Pressure': false,
// //     'Water quantity': false,
// //     'Flow Reading': false,
// //   };
// //
// //   // Method to toggle the expanded state
// //   void _toggleRowExpanded(String rowTitle) {
// //     setState(() {
// //       _expandedRows[rowTitle] = !_expandedRows[rowTitle]!;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         backgroundColor: Colors.blue.withOpacity(0.3),
// //         body: Row(children: [
// //       Container(
// //         width: 250,
// //         child: sideMenu(),
// //       ),
// //       Expanded(
// //         // Use Expanded to ensure the grid takes remaining space
// //         child: Column(
// //           children: [
// //             AppBar(
// //               backgroundColor: TColors.textWhite,
// //               title: Text(
// //                 "DATA AND TABLE",
// //                 style: GoogleFonts.inknutAntiqua().copyWith(
// //                   color: TColors.textBlack, // Custom text color
// //                   fontSize: 25, // Custom font size
// //                 ),
// //               ),
// //               centerTitle: false,
// //               toolbarHeight: 90,
// //               actions: [
// //                 Padding(
// //                   padding: const EdgeInsets.only(right: 650.0),
// //                   child: DropdownButton<String>(
// //                     value: selectedValue,
// //                     hint: Text(
// //                       "Select Purifier",
// //                       style: TextStyle(color: TColors.textBlack, fontSize: 18),
// //                     ),
// //                     items: dropdownOptions.map((String value) {
// //                       return DropdownMenuItem<String>(
// //                         value: value,
// //                         child: Text(value),
// //                       );
// //                     }).toList(),
// //                     onChanged: (String? newValue) {
// //                       setState(() {
// //                         selectedValue = newValue;
// //                       });
// //                     },
// //                     dropdownColor: TColors.textWhite,
// //                     style: TextStyle(color: TColors.textBlack, fontSize: 18),
// //                   ),
// //                 ),
// //
// //                 IconButton(
// //                   icon: const Icon(Iconsax.notification),
// //                   onPressed: () {
// //                     // Add your notification functionality here
// //                   },
// //                 ),
// //               ],
// //             ),
// //             Expanded(
// //               child: ListView(
// //                 children: [
// //                   SingleChildScrollView(
// //                     scrollDirection: Axis.horizontal,
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Container(
// //                         color: TColors.textWhite,
// //                         child: DataTable(
// //                           dividerThickness: 2,
// //                           columns: [
// //                             DataColumn(label: Text("")),
// //                             DataColumn(label: Text("")),
// //                             DataColumn(label: Text("Monday\nMM/DD/YYYY")),
// //                             DataColumn(label: Text("Tuesday\nMM/DD/YYYY")),
// //                             DataColumn(label: Text("Wednesday\nMM/DD/YYYY")),
// //                             DataColumn(label: Text("Thursday\nMM/DD/YYYY")),
// //                             DataColumn(label: Text("Friday\nMM/DD/YYYY")),
// //                             DataColumn(label: Text("Saturday\nMM/DD/YYYY")),
// //                             DataColumn(label: Text("Sunday\nMM/DD/YYYY")),
// //                           ],
// //                           rows: [
// //                             // Pressure Row
// //                             DataRow(
// //                               cells: [
// //                                 DataCell(
// //                                   IconButton(
// //                                     onPressed: () =>
// //                                         _toggleRowExpanded('Pressure'),
// //                                     icon: Icon(
// //                                       _expandedRows['Pressure']!
// //                                           ? Iconsax.arrow_up_1
// //                                           : Iconsax.arrow_down_2,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 DataCell(Text('Pressure')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ],
// //                             ),
// //                             if (_expandedRows['Pressure']!) ...[
// //                               DataRow(cells: [
// //                                 DataCell(Text('Sub Pressure Data 1')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ]),
// //                               DataRow(cells: [
// //                                 DataCell(Text('Sub Pressure Data 2')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ]),
// //                             ],
// //                             // Water Quantity Row
// //                             DataRow(
// //                               cells: [
// //                                 DataCell(
// //                                   IconButton(
// //                                     onPressed: () =>
// //                                         _toggleRowExpanded('Water quantity'),
// //                                     icon: Icon(
// //                                       _expandedRows['Water quantity']!
// //                                           ? Iconsax.arrow_up_1
// //                                           : Iconsax.arrow_down_2,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 DataCell(Text('Water quantity')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ],
// //                             ),
// //                             if (_expandedRows['Water quantity']!) ...[
// //                               DataRow(cells: [
// //                                 DataCell(Text('Sub Water Data 1')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ]),
// //                               DataRow(cells: [
// //                                 DataCell(Text('Sub Water Data 2')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ]),
// //                             ],
// //                             // Flow Reading Row
// //                             DataRow(
// //                               cells: [
// //                                 DataCell(
// //                                   IconButton(
// //                                     onPressed: () =>
// //                                         _toggleRowExpanded('Flow Reading'),
// //                                     icon: Icon(
// //                                       _expandedRows['Flow Reading']!
// //                                           ? Iconsax.arrow_up_1
// //                                           : Iconsax.arrow_down_2,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 DataCell(Text('Flow Reading')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ],
// //                             ),
// //                             if (_expandedRows['Flow Reading']!) ...[
// //                               DataRow(cells: [
// //                                 DataCell(Text('Sub Flow Data 1')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ]),
// //                               DataRow(cells: [
// //                                 DataCell(Text('Sub Flow Data 2')),
// //                                 DataCell(Text('Sub Flow Data 2')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                                 DataCell(Text('')),
// //                               ]),
// //
// //
// //                             ],
// //
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         Expanded(
// //                           child: Padding(
// //                             padding: const EdgeInsets.fromLTRB(
// //                                 55, 28, 18 ,18 ),
// //                             child: Container(
// //                               // color: Colors.transparent,
// //                               height: 400,
// //                               child: QGraph(),
// //                             ),
// //                           ),
// //                         ),
// //                         // Spacing between graphs
// //                         Expanded(
// //                           child: Padding(
// //                             padding: const EdgeInsets.fromLTRB(
// //                                 15, 28, 58 ,18 ),
// //                             child: Container(
// //                               // color: TColors.textWhite,
// //                               height: 400,
// //                               child: QGraph(),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       )
// //     ]));
// //   }
// // }
// import 'package:aqua_pure/common/sideMenu.dart';
// import 'package:aqua_pure/utils/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:fl_chart/fl_chart.dart';

// class DataTableDesktop extends StatefulWidget {
//   const DataTableDesktop({Key? key}) : super(key: key);

//   @override
//   _DataTableDesktopState createState() => _DataTableDesktopState();
// }

// class _DataTableDesktopState extends State<DataTableDesktop> {
//   // State variables for dropdown selections
//   String selectedView = 'Trends';
//   String? selectedPurifier;
//   String? selectedTDS;
//   String? selectedTemp;
//   String? selectedPH;
//   DateTime? fromDate;
//   DateTime? toDate;

//   // Options for the view and purifier dropdowns
//   final List<String> viewOptions = ['Trends', 'Table'];
//   final List<String> purifierOptions = [
//     'Purifier 1',
//     'Purifier 2',
//     'Purifier 3'
//   ];

//   // Options for the parameter dropdowns
//   final List<String> tdsOptions = ['TDS Low', 'TDS Medium', 'TDS High'];
//   final List<String> tempOptions = ['Temp Low', 'Temp Medium', 'Temp High'];
//   final List<String> phOptions = ['pH Low', 'pH Neutral', 'pH High'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Row(
//         children: [
//           // Sidebar
//           Container(
//             width: 250,
//             child: sideMenu(),
//           ),
//           // Main Content Area
//           Expanded(
//             child: Column(
//               children: [
//                 _buildHeader(),
//                 Expanded(
//                   child: selectedView == 'Trends'
//                       ? _buildTrendsView()
//                       : _buildTableView(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Builds the header section which includes an AppBar-like area and an extra
//   /// row with the view selector and date range.
//   Widget _buildHeader() {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         children: [
//           // AppBar replacement
//           AppBar(
//             backgroundColor: TColors.textWhite,
//             title: Text(
//               "DATA AND TABLE",
//               style: GoogleFonts.inknutAntiqua().copyWith(
//                 color: TColors.textBlack,
//                 fontSize: 25,
//               ),
//             ),
//             centerTitle: false,
//             toolbarHeight: 90,
//             elevation: 0,
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: DropdownButton<String>(
//                   value: selectedPurifier,
//                   hint: Text(
//                     "Select Purifier",
//                     style: TextStyle(color: TColors.textBlack, fontSize: 18),
//                   ),
//                   items: purifierOptions.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedPurifier = newValue;
//                     });
//                   },
//                   dropdownColor: TColors.textWhite,
//                   style: TextStyle(color: TColors.textBlack, fontSize: 18),
//                   underline: const SizedBox(),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Iconsax.notification),
//                 onPressed: () {
//                   // Add notification functionality here
//                 },
//               ),
//             ],
//           ),
//           // Extra header row with view selection and date range
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//             child: Row(
//               children: [
//                 DropdownButton<String>(
//                   value: selectedView,
//                   items: viewOptions.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedView = newValue!;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 16),
//                 const Text(
//                   'Date:',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 8),
//                 InkWell(
//                   onTap: _selectDateRange,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           _formatDateRange(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         const Icon(Icons.arrow_drop_down, color: Colors.white),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Opens a date range picker and updates the selected date range.
//   Future<void> _selectDateRange() async {
//     final DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       initialDateRange: (fromDate != null && toDate != null)
//           ? DateTimeRange(start: fromDate!, end: toDate!)
//           : null,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null) {
//       setState(() {
//         fromDate = picked.start;
//         toDate = picked.end;
//       });
//     }
//   }

//   String _formatDateRange() {
//     if (fromDate != null && toDate != null) {
//       // Format the date range
//       return "${fromDate!.day}/${fromDate!.month}/${fromDate!.year} to ${toDate!.day}/${toDate!.month}/${toDate!.year}";
//     } else {
//       return "Select Date Range";
//     }
//   }

//   /// Builds the trends view containing two cards.
//   Widget _buildTrendsView() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           // Real Time Data card
//           Expanded(
//             child: _buildTrendsCard(
//               'Real Time Data',
//               [
//                 _buildParameterDropdown('TDS'),
//                 const SizedBox(width: 16),
//                 _buildParameterDropdown('Temp'),
//               ],
//               Colors.blue,
//             ),
//           ),
//           const SizedBox(width: 16),
//           // Purifier Performance card
//           Expanded(
//             child: _buildTrendsCard(
//               'Purifier Performance',
//               [
//                 _buildPurifierDropdown(),
//                 const SizedBox(width: 16),
//                 _buildParameterDropdown('pH'),
//               ],
//               Colors.brown,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Builds a card with a header, filter row, and a chart.
//   Widget _buildTrendsCard(
//       String title, List<Widget> dropdowns, Color headerColor) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Card header
//           Container(
//             padding: const EdgeInsets.all(16),
//             color: headerColor,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style:
//                       const TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//                 const Icon(Icons.fullscreen, color: Colors.white),
//               ],
//             ),
//           ),
//           // Filter row
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 ...dropdowns,
//                 const Spacer(),
//                 _buildDatePicker('From Date'),
//                 const SizedBox(width: 8),
//                 _buildDatePicker('To Date'),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Filter'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Chart area using fl_chart
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: true),
//                   titlesData: FlTitlesData(show: true),
//                   borderData: FlBorderData(show: true),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: const [
//                         FlSpot(0, 3),
//                         FlSpot(2, 5),
//                         FlSpot(4, 2),
//                         FlSpot(6, 4),
//                       ],
//                       isCurved: true,
//                       color: headerColor,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Builds the table view with a DataTable having a blue header and blue
//   /// section header rows.
//   Widget _buildTableView() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DataTable(
//               // Set header row background and text style
//               headingRowColor:
//                   MaterialStateProperty.resolveWith((states) => Colors.blue),
//               headingTextStyle: const TextStyle(color: Colors.white),
//               columns: [
//                 const DataColumn(label: Text('')),
//                 ...List.generate(7, (index) {
//                   final days = [
//                     'MONDAY',
//                     'TUESDAY',
//                     'WEDNESDAY',
//                     'THURSDAY',
//                     'FRIDAY',
//                     'SATURDAY',
//                     'SUNDAY'
//                   ];
//                   return DataColumn(
//                     label: Column(
//                       children: [
//                         Text(
//                           days[index],
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         const Text(
//                           '00/00/00',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ],
//               rows: _buildTableRows(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Generates rows for the DataTable. The section header rows (for PRESSURE,
//   /// WATER QUALITY, and FLOW READING) have a blue background with white text.
//   List<DataRow> _buildTableRows() {
//     final List<String> pressureRows = [
//       'Pre Filter Pressure PT1',
//       'Post Filter Pressure PT2',
//       'Pump Pressure PT3',
//       'System Pressure PT4',
//       'Reject Pressure PT5',
//       'Interstage Pressure PT6',
//     ];

//     final List<String> waterQualityRows = [
//       'Feed TDS',
//       'Product TDS',
//       'Water temperature',
//       'Feed pH pH1',
//       'Product pH pH2',
//       'Feed ORP ORP',
//     ];

//     final List<String> flowReadingRows = [
//       'Product Flow F1',
//       'Reject Flow F2',
//       'Recirculation Flow F3',
//     ];

//     return [
//       DataRow(
//         color: MaterialStateProperty.resolveWith((states) => Colors.blue),
//         cells: [
//           DataCell(Text(
//             'PRESSURE',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.white),
//           )),
//           ...List.generate(7, (index) => const DataCell(Text(''))),
//         ],
//       ),
//       ...pressureRows.map(
//         (row) => DataRow(
//           cells: [
//             DataCell(Text(row)),
//             ...List.generate(7, (index) => const DataCell(Text(''))),
//           ],
//         ),
//       ),
//       DataRow(
//         color: MaterialStateProperty.resolveWith((states) => Colors.blue),
//         cells: [
//           DataCell(Text(
//             'WATER QUALITY',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.white),
//           )),
//           ...List.generate(7, (index) => const DataCell(Text(''))),
//         ],
//       ),
//       ...waterQualityRows.map(
//         (row) => DataRow(
//           cells: [
//             DataCell(Text(row)),
//             ...List.generate(7, (index) => const DataCell(Text(''))),
//           ],
//         ),
//       ),
//       DataRow(
//         color: MaterialStateProperty.resolveWith((states) => Colors.blue),
//         cells: [
//           DataCell(Text(
//             'FLOW READING',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.white),
//           )),
//           ...List.generate(7, (index) => const DataCell(Text(''))),
//         ],
//       ),
//       ...flowReadingRows.map(
//         (row) => DataRow(
//           cells: [
//             DataCell(Text(row)),
//             ...List.generate(7, (index) => const DataCell(Text(''))),
//           ],
//         ),
//       ),
//     ];
//   }

//   /// Builds a parameter dropdown for TDS, Temp, or pH.
//   Widget _buildParameterDropdown(String label) {
//     List<String> options;
//     String? currentValue;

//     if (label == 'TDS') {
//       options = tdsOptions;
//       currentValue = selectedTDS;
//     } else if (label == 'Temp') {
//       options = tempOptions;
//       currentValue = selectedTemp;
//     } else if (label == 'pH') {
//       options = phOptions;
//       currentValue = selectedPH;
//     } else {
//       options = [];
//     }

//     return DropdownButton<String>(
//       value: currentValue,
//       hint: Text(label),
//       items: options.map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (String? newValue) {
//         setState(() {
//           if (label == 'TDS') {
//             selectedTDS = newValue;
//           } else if (label == 'Temp') {
//             selectedTemp = newValue;
//           } else if (label == 'pH') {
//             selectedPH = newValue;
//           }
//         });
//       },
//     );
//   }

//   /// Builds a dropdown for purifier selection.
//   Widget _buildPurifierDropdown() {
//     return DropdownButton<String>(
//       value: selectedPurifier,
//       hint: const Text('Purifier'),
//       items: purifierOptions.map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (String? newValue) {
//         setState(() {
//           selectedPurifier = newValue;
//         });
//       },
//     );
//   }

//   /// Builds a date picker button.
//   Widget _buildDatePicker(String label) {
//     return TextButton(
//       onPressed: () async {
//         final date = await showDatePicker(
//           context: context,
//           initialDate: fromDate ?? DateTime.now(),
//           firstDate: DateTime(2020),
//           lastDate: DateTime(2025),
//         );
//         if (date != null) {
//           setState(() {
//             if (label == 'From Date') {
//               fromDate = date;
//             } else {
//               toDate = date;
//             }
//           });
//         }
//       },
//       child: Row(
//         children: [
//           const Icon(Icons.calendar_today, size: 16),
//           const SizedBox(width: 4),
//           Text(label),
//         ],
//       ),
//     );
//   }
// }
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';

import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class DataTableDesktop extends StatefulWidget {
  const DataTableDesktop({Key? key}) : super(key: key);

  @override
  _DataTableDesktopState createState() => _DataTableDesktopState();
}

class _DataTableDesktopState extends State<DataTableDesktop> {
  // Local state for view and date range.
  String selectedView = 'Trends';
  String? selectedTDS;
  String? selectedTemp;
  String? selectedPH;
  DateTime? fromDate;
  DateTime? toDate;

  // Options for the view dropdown.
  final List<String> viewOptions = ['Trends', 'Table'];
  
  // Options for parameter dropdowns.
  final List<String> tdsOptions = ['TDS Low', 'TDS Medium', 'TDS High'];
  final List<String> tempOptions = ['Temp Low', 'Temp Medium', 'Temp High'];
  final List<String> phOptions = ['pH Low', 'pH Neutral', 'pH High'];

  // Global controllers.
  final PurifierController purifierController = Get.put(PurifierController());
  final PurifierSelectionController purifierSelectionController =
      Get.put(PurifierSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Sidebar.
          Container(width: 250, child: sideMenu()),
          // Main Content Area.
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: selectedView == 'Trends'
                      ? _buildTrendsView()
                      : _buildTableView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the header section with an AppBar-like area and an extra row for view selection and date range.
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // AppBar replacement.
          AppBar(
            backgroundColor: TColors.textWhite,
            title: Text(
              "DATA AND TABLE",
              style: GoogleFonts.inknutAntiqua().copyWith(
                color: TColors.textBlack,
                fontSize: 25,
              ),
            ),
            centerTitle: false,
            toolbarHeight: 90,
            elevation: 0,
            actions: [
              // Global dynamic dropdown for purifier selection using centralized API data.
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Obx(() {
                  // Get the current selection from the global controller.
                  String currentPurifier =
                      purifierSelectionController.selectedPurifierId.value;
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
                          .map<DropdownMenuItem<String>>((Purifier purifier) {
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
                      underline: const SizedBox(),
                    );
                  }
                }),
              ),
              IconButton(
                icon: const Icon(Iconsax.notification),
                onPressed: () {
                  // Add notification functionality here.
                },
              ),
            ],
          ),
          // Extra header row with view selection and date range.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: selectedView,
                  items: viewOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedView = newValue!;
                    });
                  },
                ),
                const SizedBox(width: 16),
                const Text(
                  'Date:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: _selectDateRange,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          _formatDateRange(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
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

  /// Opens a date range picker and updates fromDate and toDate.
  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: (fromDate != null && toDate != null)
          ? DateTimeRange(start: fromDate!, end: toDate!)
          : null,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
      });
    }
  }

  String _formatDateRange() {
    if (fromDate != null && toDate != null) {
      return "${fromDate!.day}/${fromDate!.month}/${fromDate!.year} to ${toDate!.day}/${toDate!.month}/${toDate!.year}";
    } else {
      return "Select Date Range";
    }
  }

  /// Builds the trends view containing charts and parameter dropdowns.
  Widget _buildTrendsView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Real Time Data card.
          Expanded(
            child: _buildTrendsCard(
              'Real Time Data',
              [
                _buildParameterDropdown('TDS'),
                const SizedBox(width: 16),
                _buildParameterDropdown('Temp'),
              ],
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          // Purifier Performance card.
          Expanded(
            child: _buildTrendsCard(
              'Purifier Performance',
              [
                const SizedBox(width: 16),
                _buildParameterDropdown('pH'),
              ],
              Colors.brown,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a trends card with header, filters, and a chart.
  Widget _buildTrendsCard(String title, List<Widget> dropdowns, Color headerColor) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card header.
          Container(
            padding: const EdgeInsets.all(16),
            color: headerColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Icon(Icons.fullscreen, color: Colors.white),
              ],
            ),
          ),
          // Filter row.
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ...dropdowns,
                const Spacer(),
                _buildDatePicker('From Date'),
                const SizedBox(width: 8),
                _buildDatePicker('To Date'),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Filter'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ),
          // Chart area using fl_chart.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(2, 5),
                        FlSpot(4, 2),
                        FlSpot(6, 4),
                      ],
                      isCurved: true,
                      color: headerColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the table view with a DataTable.
  Widget _buildTableView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataTable(
              headingRowColor:
                  MaterialStateProperty.resolveWith((states) => Colors.blue),
              headingTextStyle: const TextStyle(color: Colors.white),
              columns: [
                const DataColumn(label: Text('')),
                ...List.generate(7, (index) {
                  final days = [
                    'MONDAY',
                    'TUESDAY',
                    'WEDNESDAY',
                    'THURSDAY',
                    'FRIDAY',
                    'SATURDAY',
                    'SUNDAY'
                  ];
                  return DataColumn(
                    label: Column(
                      children: [
                        Text(days[index],
                            style: const TextStyle(color: Colors.white)),
                        const Text('00/00/00',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                }),
              ],
              rows: _buildTableRows(),
            ),
          ],
        ),
      ),
    );
  }

  /// Generates rows for the DataTable.
  List<DataRow> _buildTableRows() {
    final List<String> pressureRows = [
      'Pre Filter Pressure PT1',
      'Post Filter Pressure PT2',
      'Pump Pressure PT3',
      'System Pressure PT4',
      'Reject Pressure PT5',
      'Interstage Pressure PT6',
    ];

    final List<String> waterQualityRows = [
      'Feed TDS',
      'Product TDS',
      'Water temperature',
      'Feed pH pH1',
      'Product pH pH2',
      'Feed ORP ORP',
    ];

    final List<String> flowReadingRows = [
      'Product Flow F1',
      'Reject Flow F2',
      'Recirculation Flow F3',
    ];

    return [
      DataRow(
        color: MaterialStateProperty.resolveWith((states) => Colors.blue),
        cells: [
          DataCell(Text('PRESSURE',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white))),
          ...List.generate(7, (index) => const DataCell(Text(''))),
        ],
      ),
      ...pressureRows.map(
        (row) => DataRow(
          cells: [
            DataCell(Text(row)),
            ...List.generate(7, (index) => const DataCell(Text(''))),
          ],
        ),
      ),
      DataRow(
        color: MaterialStateProperty.resolveWith((states) => Colors.blue),
        cells: [
          DataCell(Text('WATER QUALITY',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white))),
          ...List.generate(7, (index) => const DataCell(Text(''))),
        ],
      ),
      ...waterQualityRows.map(
        (row) => DataRow(
          cells: [
            DataCell(Text(row)),
            ...List.generate(7, (index) => const DataCell(Text(''))),
          ],
        ),
      ),
      DataRow(
        color: MaterialStateProperty.resolveWith((states) => Colors.blue),
        cells: [
          DataCell(Text('FLOW READING',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white))),
          ...List.generate(7, (index) => const DataCell(Text(''))),
        ],
      ),
      ...flowReadingRows.map(
        (row) => DataRow(
          cells: [
            DataCell(Text(row)),
            ...List.generate(7, (index) => const DataCell(Text(''))),
          ],
        ),
      ),
    ];
  }

  /// Builds a parameter dropdown for TDS, Temp, or pH.
  Widget _buildParameterDropdown(String label) {
    List<String> options;
    String? currentValue;

    if (label == 'TDS') {
      options = tdsOptions;
      currentValue = selectedTDS;
    } else if (label == 'Temp') {
      options = tempOptions;
      currentValue = selectedTemp;
    } else if (label == 'pH') {
      options = phOptions;
      currentValue = selectedPH;
    } else {
      options = [];
    }

    return DropdownButton<String>(
      value: currentValue,
      hint: Text(label),
      items: options
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          if (label == 'TDS') {
            selectedTDS = newValue;
          } else if (label == 'Temp') {
            selectedTemp = newValue;
          } else if (label == 'pH') {
            selectedPH = newValue;
          }
        });
      },
    );
  }

  /// Builds a date picker button.
  Widget _buildDatePicker(String label) {
    return TextButton(
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: fromDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2025),
        );
        if (date != null) {
          setState(() {
            if (label == 'From Date') {
              fromDate = date;
            } else {
              toDate = date;
            }
          });
        }
      },
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
