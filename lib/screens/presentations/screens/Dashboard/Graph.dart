import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class QGraph extends StatefulWidget {
  const QGraph({super.key});

  @override
  State<QGraph> createState() => _QGraphState();
}

class _QGraphState extends State<QGraph> {
  late List<_SalesData> _sales;

  // Initial filter values
  String selectedXAxis = "TDS";
  String selectedYAxis = "Temp";
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    _sales = <_SalesData>[
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40),
      _SalesData('Jun', 47),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Adding an AppBar for better mobile UX.
      // appBar: AppBar(
      //   title: const Text("Responsive Graph"),
      // ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Filter options wrapped in SingleChildScrollView to avoid overflow on small screens
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: selectedXAxis,
                    onChanged: (value) {
                      setState(() {
                        selectedXAxis = value!;
                      });
                    },
                    items: ['TDS', 'Other X-Axis']
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: selectedYAxis,
                    onChanged: (value) {
                      setState(() {
                        selectedYAxis = value!;
                      });
                    },
                    items: ['Temp', 'Other Y-Axis']
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                  ),
                  const SizedBox(width: 16),
                  // From Date Picker
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: fromDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          fromDate = date;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(fromDate == null
                          ? "From Date"
                          : "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // To Date Picker
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: toDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          toDate = date;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(toDate == null
                          ? "To Date"
                          : "${toDate!.day}/${toDate!.month}/${toDate!.year}"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle filter logic here
                    },
                    child: const Text("Filter"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Chart Container wrapped in Expanded for responsive sizing
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                  title: ChartTitle(text: 'Real Time Data'),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                      name: 'Sales',
                      dataSource: _sales,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sales.clear();
    super.dispose();
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
