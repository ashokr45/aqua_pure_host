import 'dart:convert';
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

class SettingDesktop extends StatefulWidget {
  const SettingDesktop({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

final PurifierController purifierController = Get.put(PurifierController());
final PurifierSelectionController purifierSelectionController =
    Get.put(PurifierSelectionController());

class _SettingsPageState extends State<SettingDesktop> {
  String selectedMainMenu = 'INSTRUMENTS';
  String selectedSubMenu = 'FEED ORP';
  String selectedPurifier = 'PURIFIER 1001';

  // Toggle states for some static switches
  Map<String, bool> toggleStates = {
    'flush': false,
    'flushStartup': false,
    'flushShutdown': false,
    'standbyFlush': false,
    'runningFlush': false,
    'conductivityFlush': false,
    'highPressurePump': false,
    'lowLevelAlarm': false,
  };

  final List<String> mainMenuItems = [
    'INSTRUMENTS',
    'GENERAL PROCESS',
  ];

  // INSTRUMENTS menu items
  final List<String> instrumentItems = [
    'FEED ORP',
    'FEED pH',
    'PERMEATE pH',
    'PERMEATE FLOW',
    'REJECT FLOW',
    'RECIRCULATION FLOW',
    'FEED CONDUCTIVITY',
    'FEED TEMPERATURE',
    'PRODUCT CONDUCTIVITY',
    'PRODUCT TEMPERATURE',
    'P. P. TRANSDUCER (PT1)',
    'P. F. P. TRANSDUCER (PT2)',
    'P. P. TRANSDUCER (PT3)',
    'S. P. TRANSDUCER (PT4)',
    'I. P. TRANSDUCER (PT5)',
    'R. P. TRANSDUCER (PT6)',
    // Static UI options for instruments without API
    'PRESSURE SWITCHES',
    'PERMEATE FLUSH',
    'INLET VALVE',
  ];

  // GENERAL PROCESS menu items – these will be integrated with API calls
  final List<String> generalProcessItems = [
    'PRE-CHLORINATION PUMP',
    'POST-CHLORINATION PUMP',
    'DECHLORINATION PUMP',
    'ANTISCALANT PUMP',
    'POST PH PUMP',
    'BLENDING',
    'DIVERT',
    'FLUSH',
  ];

  Widget _buildSideMenu() {
    return Container(
      width: 250,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ...mainMenuItems.map((item) => _buildMainMenuItem(item)),
            if (selectedMainMenu == 'INSTRUMENTS')
              ...instrumentItems.map((item) => _buildSubMenuItem(item)),
            if (selectedMainMenu == 'GENERAL PROCESS')
              ...generalProcessItems.map((item) => _buildSubMenuItem(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildMainMenuItem(String item) {
    bool isSelected = selectedMainMenu == item;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedMainMenu = item;
            selectedSubMenu = item == 'INSTRUMENTS'
                ? instrumentItems[0]
                : item == 'GENERAL PROCESS'
                    ? generalProcessItems[0]
                    : '';
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.arrow_drop_down : Icons.arrow_right,
                color: Colors.black,
              ),
              Text(
                item,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubMenuItem(String item) {
    bool isSelected = selectedSubMenu == item;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedSubMenu = item;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            item,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // ----- Static UI Widgets for non-API options -----
  Widget _buildFeedORPContent() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF4E87DE).withOpacity(0.46),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingRow('Reading (mv)', '+239.3'),
            _buildSettingRow('@ 4mA (mv)', '-1000.0'),
            _buildSettingRow('@ 20mA (mv)', '+2000.0'),
            _buildSettingRow('Fault Delay (secs)', '180'),
            _buildSettingRow('Low Limit\nMonitoring', 'OFF'),
            _buildSettingRow('High Limit\nMonitoring', 'OFF'),
            _buildSettingRow('Low Limit\nAlarm', 'OFF'),
            _buildSettingRow('High Limit\nAlarm', 'OFF'),
            _buildSettingRow('Low Limit (gpm)', '+0.0'),
            _buildSettingRow('High Limit (gpm)', '+240.0'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedTemperatureContent() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF4E87DE).withOpacity(0.46),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingRow('Reading\n(°C or °F)', ''),
            _buildSettingRow('Offset', ''),
            _buildSettingRow('Slope', ''),
          ],
        ),
      ),
    );
  }

  Widget _buildPermeateFlushContent() {
    // This static UI remains for PERMEATE FLUSH (if no API is available)
    return Container(
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      color: const Color(0xFF4E87DE).withOpacity(0.46),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleRow('Flush:', 'flush'),
            _buildToggleRow('Flush on start-up:', 'flushStartup'),
            _buildToggleRow('Flush on shutdown:', 'flushShutdown'),
            _buildToggleRow('Standby interval flush:', 'standbyFlush'),
            _buildToggleRow('Running interval flush:', 'runningFlush'),
            _buildToggleRow('Product conductivity flush:', 'conductivityFlush'),
            _buildSettingRow('Flush duration(seconds):', ''),
            _buildSettingRow('Standby interval(hours):', ''),
            _buildSettingRow('Running interval(hours):', ''),
            _buildSettingRow('Product conductivity limit(μS/cm or ppm):', ''),
            _buildSettingRow('Product conductivity delay (minutes):', ''),
            _buildSettingRow('Flush source:', ''),
            _buildToggleRow('High pressure pump:', 'highPressurePump'),
          ],
        ),
      ),
    );
  }

  Widget _buildPressureSwitchesContent() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF4E87DE).withOpacity(0.46),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingRow('Pressure Switch 1', 'OFF'),
            _buildSettingRow('Pressure Switch 2', 'OFF'),
            // Additional static settings if needed.
          ],
        ),
      ),
    );
  }

  Widget _buildInletValveContent() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      color: const Color(0xFF4E87DE).withOpacity(0.46),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingRow('Inlet Valve Status', 'Closed'),
            // Additional static settings if needed.
          ],
        ),
      ),
    );
  }

  // ----- End of Static UI Widgets -----

  /// Returns dynamic content for items that have API integration.
  /// We maintain two lists of dynamic items: one for instruments and one for general process.
  Widget? _getContentForSubMenu(String subMenu) {
    final List<String> dynamicInstrumentItems = [
      'FEED ORP',
      'FEED pH',
      'PERMEATE pH',
      'PERMEATE FLOW',
      'REJECT FLOW',
      'RECIRCULATION FLOW',
      'FEED CONDUCTIVITY',
      'FEED TEMPERATURE',
      'PRODUCT CONDUCTIVITY',
      'PRODUCT TEMPERATURE',
      'P. P. TRANSDUCER (PT1)',
      'P. F. P. TRANSDUCER (PT2)',
      'P. P. TRANSDUCER (PT3)',
      'S. P. TRANSDUCER (PT4)',
      'I. P. TRANSDUCER (PT5)',
      'R. P. TRANSDUCER (PT6)',
    ];

    final List<String> dynamicGeneralProcessItems = [
      'PRE-CHLORINATION PUMP',
      'POST-CHLORINATION PUMP',
      'DECHLORINATION PUMP',
      'ANTISCALANT PUMP',
      'POST PH PUMP',
      'BLENDING',
      'DIVERT',
      'FLUSH',
    ];

    if (dynamicInstrumentItems.contains(subMenu) ||
        dynamicGeneralProcessItems.contains(subMenu)) {
      return Obx(() {
        String currentPurifierId =
            purifierSelectionController.selectedPurifierId.value;
        return InstrumentSettingsWidget(
          key: ValueKey(currentPurifierId + widgetSelectedInstrumentKey(subMenu)),
          instrumentType: subMenu,
          purifierId: currentPurifierId,
        );
      });
    }

    // For static UI options that do not have APIs:
    switch (subMenu) {
      case 'FEED ORP':
        return _buildFeedORPContent();
      case 'FEED TEMPERATURE':
        return _buildFeedTemperatureContent();
      case 'PERMEATE FLUSH':
        return _buildPermeateFlushContent();
      case 'PRESSURE SWITCHES':
        return _buildPressureSwitchesContent();
      case 'INLET VALVE':
        return _buildInletValveContent();
      default:
        return Center(child: Text('Select an option'));
    }
  }

  // Helper to generate a unique key for dynamic widgets.
  String widgetSelectedInstrumentKey(String instrument) {
    return instrument.replaceAll(' ', '_');
  }

  Widget _buildSelectedContent() {
    Widget? content = _getContentForSubMenu(selectedSubMenu);
    if (content != null) {
      return content;
    }

    // Fallback if none found.
    List<String> currentSubMenuList = [];
    if (selectedMainMenu == 'INSTRUMENTS') {
      currentSubMenuList = instrumentItems;
    } else if (selectedMainMenu == 'GENERAL PROCESS') {
      currentSubMenuList = generalProcessItems;
    } else {
      return const Center(child: Text('Select an option'));
    }

    for (String item in currentSubMenuList) {
      content = _getContentForSubMenu(item);
      if (content != null) {
        return content;
      }
    }
    return const Center(child: Text('Select an option'));
  }

  Widget _buildSettingRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(value, style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(String label, String toggleKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          Switch(
            value: toggleStates[toggleKey] ?? false,
            onChanged: (bool value) {
              setState(() {
                toggleStates[toggleKey] = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContentArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 250, color: Colors.white, child: sideMenu()),
        Container(width: 250, color: Colors.white, child: _buildSideMenu()),
        Expanded(child: _buildSelectedContent()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('SETTINGS', style: TextStyle(color: Colors.black, fontSize: 24)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Obx(() {
              String currentPurifier = purifierSelectionController.selectedPurifierId.value;
              if (purifierController.isLoading.value) {
                return const CircularProgressIndicator();
              } else if (purifierController.filteredPurifierList.isEmpty) {
                return Text("No Purifiers", style: TextStyle(color: TColors.textBlack, fontSize: 18));
              } else {
                return DropdownButton<String>(
                  value: currentPurifier.isEmpty ? null : currentPurifier,
                  hint: Text("Select Purifier", style: TextStyle(color: TColors.textBlack, fontSize: 18)),
                  items: purifierController.filteredPurifierList.map<DropdownMenuItem<String>>((Purifier purifier) {
                    return DropdownMenuItem<String>(
                      value: purifier.id.toString(),
                      child: Text("${purifier.name} ${purifier.location}",
                          style: TextStyle(color: TColors.textBlack, fontSize: 18)),
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
              // Notification functionality here.
            },
          ),
          const CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.notifications, color: Colors.white)),
          const SizedBox(width: 8),
          const CircleAvatar(backgroundImage: NetworkImage('https://placeholder.com/user')),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Settings > ${selectedMainMenu.toLowerCase()} > ${selectedSubMenu.toLowerCase()}',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Expanded(child: _buildContentArea()),
        ],
      ),
    );
  }
}

/// This widget dynamically fetches and displays settings based on the provided [instrumentType] and [purifierId].
/// It is used both for instruments and general process items that have API integration.
class InstrumentSettingsWidget extends StatefulWidget {
  final String instrumentType;
  final String purifierId;

  const InstrumentSettingsWidget({super.key, required this.instrumentType, required this.purifierId});

  @override
  _InstrumentSettingsWidgetState createState() => _InstrumentSettingsWidgetState();
}

class _InstrumentSettingsWidgetState extends State<InstrumentSettingsWidget> {
  bool isLoading = true;
  Map<String, dynamic> settingsData = {};
  final Map<String, TextEditingController> controllers = {};
  final Map<String, bool> boolValues = {};

  /// Mapping for both instrument and general process endpoints.
  final Map<String, dynamic> settingsMapping = {
    // INSTRUMENTS mappings
    'FEED ORP': {
      'get': 'http://3.82.225.92:8000/feed_orp/',
      'patch': 'http://3.82.225.92:8000/feed_orp/',
      'fields': {
        'reading_mv': 'Reading (mv)',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA_mv': '@ 4mA (mv)',
        'at_20mA_mv': '@ 20mA (mv)',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit_gpm': 'Low Limit (gpm)',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit_gpm': 'High Limit (gpm)',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'FEED pH': {
      'get': 'http://3.82.225.92:8000/feed_ph/',
      'patch': 'http://3.82.225.92:8000/feed_ph/',
      'fields': {
        'reading_mv': 'Reading (mv)',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA_mv': '@ 4mA (mv)',
        'at_20mA_mv': '@ 20mA (mv)',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit_gpm': 'Low Limit (gpm)',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit_gpm': 'High Limit (gpm)',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'PERMEATE pH': {
      'get': 'http://3.82.225.92:8000/permeate_ph/',
      'patch': 'http://3.82.225.92:8000/permeate_ph/',
      'fields': {
        'reading_mv': 'Reading (mv)',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA_mv': '@ 4mA (mv)',
        'at_20mA_mv': '@ 20mA (mv)',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit_gpm': 'Low Limit (gpm)',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit_gpm': 'High Limit (gpm)',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'PERMEATE FLOW': {
      'get': 'http://3.82.225.92:8000/permeate_flow/',
      'patch': 'http://3.82.225.92:8000/permeate_flow/',
      'fields': {
        'reading_gpm': 'Reading (gpm)',
        'fault_delay_secs': 'Fault Delay (secs)',
        'k_factor': 'K Factor',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit_gpm': 'Low Limit (gpm)',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit_gpm': 'High Limit (gpm)',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'REJECT FLOW': {
      'get': 'http://3.82.225.92:8000/reject_flow/',
      'patch': 'http://3.82.225.92:8000/reject_flow/',
      'fields': {
        'reading_gpm': 'Reading (gpm)',
        'fault_delay_secs': 'Fault Delay (secs)',
        'k_factor': 'K Factor',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit_gpm': 'Low Limit (gpm)',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit_gpm': 'High Limit (gpm)',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'RECIRCULATION FLOW': {
      'get': 'http://3.82.225.92:8000/recirculation_flow/',
      'patch': 'http://3.82.225.92:8000/recirculation_flow/',
      'fields': {
        'reading_gpm': 'Reading (gpm)',
        'fault_delay_secs': 'Fault Delay (secs)',
        'k_factor': 'K Factor',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit_gpm': 'Low Limit (gpm)',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit_gpm': 'High Limit (gpm)',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'FEED CONDUCTIVITY': {
      'get': 'http://3.82.225.92:8000/feed_conductivity/',
      'patch': 'http://3.82.225.92:8000/feed_conductivity/',
      'fields': {
        'reading': 'Reading',
        'fault_delay_secs': 'Fault Delay (secs)',
        'cell_constant': 'Cell Constant',
        'temperature_compensation': 'Temperature Compensation',
        'offset': 'Offset',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit': 'Low Limit',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit': 'High Limit',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'FEED TEMPERATURE': {
      'get': 'http://3.82.225.92:8000/feed_temperature/',
      'patch': 'http://3.82.225.92:8000/feed_temperature/',
      'fields': {
        'reading': 'Reading (°C or °F)',
        'slope': 'Slope',
        'offset': 'Offset',
      },
      'boolFields': [],
    },
    'PRODUCT CONDUCTIVITY': {
      'get': 'http://3.82.225.92:8000/product_conductivity/',
      'patch': 'http://3.82.225.92:8000/product_conductivity/',
      'fields': {
        'reading': 'Reading',
        'fault_delay_secs': 'Fault Delay (secs)',
        'cell_constant': 'Cell Constant',
        'temperature_compensation': 'Temperature Compensation',
        'offset': 'Offset',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit': 'Low Limit',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit': 'High Limit',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'PRODUCT TEMPERATURE': {
      'get': 'http://3.82.225.92:8000/product_temperature/',
      'patch': 'http://3.82.225.92:8000/product_temperature/',
      'fields': {
        'reading': 'Reading (°C or °F)',
        'slope': 'Slope',
        'offset': 'Offset',
      },
      'boolFields': [],
    },
    // Transducer endpoints
    'P. P. TRANSDUCER (PT1)': {
      'get': 'http://3.82.225.92:8000/pp_transducer_pt1/',
      'patch': 'http://3.82.225.92:8000/pp_transducer_pt1/',
      'fields': {
        'reading': 'Reading',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA': '@ 4mA',
        'at_20mA': '@ 20mA',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit': 'Low Limit',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit': 'High Limit',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'P. F. P. TRANSDUCER (PT2)': {
      'get': 'http://3.82.225.92:8000/pfp_transducer_pt2/',
      'patch': 'http://3.82.225.92:8000/pfp_transducer_pt2/',
      'fields': {
        'reading': 'Reading',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA': '@ 4mA',
        'at_20mA': '@ 20mA',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit': 'Low Limit',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit': 'High Limit',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'P. P. TRANSDUCER (PT3)': {
      'get': 'http://3.82.225.92:8000/pp_transducer_pt3/',
      'patch': 'http://3.82.225.92:8000/pp_transducer_pt3/',
      'fields': {
        'reading': 'Reading',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA': '@ 4mA',
        'at_20mA': '@ 20mA',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit': 'Low Limit',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit': 'High Limit',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'S. P. TRANSDUCER (PT4)': {
      'get': 'http://3.82.225.92:8000/sp_transducer_pt4/',
      'patch': 'http://3.82.225.92:8000/sp_transducer_pt4/',
      'fields': {
        'reading': 'Reading',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA': '@ 4mA',
        'at_20mA': '@ 20mA',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit': 'Low Limit',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit': 'High Limit',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'I. P. TRANSDUCER (PT5)': {
      'get': 'http://3.82.225.92:8000/ip_transducer_pt5/',
      'patch': 'http://3.82.225.92:8000/ip_transducer_pt5/',
      'fields': {
        'reading': 'Reading',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA': '@ 4mA',
        'at_20mA': '@ 20mA',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit': 'Low Limit',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit': 'High Limit',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    'R. P. TRANSDUCER (PT6)': {
      'get': 'http://3.82.225.92:8000/rp_transducer_pt6/',
      'patch': 'http://3.82.225.92:8000/rp_transducer_pt6/',
      'fields': {
        'reading': 'Reading',
        'fault_delay_secs': 'Fault Delay (secs)',
        'at_4mA': '@ 4mA',
        'at_20mA': '@ 20mA',
        'low_limit_monitoring': 'Low Limit Monitoring',
        'low_limit_alarm': 'Low Limit Alarm',
        'low_limit': 'Low Limit',
        'high_limit_monitoring': 'High Limit Monitoring',
        'high_limit_alarm': 'High Limit Alarm',
        'high_limit': 'High Limit',
      },
      'boolFields': ['low_limit_monitoring', 'low_limit_alarm', 'high_limit_monitoring', 'high_limit_alarm'],
    },
    // GENERAL PROCESS endpoints
    'PRE-CHLORINATION PUMP': {
      'get': 'http://3.82.225.92:8000/pre_chlorination_pump/',
      'patch': 'http://3.82.225.92:8000/pre_chlorination_pump/',
      'fields': {
        'low_level_alarm': 'Low Level Alarm',
        'low_level_shutdown_timer': 'Low Level Shutdown Timer',
      },
      'boolFields': ['low_level_alarm'],
    },
    'POST-CHLORINATION PUMP': {
      'get': 'http://3.82.225.92:8000/post_chlorination_pump/',
      'patch': 'http://3.82.225.92:8000/post_chlorination_pump/',
      'fields': {
        'low_level_alarm': 'Low Level Alarm',
        'low_level_shutdown_timer': 'Low Level Shutdown Timer',
      },
      'boolFields': ['low_level_alarm'],
    },
    'DECHLORINATION PUMP': {
      'get': 'http://3.82.225.92:8000/dechlorination_pump/',
      'patch': 'http://3.82.225.92:8000/dechlorination_pump/',
      'fields': {
        'low_level_alarm': 'Low Level Alarm',
        'low_level_shutdown_timer': 'Low Level Shutdown Timer',
      },
      'boolFields': ['low_level_alarm'],
    },
    'ANTISCALANT PUMP': {
      'get': 'http://3.82.225.92:8000/antiscalant_pump/',
      'patch': 'http://3.82.225.92:8000/antiscalant_pump/',
      'fields': {
        'low_level_alarm': 'Low Level Alarm',
        'low_level_shutdown_timer': 'Low Level Shutdown Timer',
      },
      'boolFields': ['low_level_alarm'],
    },
    'POST PH PUMP': {
      'get': 'http://3.82.225.92:8000/post_ph_pump/',
      'patch': 'http://3.82.225.92:8000/post_ph_pump/',
      'fields': {
        'low_level_alarm': 'Low Level Alarm',
        'low_level_shutdown_timer': 'Low Level Shutdown Timer',
      },
      'boolFields': ['low_level_alarm'],
    },
    'BLENDING': {
      'get': 'http://3.82.225.92:8000/blending_setting/',
      'patch': 'http://3.82.225.92:8000/blending_setting/',
      'fields': {
        'blending': 'Blending',
      },
      'boolFields': ['blending'],
    },
    'DIVERT': {
      'get': 'http://3.82.225.92:8000/divert_setting/',
      'patch': 'http://3.82.225.92:8000/divert_setting/',
      'fields': {
        'divert': 'Divert',
        'divert_trigger_source': 'Divert Trigger Source',
        'high_limit': 'High Limit',
        'divert_mode': 'Divert Mode',
        'timeout': 'Timeout',
        'alarms_alerts': 'Alarms Alerts',
      },
      'boolFields': ['divert'],
    },
    'FLUSH': {
      'get': 'http://3.82.225.92:8000/flush_setting/',
      'patch': 'http://3.82.225.92:8000/flush_setting/',
      'fields': {
        'flush': 'Flush',
        'flush_on_startup': 'Flush on Startup',
        'flush_on_shutdown': 'Flush on Shutdown',
        'standby_interval_flush': 'Standby Interval Flush',
        'running_interval_flush': 'Running Interval Flush',
        'product_conductivity_flush': 'Product Conductivity Flush',
        'flush_duration': 'Flush Duration',
        'standby_interval_hours': 'Standby Interval Hours',
        'running_interval_hours': 'Running Interval Hours',
        'product_conductivity_limit': 'Product Conductivity Limit',
        'product_conductivity_delay': 'Product Conductivity Delay',
        'flush_source': 'Flush Source',
        'high_pressure_pump': 'High Pressure Pump',
      },
      'boolFields': [
        'flush',
        'flush_on_startup',
        'flush_on_shutdown',
        'standby_interval_flush',
        'running_interval_flush',
        'product_conductivity_flush',
        'high_pressure_pump'
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _fetchSettingsData();
  }

  @override
  void didUpdateWidget(covariant InstrumentSettingsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.purifierId != widget.purifierId ||
        oldWidget.instrumentType != widget.instrumentType) {
      _fetchSettingsData();
    }
  }

  Future<void> _fetchSettingsData() async {
    setState(() {
      isLoading = true;
    });
    final mapping = settingsMapping[widget.instrumentType];
    if (mapping == null) return;
    // Construct the GET URL by appending the purifierId and a trailing slash.
    String getUrl = mapping['get'] + widget.purifierId + '/';
    try {
      final response = await http.get(Uri.parse(getUrl));
      if (response.statusCode == 200) {
        settingsData = json.decode(response.body);
        mapping['fields'].forEach((field, label) {
          if (mapping['boolFields'].contains(field)) {
            boolValues[field] = (settingsData[field] ?? false) as bool;
          } else {
            controllers[field] = TextEditingController(
                text: settingsData[field]?.toString() ?? "0");
          }
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveData() async {
    final mapping = settingsMapping[widget.instrumentType];
    if (mapping == null) return;
    String patchUrl = mapping['patch'];
    Map<String, dynamic> body = {
      'purifier_id': int.tryParse(widget.purifierId) ?? widget.purifierId
    };
    mapping['fields'].forEach((field, label) {
      if (mapping['boolFields'].contains(field)) {
        body[field] = boolValues[field];
      } else {
        body[field] = controllers[field]?.text ?? "0";
      }
    });
    try {
      final response = await http.patch(Uri.parse(patchUrl),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      if (response.statusCode == 200 || response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data updated successfully")),
        );
        _fetchSettingsData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update data")),
        );
      }
    } catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error saving data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapping = settingsMapping[widget.instrumentType];
    if (isLoading || mapping == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Expanded(
          child: Container(

            padding: const EdgeInsets.all(20),
            color: const Color(0xFF4E87DE).withOpacity(0.46),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.instrumentType,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  ...mapping['fields'].entries.map((entry) {
                    String field = entry.key;
                    String label = entry.value;
                    if (mapping['boolFields'].contains(field)) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(child: Text(label, style: const TextStyle(fontSize: 16, color: Colors.black))),
                            Switch(
                              value: boolValues[field] ?? false,
                              onChanged: (val) {
                                setState(() {
                                  boolValues[field] = val;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: controllers[field],
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }).toList(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveData,
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
