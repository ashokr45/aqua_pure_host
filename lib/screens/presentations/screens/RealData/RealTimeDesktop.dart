import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/QContainerData.dart';
import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';
import '../Dashboard/Graph.dart';

class RealDataDesktop extends StatefulWidget {
  const RealDataDesktop({super.key});

  @override
  State<RealDataDesktop> createState() => _RealDataDesktopState();
}

class _RealDataDesktopState extends State<RealDataDesktop> {
  String? selectedValue;
  final List<String> dropdownOptions = ["PURIFIER 1001", "PURIFIER 1002", "PURIFIER 1003"];

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
                      padding: const EdgeInsets.only(right: 650.0),
                      child: DropdownButton<String>(
                        value: selectedValue,
                        hint: Text(
                          "Select Purifier",
                          style: TextStyle(color: TColors.textBlack, fontSize: 18),
                        ),
                        items: dropdownOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                        dropdownColor: TColors.textWhite,
                        style: TextStyle(color: TColors.textBlack, fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.notification),
                      onPressed: () {
                        // Add your notification functionality here
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QDataContainer(
                          title1: 'Pre Filter Pressure PT1',
                          title2: 'Product Flow Rate 1',
                          title3: 'Post Filter Pressure PT2',
                          title4: 'Reject Flow Rate 2',
                          title5: 'Pump Pressure PT3',
                          title6: 'Recirculation Flow Rate 3',
                          title7: 'System Pressure PT4',
                          title8: 'Water Temperature',
                          title9: 'Reject Pressure PT5',
                          title10: 'Recovery %',
                          title11: 'Interstage  Pressure PT6',
                          title12: 'Rejection %',
                          title13: 'ΔP Prefilter',
                          title14: 'ΔP Membrane',
                          heading: 'Detailed Metrics',
                        ),
                        SizedBox(height: 10.0),
                        // Added an extra title parameter (title6) for alignment
                        QDataContainer(
                          title1: 'FEED ORP',
                          title2: 'Product TDS',
                          title3: 'FEED TDS',
                          title4: 'Product pH',
                          title5: 'FEED pH',
                          title6: '',
                          heading: 'Quality Metrics',
                        ),
                        SizedBox(height: 10.0),
                        QDataContainer(
                          title1: 'Feed Pump Status',
                          title2: 'Blending Valve Status',
                          title3: 'Inlet Valve Status',
                          title4: 'Flush Valve Status',
                          title5: 'Permeate flush valve status',
                          title6: 'Reject Valve Status',
                          title7: 'RO high pressure pump Status',
                          title8: 'Divert Valve Status',
                          heading: 'Component Status',
                        ),
                        SizedBox(height: 10.0),
                        QDataContainer(
                          title1: 'Raw water tank low level Status',
                          title2: 'Antiscalant dosing low level Status',
                          title3: 'Post chlorination low level Status',
                          title4: 'Post pH low level Status',
                          title5: 'Pre chlorination dosing low level status',
                          title6: 'Permeate water tank high-high level switch',
                          title7: 'Dechlorination dosing low level Status',
                          title8: 'Permeate water tank high-medium level switch',
                          heading: 'Level Switches Status',
                        ),
                        QDataContainer(
                          title1: 'Pressure switch low',
                          title2: 'Pressure switch high',
                          heading: 'Pressure Switches Status',
                        ),
                        // Added an extra title parameter (title4) for alignment
                        QDataContainer(
                          title1: 'Pretreat lock out',
                          title2: 'Warning Indicator',
                          title3: 'Current alarm',
                          title4: '',
                          heading: 'Alarms & Warnings',
                        ),
                        // Repeat the containers as needed
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
