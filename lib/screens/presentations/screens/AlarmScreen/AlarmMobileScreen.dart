import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../common/QAppBar.dart';
import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';

class Alarmmobilescreen extends StatefulWidget {
  const Alarmmobilescreen({super.key});

  @override
  State<Alarmmobilescreen> createState() => _AlarmmobilescreenState();
}

class _AlarmmobilescreenState extends State<Alarmmobilescreen> {
  late AlarmDataSource alarmDataSource;

  @override
  void initState() {
    super.initState();
    alarmDataSource = AlarmDataSource(alarmData: [
      Alarm(1, 'Alarm_1', '3/10/2024/9:21AM', 'Pump Fault', 'Level 1'),
      Alarm(2, 'Alarm_2', '3/10/2024/9:21AM', 'Pump Fault', 'Level 2'),
      Alarm(3, 'Alarm_3', '3/10/2024/9:21AM', 'Pump Fault', 'Level 3'),
    ]);
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
        title: 'Alarm History',
      ),
      drawer: sideMenu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("Home / Alarm History"),
          ),
          const SizedBox(height: 10),
          SfDataGrid(
            source: alarmDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'id',
                label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  color: TColors.button,
                  child: Text(
                    'SR.No.',
                    style: TextStyle(color: Colors.white),
                  ),
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
                  child: Text(
                    'DATETIME',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
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
            ],
          ),
        ],
      ),
    );
  }
}

class Alarm {
  Alarm(this.id, this.name, this.DateTime, this.description, this.alarmLevel);

  final int id;
  final String name;
  final String DateTime;
  final String description;
  final String alarmLevel;
}

class AlarmDataSource extends DataGridSource {
  AlarmDataSource({required List<Alarm> alarmData}) {
    _alarmData = alarmData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(columnName: 'DateTime', value: e.DateTime),
      DataGridCell<String>(columnName: 'description', value: e.description),
      DataGridCell<String>(columnName: 'alarmLevel', value: e.alarmLevel),
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
