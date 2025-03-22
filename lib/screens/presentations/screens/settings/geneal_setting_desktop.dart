import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';

class GeneralSettingsPage extends StatelessWidget {
  const GeneralSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purifier 1001 Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Remove scaffoldBackgroundColor to let the gradient take over.
        // scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SettingsHomePage(),
    );
  }
}

class SettingsHomePage extends StatefulWidget {
  const SettingsHomePage({super.key});

  @override
  State<SettingsHomePage> createState() => _SettingsHomePageState();
}

class _SettingsHomePageState extends State<SettingsHomePage> {
  String selectedOption = "USER MANAGEMENT";

  // Initialize your purifier controllers (assuming these are set up in your app)
  final PurifierController purifierController = Get.put(PurifierController());
  final PurifierSelectionController purifierSelectionController =
      Get.put(PurifierSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap the body in a Container with a gradient so that it applies to all areas.
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4E87DE), Color(0xFF357ABD)],
          ),
        ),
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Row(
                children: [
                  // Existing side menu from your common/sideMenu.dart
                  Container(
                    width: 250,
                    color: Colors.white, // or transparent if you want the gradient to show
                    child: sideMenu(),
                  ),
                  // Your custom sidebar with settings menu
                  _buildSidebar(),
                  // Main content area
                  Expanded(
                    child: _buildSelectedPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "GENERAL SETTINGS",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              // Dynamic Purifier Dropdown using Obx
              Obx(() {
                String currentPurifier =
                    purifierSelectionController.selectedPurifierId.value;
                if (purifierController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else if (purifierController.filteredPurifierList.isEmpty) {
                  return const Text(
                    "No Purifiers",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  );
                } else {
                  return DropdownButton<String>(
                    value: currentPurifier.isEmpty ? null : currentPurifier,
                    hint: const Text(
                      "Select Purifier",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    items: purifierController.filteredPurifierList
                        .map<DropdownMenuItem<String>>((Purifier purifier) {
                      return DropdownMenuItem<String>(
                        value: purifier.id.toString(),
                        child: Text(
                          "${purifier.name} ${purifier.location}",
                          style:
                              const TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        purifierSelectionController.updateSelection(newValue);
                      }
                    },
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    underline: const SizedBox(),
                  );
                }
              }),
              const SizedBox(width: 20),
              const Icon(Icons.notifications_outlined, color: Colors.blue),
              const SizedBox(width: 16),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://www.example.com/placeholder.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('DC'));
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Danielle Campbell",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 300,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumbs(),
          const SizedBox(height: 20),
          _buildSettingsMenu(),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    String secondPart = '';
    if (selectedOption == "USER MANAGEMENT") {
      secondPart = "User Management";
    } else if (selectedOption == "SECURITY & ACCESS CONTROL") {
      secondPart = "Security & Access Control";
    } else if (selectedOption == "NOTIFICATIONS") {
      secondPart = "Notifications";
    } else if (selectedOption == "CALIBRATION & SENSOR") {
      secondPart = "Calibration & Sensor";
    } else if (selectedOption == "MEASUREMENT UNITS") {
      secondPart = "Measurement Units";
    } else if (selectedOption == "DATE & TIME") {
      secondPart = "Date & Time";
    } else if (selectedOption == "LANGUAGE & LOCALIZATION") {
      secondPart = "Language & Localization";
    }

    return Row(
      children: [
        const Text(
          "General Settings",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.chevron_right, size: 18, color: Colors.black54),
        const SizedBox(width: 3),
        Text(
          secondPart,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: 11
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.expand_more, size: 20),
            SizedBox(width: 8),
            Text(
              "GENERAL SETTINGS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        _buildMenuItem("LANGUAGE & LOCALIZATION"),
        _buildMenuItem("DATE & TIME"),
        _buildMenuItem("MEASUREMENT UNITS"),
        _buildMenuItem("CALIBRATION & SENSOR"),
        _buildMenuItem("NOTIFICATIONS"),
        _buildMenuItem("SECURITY & ACCESS CONTROL"),
        _buildMenuItem("USER MANAGEMENT"),
      ],
    );
  }

  Widget _buildMenuItem(String title) {
    bool isSelected = selectedOption == title;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedOption = title;
          });
        },
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedPage() {
    switch (selectedOption) {
      case "USER MANAGEMENT":
        return const UserManagementPage();
      case "SECURITY & ACCESS CONTROL":
        return const SecurityPage();
      case "NOTIFICATIONS":
        return const NotificationsPage();
      case "CALIBRATION & SENSOR":
        return const CalibrationPage();
      case "MEASUREMENT UNITS":
        return const MeasurementUnitsPage();
      case "DATE & TIME":
        return const DateTimePage();
      case "LANGUAGE & LOCALIZATION":
        return const LanguagePage();
      default:
        return const Center(child: Text("Select an option"));
    }
  }
}


// User Management Page
class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     // color: Colors.blue,
       decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade200],
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildRoleBasedAccess(),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPermissionControl(),
                  const SizedBox(height: 24),
                  _buildAuditLog(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBasedAccess() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Role-Based Access",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildAccessOption("ADD USER", true),
          const SizedBox(height: 12),
          _buildAccessOption("EDIT USER", true),
          const SizedBox(height: 12),
          _buildAccessOption("REMOVE USERS", true),
        ],
      ),
    );
  }

  Widget _buildAccessOption(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: isSelected
                ? const Center(
                    child: Icon(
                      Icons.circle,
                      size: 16,
                      color: Colors.green,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionControl() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Permissions Control:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: true,
            onChanged: (value) {},
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLog() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Audit Log:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: false,
            onChanged: (value) {},
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Security & Access Control Page
class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade200],
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildLoginCredentials(),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSessionTimeout(),
                  const SizedBox(height: 24),
                  _buildEncryptionSettings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginCredentials() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Login Credentials/PINs:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildCredentialOption("Manage passwords"),
          const SizedBox(height: 12),
          _buildCredentialOption("PIN codes"),
        ],
      ),
    );
  }

  Widget _buildCredentialOption(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSessionTimeout() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Session Timeout:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 16),
                onPressed: () {},
              ),
              const Text(
                "5 mins",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEncryptionSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Encryption Settings:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: false,
            onChanged: (value) {},
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Notifications Page
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade200],
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildNotificationOption("On-screen alerts:", true),
            const SizedBox(height: 24),
            _buildNotificationOption("Alarms:", false),
            const SizedBox(height: 24),
            _buildNotificationOption("SMS, email, or push notification:", false),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption(String label, bool isEnabled) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {},
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Calibration & Sensor Page
class CalibrationPage extends StatelessWidget {
  const CalibrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade200],
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildCalibrationRoutines(),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCalibrationOption("Recalibration Reminders:", true),
                  const SizedBox(height: 24),
                  _buildCalibrationOption("Sensor Offset:", false),
                  const SizedBox(height: 24),
                  _buildCalibrationOption("Correction Factors:", false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalibrationRoutines() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Calibration Routines:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildRoutineOption("Flow"),
          const SizedBox(height: 12),
          _buildRoutineOption("TDS/\nConductivity"),
          const SizedBox(height: 12),
          _buildRoutineOption("Pressure"),
        ],
      ),
    );
  }

  Widget _buildRoutineOption(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCalibrationOption(String label, bool isEnabled) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {},
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Measurement Units Page
class MeasurementUnitsPage extends StatelessWidget {
  const MeasurementUnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
   decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade200],
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildMetricImperialConversion(),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 2,
              child: _buildCustomizableResolution(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricImperialConversion() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Metric/Imperial Conversion:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUnitDropdown("Flow", "▼"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildUnitOption("GPM"),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildUnitOption("m³/h"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUnitDropdown("Pressure", "▼"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildUnitOption("PSI"),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildUnitOption("BAR"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUnitDropdown("Temperature", "▼"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildUnitOption("Celsius °C"),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildUnitOption("Fahrenheit °F"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUnitDropdown("Conductivity", "▼"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildUnitOption("PPM"),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildUnitOption("µS/cm"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildUnitOption("mg/L"),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(), // Empty container for alignment
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnitDropdown(String label, String icon) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          icon,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildUnitOption(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCustomizableResolution() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Customizable Resolution:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: true,
            onChanged: (value) {},
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Date & Time Page
class DateTimePage extends StatelessWidget {
  const DateTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade200],
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTimeConfiguration(),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 1,
              child: _buildTimeZoneSettings(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeConfiguration() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Manual/Automatic Time Configuration:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                "Set time automatically",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Switch(
                value: false,
                onChanged: (value) {},
                activeColor: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                "Set date and time manually",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: const Text("Change"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeZoneSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Time Zone & Daylight Saving:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select Time Zone",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _buildTimeZoneOption("(GMT-05:00) Indiana (East)"),
          const SizedBox(height: 4),
          _buildTimeZoneOption("(GMT-05:00) Eastern Time"),
          const SizedBox(height: 4),
          _buildTimeZoneOption("(GMT-04:00) Atlantic Time (Canada)"),
        ],
      ),
    );
  }

 Widget _buildTimeZoneOption(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        Icon(
          Icons.check_circle_outline,
          size: 20,
          color: Colors.grey,
        ),
      ],
    ),
  );
}}


class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<LanguagePage> {
  String selectedLanguage = 'English';
  String selectedTimeFormat = '12-hour';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade200],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSettingCard(
                title: 'Language selection:',
                selectedValue: selectedLanguage,
                options: ['English', 'Spanish', 'French', 'German', 'Chinese'],
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
              ),
              const SizedBox(width: 30),
              _buildSettingCard(
                title: 'Date & Time Format:',
                selectedValue: selectedTimeFormat,
                options: ['12-hour', '24-hour'],
                onChanged: (value) {
                  setState(() {
                    selectedTimeFormat = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required String selectedValue,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Container(
      width: 320,
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: true,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                ),
                items: options
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

