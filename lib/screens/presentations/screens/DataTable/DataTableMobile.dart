import 'package:aqua_pure/common/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/QAppBar.dart';

class DataTableMobile extends StatefulWidget {
  DataTableMobile({super.key});

  @override
  _DataTableMobileState createState() => _DataTableMobileState();
}

class _DataTableMobileState extends State<DataTableMobile> {
  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0267FF);
    const Color lightBlue = Color(0xFFB3E5FC);
    const TextStyle headerTextStyle = TextStyle(color: Colors.white, fontSize: 10);
    const TextStyle groupHeaderTextStyle = TextStyle(
      color: primaryBlue,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    const TextStyle dataTextStyle = TextStyle(color: Colors.black, fontSize: 10);

    return Scaffold(
      drawer: sideMenu(),
      appBar: QAppBar(
        menuIcon: Iconsax.menu_1,
        onPressed: () {},
        notificationIcon: Iconsax.notification,
        userIcon: Iconsax.user,
        title: 'Data and Tables',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Home / Data and Tables",
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text("Date: ", style: TextStyle(fontSize: 10)),
                        DropdownButton<String>(
                          value: "Nov 25 2024",
                          items: ["Nov 25 2024"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 10)),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                        Text(" to ", style: TextStyle(fontSize: 10)),
                        DropdownButton<String>(
                          value: "Nov 29 2024",
                          items: ["Nov 29 2024"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 10)),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                DropdownButton<String>(
                  value: "Tables",
                  items: ["Tables"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 10)),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowHeight: 40,
                  dataRowHeight: 40,
                  headingRowColor: MaterialStateProperty.all(primaryBlue),
                 dataRowColor: MaterialStateProperty.all(Color(0xFF0267FF).withOpacity(0.2)),
                  columnSpacing: 12,
                  columns: [
                    const DataColumn(label: SizedBox()),
                    DataColumn(label: Text("MONDAY\n00/00/00", style: headerTextStyle, textAlign: TextAlign.center)),
                    DataColumn(label: Text("TUESDAY\n00/00/00", style: headerTextStyle, textAlign: TextAlign.center)),
                    DataColumn(label: Text("WEDNESDAY\n00/00/00", style: headerTextStyle, textAlign: TextAlign.center)),
                    DataColumn(label: Text("THURSDAY\n00/00/00", style: headerTextStyle, textAlign: TextAlign.center)),
                    DataColumn(label: Text("FRIDAY\n00/00/00", style: headerTextStyle, textAlign: TextAlign.center)),
                    DataColumn(label: Text("SATURDAY\n00/00/00", style: headerTextStyle, textAlign: TextAlign.center)),
                    DataColumn(label: Text("SUNDAY\n00/00/00", style: headerTextStyle, textAlign: TextAlign.center)),
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
            ),
          ),
        ],
      ),
    );
  }
}