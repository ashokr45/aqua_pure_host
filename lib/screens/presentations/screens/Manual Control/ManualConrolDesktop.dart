import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';


class ManualControlDesktop extends StatefulWidget {
  const ManualControlDesktop({super.key});

  @override
  State<ManualControlDesktop> createState() => _ManualControlDesktopState();
}

class _ManualControlDesktopState extends State<ManualControlDesktop> {
  // Global controllers for purifier list and selection.
  final PurifierController purifierController = Get.put(PurifierController());
  final PurifierSelectionController purifierSelectionController =
      Get.put(PurifierSelectionController());

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
                    "MANUAL CONTROL",
                    style: GoogleFonts.inknutAntiqua().copyWith(
                      color: TColors.textBlack,
                      fontSize: 25,
                    ),
                  ),
                  centerTitle: false,
                  toolbarHeight: 90,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 650.0),
                      child: Obx(() {
                        // Get the current selection from global state.
                        String currentSelection = purifierSelectionController.selectedPurifierId.value;
                        if (purifierController.isLoading.value) {
                          return const CircularProgressIndicator();
                        } else if (purifierController.filteredPurifierList.isEmpty) {
                          return Text(
                            "No Purifiers",
                            style: TextStyle(color: TColors.textBlack, fontSize: 18),
                          );
                        } else {
                          return DropdownButton<String>(
                            value: currentSelection.isEmpty ? null : currentSelection,
                            hint: Text(
                              "Select Purifier",
                              style: TextStyle(color: TColors.textBlack, fontSize: 18),
                            ),
                            items: purifierController.filteredPurifierList
                                .map<DropdownMenuItem<String>>((Purifier purifier) {
                              return DropdownMenuItem<String>(
                                value: purifier.salesOrderNumber.toString(),
                                child: Text(
                                  "PURIFIER ${purifier.salesOrderNumber}",
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QManualContainer(title: 'Feed Pump'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Pre chlorination dosing'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Dechlorination dosing'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Antiscalant dosing'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Inlet valve'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Permeate flush valve'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Blending valve'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'RO high pressure pump'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Post pH dosing'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Post chlorination dosing'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'UV'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Flush Valve'),
                        const SizedBox(height: 10),
                        QManualContainer(title: 'Divert Valve'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class QManualContainer extends StatefulWidget {
  final String title;

  const QManualContainer({super.key, required this.title});

  @override
  _QManualContainerState createState() => _QManualContainerState();
}

class _QManualContainerState extends State<QManualContainer> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: TColors.textWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 350),
        child: Row(
          children: [
            Text(widget.title),
            const Spacer(),
            FlutterSwitch(
              height: 25.0,
              width: 50.0,
              padding: 4.0,
              toggleSize: 18.0,
              borderRadius: 10.0,
              activeColor: Colors.green,
              inactiveColor: Colors.red,
              value: isToggled,
              onToggle: (value) {
                setState(() {
                  isToggled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
