import 'package:aqua_pure/common/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingDesktop extends StatefulWidget {
  const SettingDesktop({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingDesktop> {
  String selectedMainMenu = 'INSTRUMENTS';
  String selectedSubMenu = 'FEED ORP';
  String selectedPurifier = 'PURIFIER 1001';
  
  // Toggle states for switches
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
    'GENERAL SETTING',
  ];

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
    'PRESSURE SWITCHES',
    'PERMEATE FLUSH',
    'INLET VALVE',
  ];

  final List<String> generalProcessItems = [
    'PRE-CHLORINATION PUMP',
    'DECHLORINATION PUMP',
    'ANTISCALANT PUMP',
    'POST-PH PUMP',
    'POST-CHLORINATION PUMP',
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
      ));
  }

  Widget _buildFeedORPContent() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Color(0xFF4E87DE).withOpacity(0.46),
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
      color: Color(0xFF4E87DE).withOpacity(0.46),
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
    return Container(
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      color: Color(0xFF4E87DE).withOpacity(0.46),
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

  Widget _buildPreChlorinationContent() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Color(0xFF4E87DE).withOpacity(0.46),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleRow('Low-Level Alarm:', 'lowLevelAlarm'),
            _buildSettingRow('Low-Level Shutdown Timer:', ''),
          ],
        ),
      ),
    );
  }

  Widget? _getContentForSubMenu(String subMenu) {
    switch (subMenu) {
      case 'FEED ORP':
        return _buildFeedORPContent();
      case 'FEED TEMPERATURE':
        return _buildFeedTemperatureContent();
      case 'PERMEATE FLUSH':
        return _buildPermeateFlushContent();
      case 'PRE-CHLORINATION PUMP':
        return _buildPreChlorinationContent();
      default:
        return null;
    }
  }

  Widget _buildSelectedContent() {
    Widget? content = _getContentForSubMenu(selectedSubMenu);
    if (content != null) {
      return content;
    }

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
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
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
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
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
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
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
        Container(
          width: 250,
          color: Colors.white,
          child: sideMenu(),
        ),
        Container(
          width: 250,
          color: Colors.white,
          child: _buildSideMenu(),
        ),
        Expanded(
          child: _buildSelectedContent(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'SETTINGS',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              value: selectedPurifier,
              items: ['PURIFIER 1001', 'PURIFIER 1002', 'PURIFIER 1003']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedPurifier = newValue;
                  });
                }
              },
              underline: const SizedBox(),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.notifications, color: Colors.white),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundImage: NetworkImage('https://placeholder.com/user'),
          ),
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
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: _buildContentArea(),
          ),
        ],
      ),
    );
  }
} 