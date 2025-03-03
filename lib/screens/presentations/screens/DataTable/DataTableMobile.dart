import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/common/QAppBar.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fl_chart/fl_chart.dart';

class DataTableMobile extends StatefulWidget {
  const DataTableMobile({Key? key}) : super(key: key);

  @override
  _DataTableMobileState createState() => _DataTableMobileState();
}

class _DataTableMobileState extends State<DataTableMobile> {
  // View selector options and current selection.
  String selectedView = "Tables";
  final List<String> viewOptions = ["Trends", "Tables"];

  // For table view header date dropdowns.
  final String tableFromDate = "Nov 25 2024";
  final String tableToDate = "Nov 29 2024";

  // Trends view variables:
  String? selectedTDS;
  String? selectedTemp;
  String? selectedPH;
  final List<String> tdsOptions = ['TDS Low', 'TDS Medium', 'TDS High'];
  final List<String> tempOptions = ['Temp Low', 'Temp Medium', 'Temp High'];
  final List<String> phOptions = ['pH Low', 'pH Neutral', 'pH High'];

  String? selectedPurifier;
  final List<String> purifierOptions = ['Purifier 1', 'Purifier 2', 'Purifier 3'];

  DateTime? trendsFromDate;
  DateTime? trendsToDate;

  /// Builds a trends card with header, filter row, and chart area.
  Widget _buildTrendsCard(String title, Widget dropdowns, Color headerColor) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card header with title and fullscreen icon.
          Container(
            padding: const EdgeInsets.all(16),
            color: headerColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                const Icon(Icons.fullscreen, color: Colors.white),
              ],
            ),
          ),
          // Filter row: parameter dropdowns and date pickers.
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dropdowns,
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildDateButton("From Date"),
                    const SizedBox(width: 8),
                    _buildDateButton("To Date"),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Implement filter action for trends.
                      },
                      child: const Text("Filter", style : TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: headerColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // Chart area using fl_chart.
          Container(
            height: 200,
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
        ],
      ),
    );
  }

  /// Helper to build a parameter dropdown.
  Widget _buildParameterDropdown(String label, List<String> options,
      String? currentValue, Function(String?) onChanged) {
    return DropdownButton<String>(
      value: currentValue,
      hint: Text(label, style: const TextStyle(fontSize: 12)),
      items: options
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 12)),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  /// Helper to build the purifier dropdown.
  Widget _buildPurifierDropdown() {
    return DropdownButton<String>(
      value: selectedPurifier,
      hint: const Text("Purifier", style: TextStyle(fontSize: 12)),
      items: purifierOptions
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 12)),
              ))
          .toList(),
      onChanged: (val) => setState(() => selectedPurifier = val),
    );
  }

  /// Helper to build a date picker button.
  Widget _buildDateButton(String label) {
    return TextButton(
      onPressed: () => _selectTrendsDate(label),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 12),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  /// Opens a date picker for trends filters.
  Future<void> _selectTrendsDate(String label) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (date != null) {
      setState(() {
        if (label == "From Date") {
          trendsFromDate = date;
        } else {
          trendsToDate = date;
        }
      });
    }
  }

  /// Builds the Trends view.
  Widget _buildTrendsView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Trends card for Real Time Data.
            _buildTrendsCard(
              'Real Time Data',
              Row(
                children: [
                  _buildParameterDropdown("TDS", tdsOptions, selectedTDS,
                      (val) => setState(() => selectedTDS = val)),
                  const SizedBox(width: 16),
                  _buildParameterDropdown("Temp", tempOptions, selectedTemp,
                      (val) => setState(() => selectedTemp = val)),
                ],
              ),
              Colors.blue,
            ),
            const SizedBox(height: 16),
            // Trends card for Purifier Performance.
            _buildTrendsCard(
              'Purifier Performance',
              Row(
                children: [
                  _buildPurifierDropdown(),
                  const SizedBox(width: 16),
                  _buildParameterDropdown("pH", phOptions, selectedPH,
                      (val) => setState(() => selectedPH = val)),
                ],
              ),
              Colors.brown,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the Tables view (unchanged from your current mobile implementation).
  Widget _buildTableView() {
    const Color primaryBlue = Color(0xFF0267FF);
    const TextStyle headerTextStyle =
        TextStyle(color: Colors.white, fontSize: 10);
    const TextStyle groupHeaderTextStyle = TextStyle(
      color: primaryBlue,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    const TextStyle dataTextStyle =
        TextStyle(color: Colors.black, fontSize: 10);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          headingRowHeight: 40,
          dataRowHeight: 40,
          headingRowColor: MaterialStateProperty.all(primaryBlue),
          dataRowColor:
              MaterialStateProperty.all(primaryBlue.withOpacity(0.2)),
          columnSpacing: 12,
          columns: [
            const DataColumn(label: SizedBox()),
            DataColumn(
                label: Text("MONDAY\n00/00/00",
                    style: headerTextStyle, textAlign: TextAlign.center)),
            DataColumn(
                label: Text("TUESDAY\n00/00/00",
                    style: headerTextStyle, textAlign: TextAlign.center)),
            DataColumn(
                label: Text("WEDNESDAY\n00/00/00",
                    style: headerTextStyle, textAlign: TextAlign.center)),
            DataColumn(
                label: Text("THURSDAY\n00/00/00",
                    style: headerTextStyle, textAlign: TextAlign.center)),
            DataColumn(
                label: Text("FRIDAY\n00/00/00",
                    style: headerTextStyle, textAlign: TextAlign.center)),
            DataColumn(
                label: Text("SATURDAY\n00/00/00",
                    style: headerTextStyle, textAlign: TextAlign.center)),
            DataColumn(
                label: Text("SUNDAY\n00/00/00",
                    style: headerTextStyle, textAlign: TextAlign.center)),
          ],
          rows: [
            // PRESSURE Section
            DataRow(cells: [
              DataCell(Text("PRESSURE", style: groupHeaderTextStyle)),
              ...List.generate(7, (_) => const DataCell(Text(""))),
            ]),
            ...["Prefilter Pressure PT1", "Post Filter Pressure PT2", "Pump Pressure PT3", 
                "System Pressure PT4", "Reject Pressure PT5", "Interstage Pressure PT6"]
                .map((text) => DataRow(cells: [
                      DataCell(Text(text, style: dataTextStyle)),
                      ...List.generate(7, (_) => DataCell(Text("", style: dataTextStyle))),
                    ])),

            // WATER QUALITY Section
            DataRow(cells: [
              DataCell(Text("WATER QUALITY", style: groupHeaderTextStyle)),
              ...List.generate(7, (_) => const DataCell(Text(""))),
            ]),
            ...["Feed TDS", "Product TDS", "Water temperature", "Feed pH pH1", 
                "Product pH pH2", "Feed ORP ORP"]
                .map((text) => DataRow(cells: [
                      DataCell(Text(text, style: dataTextStyle)),
                      ...List.generate(7, (_) => DataCell(Text("", style: dataTextStyle))),
                    ])),

            // FLOW READING Section
            DataRow(cells: [
              DataCell(Text("FLOW READING", style: groupHeaderTextStyle)),
              ...List.generate(7, (_) => const DataCell(Text(""))),
            ]),
            ...["Product Flow F1", "Reject Flow F2", "Recirculation Flow F3"]
                .map((text) => DataRow(cells: [
                      DataCell(Text(text, style: dataTextStyle)),
                      ...List.generate(7, (_) => DataCell(Text("", style: dataTextStyle))),
                    ])),
          ],
        ),
      ),
    );
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      drawer: sideMenu(),
       key: _scaffoldKey,
      appBar: QAppBar(
        
        menuIcon: Iconsax.menu_1,
       onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        notificationIcon: Iconsax.notification,
        userIcon: Iconsax.user,
        title: 'Data and Tables',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with breadcrumb, date range and view selector.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Home / Data and Tables",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                    const Spacer(),
                    Row(
                      children: [
                        Text("Date: ", style: TextStyle(fontSize: 10)),
                        DropdownButton<String>(
                          value: tableFromDate,
                          items: [tableFromDate]
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(fontSize: 10)),
                                  ))
                              .toList(),
                          onChanged: (_) {},
                        ),
                        Text(" to ", style: TextStyle(fontSize: 10)),
                        DropdownButton<String>(
                          value: tableToDate,
                          items: [tableToDate]
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(fontSize: 10)),
                                  ))
                              .toList(),
                          onChanged: (_) {},
                        ),
                        const SizedBox(width: 8),
                        // View selector dropdown with Trends and Tables options.
                      
                      ],
                    ),


                  ],
                ),

                  DropdownButton<String>(
                          value: selectedView,
                          items: viewOptions
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(fontSize: 10)),
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedView = newValue!;
                            });
                          },
                        ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          // Show Trends view if selected, else Tables view.
          Expanded(
            child: selectedView == "Trends"
                ? _buildTrendsView()
                : _buildTableView(),
          ),
        ],
      ),
    );
  }
}
