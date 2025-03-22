import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

// -------------------------------------------------------------------------
// REALTIME DATA MODEL
// -------------------------------------------------------------------------
class RealTimeDataModel {
  final int id;
  final String deviceId;
  final double preFilterPressure;
  final double postFilterPressure;
  final double pumpPressure;
  final double systemPressure;
  final double rejectPressure;
  final double interstagePressure;
  final double pPrefilter;
  final double productFlow;
  final double rejectFlow;
  final double recirculationFlow;
  final double waterTemperature;
  final double recovery;
  final double rejection;
  final double pMembrane;
  final double feedOrp;
  final double feedTds;
  final double feedPh;
  final double productTds;
  final double productPh;
  final bool feedPumpStatus;
  final bool inletValveStatus;
  final bool permeateFlushValveStatus;
  final bool roHighPressurePumpStatus;
  final bool blendingValveStatus;
  final bool flushValveStatus;
  final bool rejectValveStatus;
  final bool divertValveStatus;
  final bool rawWaterTankLowLevel;
  final bool postChlorinationLowLevel;
  final bool preChlorinationDosingLowLevel;
  final bool dechlorinationDosingLowLevel;
  final bool antiscalantDosingLowLevel;
  final bool postPhLowLevel;
  final bool permeateWaterTankHighHighLevel;
  final bool permeateWaterTankHighMediumLevel;
  final bool pressureSwitchLow;
  final bool pressureSwitchHigh;
  final bool pretreatLockOut;
  final bool currentAlarm;
  final bool warningIndicator;
  final int purifierId;

  RealTimeDataModel({
    required this.id,
    required this.deviceId,
    required this.preFilterPressure,
    required this.postFilterPressure,
    required this.pumpPressure,
    required this.systemPressure,
    required this.rejectPressure,
    required this.interstagePressure,
    required this.pPrefilter,
    required this.productFlow,
    required this.rejectFlow,
    required this.recirculationFlow,
    required this.waterTemperature,
    required this.recovery,
    required this.rejection,
    required this.pMembrane,
    required this.feedOrp,
    required this.feedTds,
    required this.feedPh,
    required this.productTds,
    required this.productPh,
    required this.feedPumpStatus,
    required this.inletValveStatus,
    required this.permeateFlushValveStatus,
    required this.roHighPressurePumpStatus,
    required this.blendingValveStatus,
    required this.flushValveStatus,
    required this.rejectValveStatus,
    required this.divertValveStatus,
    required this.rawWaterTankLowLevel,
    required this.postChlorinationLowLevel,
    required this.preChlorinationDosingLowLevel,
    required this.dechlorinationDosingLowLevel,
    required this.antiscalantDosingLowLevel,
    required this.postPhLowLevel,
    required this.permeateWaterTankHighHighLevel,
    required this.permeateWaterTankHighMediumLevel,
    required this.pressureSwitchLow,
    required this.pressureSwitchHigh,
    required this.pretreatLockOut,
    required this.currentAlarm,
    required this.warningIndicator,
    required this.purifierId,
  });

  factory RealTimeDataModel.fromJson(Map<String, dynamic> json) {
    return RealTimeDataModel(
      id: json['id'],
      deviceId: json['device_id'] ?? "",
      preFilterPressure: (json['pre_filter_pressure'] ?? 0).toDouble(),
      postFilterPressure: (json['post_filter_pressure'] ?? 0).toDouble(),
      pumpPressure: (json['pump_pressure'] ?? 0).toDouble(),
      systemPressure: (json['system_pressure'] ?? 0).toDouble(),
      rejectPressure: (json['reject_pressure'] ?? 0).toDouble(),
      interstagePressure: (json['interstage_pressure'] ?? 0).toDouble(),
      pPrefilter: (json['p_prefilter'] ?? 0).toDouble(),
      productFlow: (json['product_flow'] ?? 0).toDouble(),
      rejectFlow: (json['reject_flow'] ?? 0).toDouble(),
      recirculationFlow: (json['recirculation_flow'] ?? 0).toDouble(),
      waterTemperature: (json['water_temperature'] ?? 0).toDouble(),
      recovery: (json['Recovery'] ?? 0).toDouble(),
      rejection: (json['Rejection'] ?? 0).toDouble(),
      pMembrane: (json['P_membrane'] ?? 0).toDouble(),
      feedOrp: (json['feed_orp'] ?? 0).toDouble(),
      feedTds: (json['feed_tds'] ?? 0).toDouble(),
      feedPh: (json['feed_ph'] ?? 0).toDouble(),
      productTds: (json['product_tds'] ?? 0).toDouble(),
      productPh: (json['product_ph'] ?? 0).toDouble(),
      feedPumpStatus: json['feed_pump_status'] ?? false,
      inletValveStatus: json['inlet_valve_status'] ?? false,
      permeateFlushValveStatus: json['Permeate_flush_valve_status'] ?? false,
      roHighPressurePumpStatus: json['ro_high_pressure_pump_status'] ?? false,
      blendingValveStatus: json['blending_valve_status'] ?? false,
      flushValveStatus: json['flush_valve_status'] ?? false,
      rejectValveStatus: json['reject_valve_status'] ?? false,
      divertValveStatus: json['divert_valve_status'] ?? false,
      rawWaterTankLowLevel: json['raw_water_tank_low_level'] ?? false,
      postChlorinationLowLevel: json['post_chlorination_low_level'] ?? false,
      preChlorinationDosingLowLevel: json['Pre_chlorination_dosing_low_level'] ?? false,
      dechlorinationDosingLowLevel: json['dechlorination_dosing_low_level'] ?? false,
      antiscalantDosingLowLevel: json['antiscalant_dosing_low_level'] ?? false,
      postPhLowLevel: json['post_ph_low_level'] ?? false,
      permeateWaterTankHighHighLevel: json['permeate_water_tank_high_high_level'] ?? false,
      permeateWaterTankHighMediumLevel: json['Permeate_water_tank_high_medium_level'] ?? false,
      pressureSwitchLow: json['pressure_switch_low'] ?? false,
      pressureSwitchHigh: json['pressure_switch_high'] ?? false,
      pretreatLockOut: json['pretreat_lock_out'] ?? false,
      currentAlarm: json['current_alarm'] ?? false,
      warningIndicator: json['warning_indicator'] ?? false,
      purifierId: json['purifier_id'] ?? 0,
    );
  }

  // Helper to convert any bool value to Yes/No string.
  static String boolToString(bool value) => value ? "Yes" : "No";
}

// -------------------------------------------------------------------------
// REALTIME DATA CONTROLLER
// -------------------------------------------------------------------------
class RealDataController extends GetxController {
  var isLoading = false.obs;
  var realTimeData = RealTimeDataModel(
    id: 0,
    deviceId: "",
    preFilterPressure: 0,
    postFilterPressure: 0,
    pumpPressure: 0,
    systemPressure: 0,
    rejectPressure: 0,
    interstagePressure: 0,
    pPrefilter: 0,
    productFlow: 0,
    rejectFlow: 0,
    recirculationFlow: 0,
    waterTemperature: 0,
    recovery: 0,
    rejection: 0,
    pMembrane: 0,
    feedOrp: 0,
    feedTds: 0,
    feedPh: 0,
    productTds: 0,
    productPh: 0,
    feedPumpStatus: false,
    inletValveStatus: false,
    permeateFlushValveStatus: false,
    roHighPressurePumpStatus: false,
    blendingValveStatus: false,
    flushValveStatus: false,
    rejectValveStatus: false,
    divertValveStatus: false,
    rawWaterTankLowLevel: false,
    postChlorinationLowLevel: false,
    preChlorinationDosingLowLevel: false,
    dechlorinationDosingLowLevel: false,
    antiscalantDosingLowLevel: false,
    postPhLowLevel: false,
    permeateWaterTankHighHighLevel: false,
    permeateWaterTankHighMediumLevel: false,
    pressureSwitchLow: false,
    pressureSwitchHigh: false,
    pretreatLockOut: false,
    currentAlarm: false,
    warningIndicator: false,
    purifierId: 0,
  ).obs;

  final GetConnect _getConnect = GetConnect();

  Future<void> fetchData(String purifierId) async {
    try {
      isLoading.value = true;
      final response = await _getConnect.get("http://3.82.225.92:8000/realtime_data/$purifierId/");
      if (response.statusCode == 200) {
        realTimeData.value = RealTimeDataModel.fromJson(response.body);
      } else {
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

// -------------------------------------------------------------------------
// REAL DATA DESKTOP WIDGET
// -------------------------------------------------------------------------
class RealDataDesktop extends StatefulWidget {
  const RealDataDesktop({Key? key}) : super(key: key);

  @override
  State<RealDataDesktop> createState() => _RealDataDesktopState();
}

class _RealDataDesktopState extends State<RealDataDesktop> {
  // Assume these controllers are defined elsewhere in your project.
  final PurifierController purifierController = Get.put(PurifierController());
  final PurifierSelectionController purifierSelectionController = Get.put(PurifierSelectionController());
  final RealDataController realDataController = Get.put(RealDataController());

  @override
  void initState() {
    super.initState();
    // Fetch data if a purifier is already selected
    if (purifierSelectionController.selectedPurifierId.value.isNotEmpty) {
      realDataController.fetchData(purifierSelectionController.selectedPurifierId.value);
    }
    // Listen for changes in the selected purifier id and update data accordingly
    ever(purifierSelectionController.selectedPurifierId, (String id) {
      if (id.isNotEmpty) {
        realDataController.fetchData(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.3),
      body: Row(
        children: [
          Container(
            width: 250,
            child: sideMenu(),
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: TColors.textWhite,
                  title: Text(
                    "REAL TIME DATA",
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
                      child: Obx(() {
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
                Expanded(
                  child: Obx(() {
                    if (realDataController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final data = realDataController.realTimeData.value;
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Detailed Metrics container
                            QDataContainer2(
                              heading: 'Detailed Metrics',
                              title1: 'Pre Filter Pressure PT1',
                              value1: data.preFilterPressure.toString(),
                              title2: 'Product Flow Rate 1',
                              value2: data.productFlow.toString(),
                              title3: 'Post Filter Pressure PT2',
                              value3: data.postFilterPressure.toString(),
                              title4: 'Reject Flow Rate 2',
                              value4: data.rejectFlow.toString(),
                              title5: 'Pump Pressure PT3',
                              value5: data.pumpPressure.toString(),
                              title6: 'Recirculation Flow Rate 3',
                              value6: data.recirculationFlow.toString(),
                              title7: 'System Pressure PT4',
                              value7: data.systemPressure.toString(),
                              title8: 'Water Temperature',
                              value8: data.waterTemperature.toString(),
                              title9: 'Reject Pressure PT5',
                              value9: data.rejectPressure.toString(),
                              title10: 'Recovery %',
                              value10: data.recovery.toString(),
                              title11: 'Interstage Pressure PT6',
                              value11: data.interstagePressure.toString(),
                              title12: 'Rejection %',
                              value12: data.rejection.toString(),
                              title13: 'ΔP Prefilter',
                              value13: data.pPrefilter.toString(),
                              title14: 'ΔP Membrane',
                              value14: data.pMembrane.toString(),
                            ),
                            const SizedBox(height: 10.0),
                            // Quality Metrics container
                            QDataContainer2(
                              heading: 'Quality Metrics',
                              title1: 'FEED ORP',
                              value1: data.feedOrp.toString(),
                              title2: 'Product TDS',
                              value2: data.productTds.toString(),
                              title3: 'FEED TDS',
                              value3: data.feedTds.toString(),
                              title4: 'Product pH',
                              value4: data.productPh.toString(),
                              title5: 'FEED pH',
                              value5: data.feedPh.toString(),
                              title6: '',
                              value6: "",
                            ),
                            const SizedBox(height: 10.0),
                            // Component Status container
                            QDataContainer2(
                              heading: 'Component Status',
                              title1: 'Feed Pump Status',
                              value1: RealTimeDataModel.boolToString(data.feedPumpStatus),
                              title2: 'Blending Valve Status',
                              value2: RealTimeDataModel.boolToString(data.blendingValveStatus),
                              title3: 'Inlet Valve Status',
                              value3: RealTimeDataModel.boolToString(data.inletValveStatus),
                              title4: 'Flush Valve Status',
                              value4: RealTimeDataModel.boolToString(data.flushValveStatus),
                              title5: 'Permeate flush valve status',
                              value5: RealTimeDataModel.boolToString(data.permeateFlushValveStatus),
                              title6: 'Reject Valve Status',
                              value6: RealTimeDataModel.boolToString(data.rejectValveStatus),
                              title7: 'RO high pressure pump Status',
                              value7: RealTimeDataModel.boolToString(data.roHighPressurePumpStatus),
                              title8: 'Divert Valve Status',
                              value8: RealTimeDataModel.boolToString(data.divertValveStatus),
                            ),
                            const SizedBox(height: 10.0),
                            // Level Switches Status container
                            QDataContainer2(
                              heading: 'Level Switches Status',
                              title1: 'Raw water tank low level Status',
                              value1: RealTimeDataModel.boolToString(data.rawWaterTankLowLevel),
                              title2: 'Antiscalant dosing low level Status',
                              value2: RealTimeDataModel.boolToString(data.antiscalantDosingLowLevel),
                              title3: 'Post chlorination low level Status',
                              value3: RealTimeDataModel.boolToString(data.postChlorinationLowLevel),
                              title4: 'Post pH low level Status',
                              value4: RealTimeDataModel.boolToString(data.postPhLowLevel),
                              title5: 'Pre chlorination dosing low level status',
                              value5: RealTimeDataModel.boolToString(data.preChlorinationDosingLowLevel),
                              title6: 'Permeate water tank high-high level switch',
                              value6: RealTimeDataModel.boolToString(data.permeateWaterTankHighHighLevel),
                              title7: 'Dechlorination dosing low level Status',
                              value7: RealTimeDataModel.boolToString(data.dechlorinationDosingLowLevel),
                              title8: 'Permeate water tank high-medium level switch',
                              value8: RealTimeDataModel.boolToString(data.permeateWaterTankHighMediumLevel),
                            ),
                            const SizedBox(height: 10.0),
                            // Pressure Switches Status container
                            QDataContainer2(
                              heading: 'Pressure Switches Status',
                              title1: 'Pressure switch low',
                              value1: RealTimeDataModel.boolToString(data.pressureSwitchLow),
                              title2: 'Pressure switch high',
                              value2: RealTimeDataModel.boolToString(data.pressureSwitchHigh),
                            ),
                            const SizedBox(height: 10.0),
                            // Alarms & Warnings container
                            QDataContainer2(
                              heading: 'Alarms & Warnings',
                              title1: 'Pretreat lock out',
                              value1: RealTimeDataModel.boolToString(data.pretreatLockOut),
                              title2: 'Warning Indicator',
                              value2: RealTimeDataModel.boolToString(data.warningIndicator),
                              title3: 'Current alarm',
                              value3: RealTimeDataModel.boolToString(data.currentAlarm),
                              title4: '',
                              value4: "",
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------------
// UPDATED QDATA CONTAINER WIDGET
// -------------------------------------------------------------------------
class QDataContainer2 extends StatelessWidget {
  final String? title1;
  final String heading;
  final String? title2;
  final String? title3;
  final String? title4;
  final String? title5;
  final String? title6;
  final String? title7;
  final String? title8;
  final String? title9;
  final String? title10;
  final String? title11;
  final String? title12;
  final String? title13;
  final String? title14;

  final String? value1;
  final String? value2;
  final String? value3;
  final String? value4;
  final String? value5;
  final String? value6;
  final String? value7;
  final String? value8;
  final String? value9;
  final String? value10;
  final String? value11;
  final String? value12;
  final String? value13;
  final String? value14;

  const QDataContainer2({
    Key? key,
    this.title1,
    this.title2,
    this.title3,
    this.title4,
    this.title5,
    this.title6,
    this.title7,
    this.title8,
    this.title9,
    this.title10,
    this.title11,
    this.title12,
    this.title13,
    this.title14,
    required this.heading,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.value5,
    this.value6,
    this.value7,
    this.value8,
    this.value9,
    this.value10,
    this.value11,
    this.value12,
    this.value13,
    this.value14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 600;

    // Prepare rows as a list of maps
    List<Map<String, String?>> rows = [
      {'title': title1, 'value': value1},
      {'title': title2, 'value': value2},
      {'title': title3, 'value': value3},
      {'title': title4, 'value': value4},
      {'title': title5, 'value': value5},
      {'title': title6, 'value': value6},
      {'title': title7, 'value': value7},
      {'title': title8, 'value': value8},
      {'title': title9, 'value': value9},
      {'title': title10, 'value': value10},
      {'title': title11, 'value': value11},
      {'title': title12, 'value': value12},
      {'title': title13, 'value': value13},
      {'title': title14, 'value': value14},
    ];

    // Remove rows where title is null or empty
    rows.removeWhere((row) => row['title'] == null || row['title']!.isEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading container
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(color: TColors.appBarColor),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            heading,
            style: const TextStyle(
              color: TColors.textWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Data rows
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDesktop ? TColors.textWhite : TColors.appBarColor.withOpacity(0.3),
          ),
          child: Column(
            children: _buildRows(rows),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildRows(List<Map<String, String?>> rows) {
    List<Widget> rowWidgets = [];
    for (int i = 0; i < rows.length; i += 2) {
      if (i + 1 < rows.length) {
        rowWidgets.add(_buildDataRow(
          rows[i]['title'],
          rows[i]['value'],
          rows[i + 1]['title'],
          rows[i + 1]['value'],
        ));
      } else {
        rowWidgets.add(_buildSingleDataRow(rows[i]['title'], rows[i]['value']));
      }
    }
    return rowWidgets;
  }

 Widget _buildDataRow(String? titleLeft, String? valueLeft, String? titleRight, String? valueRight) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
    child: Row(
      children: [
        // Left column
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 175, // Fixed width for title
                child: Text(titleLeft ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Container(
                height: 25,
                width: 120, // Fixed width for value
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: TColors.inactiveBtn,
                ),
                child: Text(valueLeft ?? ""),
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),
        // Right column
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 175, // Fixed width for title
                child: Text(titleRight ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Container(
                height: 25,
                width: 120, // Fixed width for value
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: TColors.inactiveBtn,
                ),
                child: Text(valueRight ?? ""),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSingleDataRow(String? title, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 175, // Fixed width for title
                child: Text(title ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Container(
                height: 25,
                width: 120, // Fixed width for value
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: TColors.inactiveBtn,
                ),
                child: Text(value ?? ""),
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),
        Expanded(child: Container()), // Empty to maintain alignment
      ],
    ),
  );
}
}