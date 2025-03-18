import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'package:aqua_pure/common/sideMenu.dart';

class GeneralSettingsPage extends StatefulWidget {
  const GeneralSettingsPage({Key? key}) : super(key: key);

  @override
  State<GeneralSettingsPage> createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  bool autoTimeEnabled = false;
  bool timeZoneEnabled = true;
  String selectedTimeZone = 'Select Time Zone';

  final PurifierController purifierController = Get.put(PurifierController());
  final PurifierSelectionController purifierSelectionController =
      Get.put(PurifierSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left sidebar from shared widget
          Container(
            width: 250,
            child: sideMenu(),
          ),
          // Main content area
          Expanded(
            child: Column(
              children: [
                // Updated App Bar using previous style
                AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 90,
                  elevation: 1,
                  title: Text(
                    'GENERAL SETTINGS',
                    style: GoogleFonts.inknutAntiqua().copyWith(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  centerTitle: false,
                  actions: [
                  
             Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Obx(() {
                  // Get the current selection from the global controller.
                  String currentPurifier =
                      purifierSelectionController.selectedPurifierId.value;
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
                // Breadcrumb navigation
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  color: Colors.grey.shade100,
                  child: Row(
                    children: const [
                      Text(
                        'General Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 18),
                      Text(
                        'Date & Time',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Main content
                Expanded(
                  child: Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Settings categories (left panel)
                        Container(
                          width: 250,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.keyboard_arrow_down),
                                  SizedBox(width: 8),
                                  Text(
                                    'GENERAL SETTINGS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildSettingsCategory('LANGUAGE & LOCALIZATION'),
                              _buildSettingsCategory('DATE & TIME', isSelected: true),
                              _buildSettingsCategory('MEASUREMENT UNITS'),
                              _buildSettingsCategory('CALIBRATION & SENSOR'),
                              _buildSettingsCategory('NOTIFICATIONS'),
                              _buildSettingsCategory('SECURITY & ACCESS CONTROL'),
                              _buildSettingsCategory('USER MANAGEMENT'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Settings configuration (right panel)
                        Expanded(
                          child: Row(
                            children: [
                              // Time configuration
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Manual/Automatic Time Configuration:',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Set time automatically'),
                                          Switch(
                                            value: autoTimeEnabled,
                                            onChanged: (value) {
                                              setState(() {
                                                autoTimeEnabled = value;
                                              });
                                            },
                                            activeColor: Colors.green,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Set date and time manually'),
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.grey.shade200,
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            ),
                                            child: const Text(
                                              'Change',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              // Time zone configuration
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Time Zone & Daylight Saving:',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Switch(
                                            value: timeZoneEnabled,
                                            onChanged: (value) {
                                              setState(() {
                                                timeZoneEnabled = value;
                                              });
                                            },
                                            activeColor: Colors.green,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedTimeZone,
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            items: <String>[
                                              'Select Time Zone',
                                              '(GMT-05:00) Indiana (East)',
                                              '(GMT-05:00) Eastern Time',
                                              '(GMT-04:00) Atlantic Time (Canada)',
                                            ].map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedTimeZone = newValue!;
                                              });
                                            },
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

  Widget _buildSettingsCategory(String title, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}
