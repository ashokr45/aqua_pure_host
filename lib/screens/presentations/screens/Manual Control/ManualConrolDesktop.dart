import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/QAppBar.dart';
import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';

class ManualControlDesktop extends StatefulWidget {
  const ManualControlDesktop({super.key});

  @override
  State<ManualControlDesktop> createState() => _ManualControlDesktopState();
}

class _ManualControlDesktopState extends State<ManualControlDesktop> {
  bool isToggled = false;
  String? selectedValue;
  final List<String> dropdownOptions = ["PURIFIER 1001", "PURIFIER 1002", "PURIFIER 1003"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.3),
        body: Row(children: [
          Container(
            width: 250,
            child: sideMenu(),
          ),
          Expanded(
              // Use Expanded to ensure the grid takes remaining space
              child: Column(
            children: [
              AppBar(
                backgroundColor: TColors.textWhite,
                title: Text(
                  "MANUAL CONTROL",
                  style: GoogleFonts.inknutAntiqua().copyWith(
                    color: TColors.textBlack, // Custom text color
                    fontSize: 25, // Custom font size
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QManualContainer(
                          title: 'Feed Pump',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Pre chlorination dosing',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Dechlorination dosing',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Antiscalant dosing',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Inlet valve',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Permeate flush valve',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Blending valve',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'RO high pressure pump',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Post pH dosing',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Post chlorination dosing',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'UV',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Flush Valve',
                        ),
                        SizedBox(height: 10),
                        QManualContainer(
                          title: 'Divert Valve',
                        ),
                      ]),
                ),
              ),
            ],
          ))
        ]));
  }
}

class QManualContainer extends StatefulWidget {
  final String title;

  const QManualContainer({
    super.key,
    required this.title,
  });

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
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: TColors.textWhite, // Replace with your TColors.appBarColor
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(widget.title),
            Spacer(),
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
