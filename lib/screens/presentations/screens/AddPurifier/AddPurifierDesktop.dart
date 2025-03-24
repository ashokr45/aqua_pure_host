import 'package:aqua_pure/apis/purifier_apis.dart';
import 'package:aqua_pure/apis/user_api_purifier.dart';
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/models/user_model.dart';
import 'package:aqua_pure/models/user_model_purifier.dart';
import 'package:aqua_pure/screens/presentations/screens/purifier_manager/purifier_desktop.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPurifierDesktop extends StatefulWidget {
  final Purifier? purifier;
  const AddPurifierDesktop({Key? key, this.purifier}) : super(key: key);

  @override
  _AddPurifierDesktopState createState() => _AddPurifierDesktopState();
}

class _AddPurifierDesktopState extends State<AddPurifierDesktop> {
  int currentStep = 0;

  // Controllers for Purifier Details
  TextEditingController _systemModelController = TextEditingController();
  TextEditingController _serialController = TextEditingController();
  TextEditingController _salesOrderController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _manufacturerDateController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  // Remove status controller in favor of radio buttons
  String _status = 'active';

  // Users (for user role selection)
  TextEditingController _userRoleSearchController = TextEditingController();
  List<User> users = [];
  List<User> filteredUsers = [];
  List<int> selectedUserIds = [];

  // Configuration map (for purifier configurations)
  Map<String, bool> configuration = {};
  final List<String> configurationKeys = [
    "FEED_TANK",
    "INLET_VALVE_INCLUDED",
    "PREFILTER_PRESSURE_TRANSDUCER_PT1",
    "PREFILTER",
    "POST_FILTER_PRESSURE_TRANSDUCER_PT2",
    "FEED_PH_PH1",
    "FEED_TDS_TDS1",
    "PRESSURE_SWITCH_LOW_INCLUDED",
    "RO_HIGH_PRESSURE_PUMP_INCLUDED",
    "PUMP_PRESSURE_TRANSDUCER_PT3",
    "GLOBE_VALVE",
    "PRODUCT_TDS_TDS2_INCLUDED",
    "PRODUCT_FLOW_METER_F1",
    "REJECT_VALVE",
    "REJECT_FLOW_METER_F2",
    "RAW_TANK_LOW_LEVEL_SWITCH",
    "FEED_PUMP",
    "PRECHLORINATION_DOSING",
    "PRECHLORINATION_DOSING_LOW_LEVEL_SWITCH",
    "DECHLORINATION_DOSING",
    "DECHLORINATION_DOSING_LOW_LEVEL_SWITCH",
    "ANTISCALANT_DOSING",
    "ANTISCALANT_DOSING_LOW_LEVEL_SWITCH",
    "PERMEATE_FLUSH_VALVE",
    "FEED_ORP_ORP",
    "BLENDING_VALVE",
    "SYSTEM_PRESSURE_TRANSDUCER_PT4",
    "BLENDING_NEEDLE_VALVE",
    "PRESSURE_SWITCH_HIGH",
    "POST_PH",
    "POST_PH_LOW_LEVEL_SWITCH",
    "POST_CHLORINATION_LOW_LEVEL_SWITCH",
    "UV_DISINFECTION",
    "PRODUCT_PH_PH2",
    "INTERSTAGE_PRESSURE_TRANSDUCER_PTS",
    "RECIRCULATION_VALVE",
    "RECIRCULATION_FLOW_METER_F3",
    "REJECT_PRESSURE_TRANSDUCER_PT6",
    "FLUSH_VALVE",
    "PERMEATE_WATER_TANK_HIGH_HIGH_LEVEL_SWITCH",
    "PERMEATE_WATER_TANK_HIGH_MEDIUM_LEVEL_SWITCH",
    "DIVERT_VALVE",
  ];

  @override
  void initState() {
    super.initState();
    fetchUsers();
    initializeConfiguration();
    if (widget.purifier != null) {
      prefillFields(widget.purifier!);
    }
    // Prepopulate filtered users list
    filteredUsers = List.from(users);
  }

  void fetchUsers() async {
    try {
      users = await UserApi.fetchUsers();
      filteredUsers = users;
      setState(() {});
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    }
  }

  void initializeConfiguration() {
    configuration = Map.fromIterable(configurationKeys,
        key: (k) => k, value: (k) => false);
  }

  void prefillFields(Purifier purifier) {
    _systemModelController.text = purifier.systemModelNumber;
    _serialController.text = purifier.serialno;
    _salesOrderController.text = purifier.salesOrderNumber;
    _nameController.text = purifier.name;
    _manufacturerDateController.text = purifier.manufactureDate;
    _locationController.text = purifier.location;
    _status = purifier.status;
    selectedUserIds = List.from(purifier.users);
    configuration = Map.from(purifier.configuration);
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _manufacturerDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  // ================== UI Widgets ======================

  Widget _buildStepIndicator() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem('Purifier Details', 0),
          SizedBox(height: 20),
          _buildStepItem('Purifier Configurations', 1),
          SizedBox(height: 20),
          _buildStepItem('User Role', 2),
        ],
      ),
    );
  }

  Widget _buildStepItem(String title, int step) {
    return InkWell(
      onTap: () => setState(() => currentStep = step),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: currentStep == step ? Colors.blue : Colors.black,
            ),
          ),
          if (currentStep == step)
            Icon(Iconsax.arrow_right, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildPurifierDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Purifier Details",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            _buildTextField(
                controller: _systemModelController,
                label: "System Model Number"),
            SizedBox(height: 20),
            _buildTextField(
                controller: _serialController, label: "Serial Number"),
            SizedBox(height: 20),
            _buildTextField(
                controller: _salesOrderController,
                label: "Sales Order Number"),
            SizedBox(height: 20),
            _buildTextField(
                controller: _nameController, label: "Purifier Name"),
            SizedBox(height: 20),
            _buildTextField(
              controller: _manufacturerDateController,
              label: "Manufacturer Date",
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ),
            SizedBox(height: 20),
            _buildTextField(
                controller: _locationController, label: "Location"),
            SizedBox(height: 20),
            // Radio buttons for status selection
            Text(
              "Status",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'active',
                  groupValue: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                Text("Active"),
                SizedBox(width: 20),
                Radio<String>(
                  value: 'inactive',
                  groupValue: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                Text("Inactive"),
              ],
            ),
            SizedBox(height: 30),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPurifierConfigurations() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Purifier Configurations",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          // Header row
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            color: Colors.blue,
            child: Row(
              children: [
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Sr.no',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Configuration',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: Text(
                    'Checkbox',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // List of configuration rows
          Expanded(
            child: ListView.builder(
              itemCount: configurationKeys.length,
              itemBuilder: (context, index) {
                final key = configurationKeys[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            key,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        alignment: Alignment.center,
                        child: Checkbox(
                          value: configuration[key] ?? false,
                          onChanged: (bool? value) {
                            setState(() {
                              configuration[key] = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildUserRole() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("User Role",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          // Search bar for filtering users
          TextField(
            controller: _userRoleSearchController,
            decoration: InputDecoration(
              labelText: "Search User Role",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                filteredUsers = users
                    .where((user) => user.username
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            },
          ),
          SizedBox(height: 20),
          // List of users with checkboxes
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return CheckboxListTile(
                    title: Text("${user.username} (${user.role})"),
                    value: selectedUserIds.contains(user.id),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedUserIds.add(user.id);
                        } else {
                          selectedUserIds.remove(user.id);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildNavigationButtons(isLastStep: true),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    Widget? suffixIcon,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildNavigationButtons({bool isLastStep = false}) {
    return Row(
      children: [
        if (currentStep > 0)
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                currentStep--;
              });
            },
            icon: Icon(Iconsax.arrow_left, color: Colors.black),
            label: Text(
              'Back',
              style: TextStyle(color: Colors.black),
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {
            if (isLastStep) {
              submitPurifier();
            } else {
              setState(() {
                currentStep++;
              });
            }
          },
          icon: Icon(
              isLastStep ? Icons.save : Iconsax.arrow_right,
              color: Colors.white),
          label: Text(
              isLastStep ? 'Save' : 'Next',
              style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ],
    );
  }

  // ================== Submit Function ======================

 void submitPurifier() async {
  final purifierData = {
    "user_ids": selectedUserIds,
    "purifier_manager": {
      "system_model_number": _systemModelController.text,
      "serial_number": _serialController.text,
      "sales_order_number": _salesOrderController.text,
      "purifier_name": _nameController.text,
      "manufacture_date": _manufacturerDateController.text,
      "location": _locationController.text,
      "status": _status,
    },
    "configuration": configuration,
  };

  try {
    if (widget.purifier == null) {
      print('Adding purifier...');
      await PurifierApi.addPurifier(purifierData);
      print('Purifier added successfully');
     if (mounted) {
     
      Future.delayed(Duration(milliseconds: 500), () {
        print('Navigating back...');
        Get.to(PurifierDesktop());

         Get.snackbar(
        'Success',
        'Purifier added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      });

      
    }
    print('Refreshing purifier list...');
    Get.find<PurifierController>().fetchPurifiers();
    } else {
      print('Updating purifier...');
      await PurifierApi.updatePurifier(widget.purifier!.id, purifierData);
      print('Purifier updated successfully');
      if (mounted) {
        if (mounted) {
     
      Future.delayed(Duration(milliseconds: 500), () {
        print('Navigating back...');
        Get.to(PurifierDesktop());

         Get.snackbar(
        'Success',
        'Purifier added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      });

      
    }
      }
    }

    Get.find<PurifierController>().fetchPurifiers();
  } catch (e) {
    print('Error: $e');
    if (mounted) {
      Get.snackbar(
        'Error',
        'Failed to ${widget.purifier == null ? "add" : "update"} purifier: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

  // ================== Main Build ======================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Side menu
          Container(
            width: 250,
            child: sideMenu(),
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    "PURIFIER MANAGER",
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Iconsax.notification),
                      onPressed: () {},
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStepIndicator(),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: currentStep == 0
                                ? _buildPurifierDetails()
                                : currentStep == 1
                                    ? _buildPurifierConfigurations()
                                    : _buildUserRole(),
                          ),
                        ),
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
}
