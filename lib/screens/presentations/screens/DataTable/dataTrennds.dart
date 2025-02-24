import 'package:aqua_pure/common/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aqua_pure/common/QAppBar.dart';

class DataTrends extends StatelessWidget {
   DataTrends({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Updated text styles with increased font sizes.
    const TextStyle smallTextStyle = TextStyle(fontSize: 12, color: Colors.black);
    const TextStyle headerTitleStyle = TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: QAppBar(
        menuIcon: Icons.menu,
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        notificationIcon: Icons.notifications,
        userIcon: Icons.account_circle,
        title: 'Data and Tables',
        
      ),  drawer: sideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          // Makes the content scrollable
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with navigation
                Row(
                  children: [
                    const Text(
                      'Home / Data and Tables',
                      style: smallTextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Date Range Selector
                Row(
                  children: [
                    const Text('Date: ', style: smallTextStyle),
                    DropdownButton<String>(
                      value: 'Nov 25 2024',
                      style: smallTextStyle,
                      items: ['Nov 25 2024'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: smallTextStyle),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                    const Text(' to ', style: smallTextStyle),
                    DropdownButton<String>(
                      value: 'Nov 29 2024',
                      style: smallTextStyle,
                      items: ['Nov 29 2024'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: smallTextStyle),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Real Time Data Section Header
                Container(
                  width: double.infinity,
                  color: Color(0xFF0267FF).withOpacity(0.2),
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Real Time Data',
                    style: headerTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                // Real Time Data Card with dropdown and graph
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Dropdown row for Real Time Data
                        Row(
                          children: [
                            DropdownButton<String>(
                              value: 'TDS',
                              style: smallTextStyle,
                              items: ['TDS'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: smallTextStyle),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: 'TEMP',
                              style: smallTextStyle,
                              items: ['TEMP'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: smallTextStyle),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.calendar_today, size: 16, color: Colors.black),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Real Time Data Graph with black line color
                        SizedBox(
                          height: 200,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: const [
                                    FlSpot(0, 1),
                                    FlSpot(2, 3),
                                    FlSpot(4, 1),
                                    FlSpot(6, 5),
                                    FlSpot(8, 2),
                                  ],
                                  isCurved: true,
                                  color: Colors.black,
                                  barWidth: 2,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Purifier Performance Section Header
                Container(
                  width: double.infinity,
                  color: Colors.brown,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Purifier Performance',
                    style: headerTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                // Purifier Performance Card with dropdown and graph
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Dropdown row for Purifier Performance
                        Row(
                          children: [
                            DropdownButton<String>(
                              value: 'Purifier 1',
                              style: smallTextStyle,
                              items: ['Purifier 1'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: smallTextStyle),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: 'pH',
                              style: smallTextStyle,
                              items: ['pH'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: smallTextStyle),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.calendar_today, size: 16, color: Colors.black),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Purifier Performance Graph with reduced height to fix overflow
                        SizedBox(
                          height: 140,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: const [
                                    FlSpot(0, 2),
                                    FlSpot(2, 1),
                                    FlSpot(4, 3),
                                    FlSpot(6, 1),
                                    FlSpot(8, 4),
                                  ],
                                  isCurved: true,
                                  color: Colors.black,
                                  barWidth: 2,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
