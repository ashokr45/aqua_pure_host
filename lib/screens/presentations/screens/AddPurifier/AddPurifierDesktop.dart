import 'package:aqua_pure/apis/purifier_apis.dart';
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/screens/presentations/screens/purifier_manager/PurifyManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPurifierDesktop extends StatefulWidget {
  const AddPurifierDesktop({super.key});

  @override
  State<AddPurifierDesktop> createState() => _AddPurifierDesktopState();
}

class _AddPurifierDesktopState extends State<AddPurifierDesktop> {
  int currentStep = 0;
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController salesOrderController = TextEditingController();
  final TextEditingController manufactureDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Configuration items list
  List<Map<String, dynamic>> configItems = [
    {'name': 'Feed Tank', 'isSelected': false},
    {'name': 'Raw Water Tank Low Level Switch', 'isSelected': false},
    {'name': 'Feed Pump', 'isSelected': false},
    {'name': 'Prechlorination dosing', 'isSelected': false},
    {'name': 'Prechlorination dosing Low Level Switch', 'isSelected': false},
    {'name': 'Dechlorination dosing', 'isSelected': false},
    {'name': 'Dechlorination dosing Low Level Switch', 'isSelected': false},
    {'name': 'Inlet Valve (Included)', 'isSelected': false},
    {'name': 'Antiscalant dosing', 'isSelected': false},
    {'name': 'Antiscalant dosing Low Level Switch', 'isSelected': false},
    {'name': 'Permeate Flush Valve', 'isSelected': false},
    {'name': 'Prefilter pressure Transducer (PT1)', 'isSelected': false},
    {'name': 'Prefilter', 'isSelected': false},
    {'name': 'Post filter pressure Transducer (PT2)', 'isSelected': false},
    {'name': 'Feed pH (pH1)', 'isSelected': false},
    {'name': 'Feed ORP (ORP)', 'isSelected': false},
    {'name': 'Feed TDS (TDS1)', 'isSelected': false},
    {'name': 'Blending Valve', 'isSelected': false},
    {'name': 'Pressure Switch Low (Included)', 'isSelected': false},
    {'name': 'RO High Pressure Pump (Included)', 'isSelected': false},
    {'name': 'Pump Pressure Transducer (PT3)', 'isSelected': false},
    {'name': 'Globe Valve', 'isSelected': false},
    {'name': 'System Pressure Transducer (PT4)', 'isSelected': false},
    {'name': 'Blending Needle Valve', 'isSelected': false},
    {'name': 'Pressure Switch High', 'isSelected': false},
    {'name': 'Product TDS (TDS2) (Included)', 'isSelected': false},
    {'name': 'Post pH', 'isSelected': false},
    {'name': 'Post pH low Level Switch', 'isSelected': false},
    {'name': 'Post Chlorination Low Level Switch', 'isSelected': false},
    {'name': 'UV Disinfection', 'isSelected': false},
    {'name': 'Product Flow Meter (F1)', 'isSelected': false},
    {'name': 'Product pH (pH2)', 'isSelected': false},
    {'name': 'Interstage Pressure Transducer (PT5)', 'isSelected': false},
    {'name': 'Recirculation Valve', 'isSelected': false},
    {'name': 'Recirculation Flow Meter (F3)', 'isSelected': false},
    {'name': 'Reject Pressure Transducer (PT6)', 'isSelected': false},
    {'name': 'Flush Valve', 'isSelected': false},
    {'name': 'Reject Valve', 'isSelected': false},
    {'name': 'Reject Flow Meter (F2)', 'isSelected': false},
    {'name': 'Permeate Water Tank High - High Level Switch', 'isSelected': false},
    {'name': 'Permeate Water Tank High - Medium Level Switch', 'isSelected': false},
    {'name': 'Divert Valve', 'isSelected': false},
    {'name': 'Permeate Water Tank Low Level Switch', 'isSelected': false},
    {'name': 'Distribution Pump', 'isSelected': false},
    {'name': 'Product Pressure Transducer', 'isSelected': false},
    {'name': 'Product Pressure Switch', 'isSelected': false},
  ];

  // Locked configuration items (pre-selected and non-editable)
  final List<String> lockedItems = [
    'Feed Tank',
    'Inlet Valve (Included)',
    'Prefilter pressure Transducer (PT1)',
    'Prefilter',
    'Post filter pressure Transducer (PT2)',
    'Feed pH (pH1)',
    'Feed TDS (TDS1)',
    'Pressure Switch Low (Included)',
    'RO High Pressure Pump (Included)',
    'Pump Pressure Transducer (PT3)',
    'Globe Valve',
    'Product TDS (TDS2) (Included)',
    'Product Flow Meter (F1)',
    'Reject Valve',
    'Reject Flow Meter (F2)',
  ];

  // List of available user roles
  List<String> userRoles = [
    'UserName1 (Supervisor)',
    'UserName2 (Pure Aqua Engineer)',
    'UserName3 (Operator)',
    'UserName4 (Dealer)',
    'UserName5 (Admin)',
    'UserName6 (Dealer)',
    'UserName7 (Admin)',
    'UserName8 (Pure Aqua Engineer)',
  ];
  List<String> selectedRoles = [];
  List<String> filteredUserRoles = [];
  final TextEditingController userRoleSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Prepopulate filtered user roles with all roles initially.
    filteredUserRoles = List.from(userRoles);
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
        manufactureDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Purifier Details",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30),
        _buildTextField(
          controller: serialNumberController,
          label: "Serial Number",
        ),
        SizedBox(height: 20),
        _buildTextField(
          controller: salesOrderController,
          label: "Sales Order Number",
        ),
        SizedBox(height: 20),
        _buildTextField(
          controller: manufactureDateController,
          label: "Manufacture Date",
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ),
        SizedBox(height: 20),
        _buildTextField(
          controller: locationController,
          label: "Location",
        ),
        SizedBox(height: 30),
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildPurifierConfigurations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Purifier Configurations",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        // Header row with column headings
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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Variant',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: 80,
                alignment: Alignment.center,
                child: Text(
                  'Checkbox',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        // List of configuration rows
        Container(
          height: 400,
          child: ListView.builder(
            itemCount: configItems.length,
            itemBuilder: (context, index) {
              // Check if this config item should be locked (pre-selected and non-editable)
              bool isLocked = lockedItems.contains(configItems[index]['name']);
              if (isLocked) {
                configItems[index]['isSelected'] = true;
              }
              return Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                color: Colors.white,
                child: Row(
                  children: [
                    // Sr.no Column
                    Container(
                      width: 430,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Variant Column
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          configItems[index]['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // Checkbox Column
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: Checkbox(
                        value: configItems[index]['isSelected'],
                        onChanged: isLocked
                            ? null
                            : (bool? value) {
                                setState(() {
                                  configItems[index]['isSelected'] = value;
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
    );
  }

  Widget _buildUserRole() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "User Role",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30),
        // Search bar for user role filtering
        TextField(
          controller: userRoleSearchController,
          decoration: InputDecoration(
            labelText: "Search User Role",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              filteredUserRoles = userRoles
                  .where((role) =>
                      role.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          },
        ),
        SizedBox(height: 20),
        // Display selected roles as chips
        if (selectedRoles.isNotEmpty)
          Wrap(
            spacing: 8,
            children: selectedRoles.map((role) {
              return Chip(
                label: Text(role),
                onDeleted: () {
                  setState(() {
                    selectedRoles.remove(role);
                  });
                },
              );
            }).toList(),
          ),
        SizedBox(height: 20),
        // Wrap the user roles ListView with a Scrollbar
        Container(
          height: 400,
          child: Scrollbar(
            child: ListView.builder(
              itemCount: filteredUserRoles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredUserRoles[index]),
                  onTap: () {
                    setState(() {
                      if (!selectedRoles.contains(filteredUserRoles[index])) {
                        selectedRoles.add(filteredUserRoles[index]);
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
            label: Text('Back', style: TextStyle(color: Colors.black)),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () async {
            if (isLastStep) {
              await _submitForm();
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

  // This function validates the fields, constructs the data payload, and calls the API.
  Future<void> _submitForm() async {
    if (serialNumberController.text.isEmpty ||
        salesOrderController.text.isEmpty ||
        manufactureDateController.text.isEmpty ||
        locationController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields.");
      return;
    }

    // Construct purifier data with necessary null handling
    Map<String, dynamic> purifierData = {
      "serial_number": serialNumberController.text.trim(),
      "sales_order_number": salesOrderController.text.trim(),
      // Example: using the serial number to generate a purifier name. Adjust as needed.
      "purifier_name": "Purifier ${serialNumberController.text.trim()}",
      "manufacture_date": manufactureDateController.text.trim(),
      "location": locationController.text.trim(),
      "status": "active",
      // Assuming user id is 1 (or map selected role to user id as needed)
      "user": 1,
      // Optionally send configurations and roles if required by your API
      "configurations": configItems
          .where((item) => item['isSelected'] == true)
          .map((item) => item['name'])
          .toList(),
      "roles": selectedRoles,
    };

    try {
      await PurifierApi.addPurifier(purifierData);
      Get.snackbar("Success", "Purifier added successfully.");
      // Navigate to the purifier page; adjust the route name as per your app's routing.
   await  Get.to(() => purifyManager());
    } catch (e) {
      Get.snackbar("Error", "Failed to add purifier: ${e.toString()}");
    }
  }

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
