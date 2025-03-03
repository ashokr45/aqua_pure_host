// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../../common/QAppBar.dart';
// import '../../../../common/QContainerData.dart';
// import '../../../../common/sideMenu.dart';
// import '../../../../utils/constants/colors.dart';





// class SettingMobile extends StatefulWidget {
//   const SettingMobile({super.key});

//   @override
//   State<SettingMobile> createState() => _SettingMobileState();
// }

// class _SettingMobileState extends State<SettingMobile> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   // State variable to track the selected widget
//   String selectedView = 'general'; // Initially, show the general view

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: sideMenu(),
//       appBar: QAppBar(
//         notificationIcon: Iconsax.notification,
//         userIcon: Iconsax.user,
//         title: 'Settings',
//         menuIcon: Iconsax.menu_1,
//         onPressed: () {
//           _scaffoldKey.currentState?.openDrawer();
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Text("Home / Settings"),
//               ),
//               ExpansionTile(
//                 title: Text("General Process"),
//                 onExpansionChanged: (isExpanded) {
//                   if (isExpanded) {
//                     setState(() {
//                       selectedView = 'general'; // Show QGeneralContainer on expanding "General Process"
//                     });
//                   }
//                 },
//                 children: [
//                   ExpansionTile(
//                     title: Text("Instruments"),
//                     onExpansionChanged: (isExpanded) {
//                       if (isExpanded) {
//                         setState(() {
//                           selectedView = ''; // Reset view when instrument submenu is expanded
//                         });
//                       }
//                     },
//                     children: [
//                       ListTile(
//                         title: Text("RO Feed ORP"),
//                         onTap: () {
//                           setState(() {
//                             selectedView = 'data1'; // Show QDataContainer for this submenu
//                           });
//                         },
//                       ),
//                       ListTile(
//                         title: Text("RO Premeat Conductivity"),
//                         onTap: () {
//                           setState(() {
//                             selectedView = 'data2'; // You can use different views for other submenus
//                           });
//                         },
//                       ),
//                       ListTile(
//                         title: Text("RO Premeat pH"),
//                         onTap: () {
//                           setState(() {
//                             selectedView = 'data1';
//                           });
//                         },
//                       ),
//                       ListTile(
//                         title: Text("RO Product Conductivity"),
//                         onTap: () {
//                           setState(() {
//                             selectedView = 'data2';
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   ExpansionTile(
//                     title: Text("User’s Manager"),
//                     children: [
//                       ListTile(
//                         title: Text("User"),
//                         onTap: () {
//                           setState(() {
//                             selectedView = 'userManager'; // Optionally handle other views
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5),
//               if (selectedView == 'general') QGeneralContainer(),
//               if (selectedView == 'data1')
//                 QDataContainer(
//                   title1: 'Pressure Readings',
//                   title2: 'Temp Readings',
//                   title3: 'Flow Rates',
//                   title4: 'Conductivity',
//                   title5: 'Conductivity',
//                   title6: 'Conductivity',
//                   title7: 'Conductivity',
//                   title8: 'Conductivity',
//                   title9: 'Conductivity',
//                   title10: 'Conductivity',
//                   heading: 'Detailed Metrics',
//                 ),
//               if (selectedView == 'data2')
//                 QDataContainer(
//                   title1: 'Another ',
//                   title2: 'Another Metric 2',
//                   title3: 'Another Metric 3',
//                   title4: 'Another Metric 4',
//                   title5: 'Another Metric 5',
//                   title6: 'Another Metric 6',
//                   title7: 'Another Metric 7',
//                   title8: 'Another Metric 8',
//                   title9: 'Another Metric 9',
//                   title10: 'Another Metric 10',
//                   heading: 'Different Detailed Metrics',
//                 ),
//               if(selectedView == 'userManager')
//                 QpasswordReset()


//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// class QGeneralContainer extends StatefulWidget {
//   const QGeneralContainer({
//     super.key,
//   });

//   @override
//   _QGeneralContainerState createState() => _QGeneralContainerState();
// }

// class _QGeneralContainerState extends State<QGeneralContainer> {
//   bool isToggled = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(4.0)),
//           color:
//           Colors.blue.withOpacity(0.3), // Customize your background color
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(children: [
//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),


//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),
//             Divider(color: TColors.textWhite,),

//             QGeneralRow(),
//             SizedBox(height: 10),


//           ]),
//         ));
//   }
// }

// class QGeneralRow extends StatelessWidget {
//   const QGeneralRow({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text("Valve Open/Close Delay (secs)"),
//         Spacer(),
//         Container(
//           height: 25,
//           width: 80,
//           decoration:
//           BoxDecoration(border: Border.all(), color: TColors.inactiveBtn),
//           child: Text(
//             "5",
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
// }


// class QpasswordReset extends StatelessWidget {
//   const QpasswordReset({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(4.0)),
//         color:
//         Colors.blue.withOpacity(0.3), // Customize your background color
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Text("Reset Password"),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 labelText: 'Username Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 labelText: 'New Password',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 labelText: 'Confirmed Password',
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black, // foreground (text) color
//                     backgroundColor: Colors.white, // background color
//                   ),
//                   onPressed: (){},
//                   child: const Text('Submit'),
//                 ),
//                 SizedBox(width: 5),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black, // foreground (text) color
//                     backgroundColor: Colors.white, // background color
//                   ),
//                   onPressed: (){},
//                   child: const Text('cancel'),
//                 )

//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:aqua_pure/common/QAppBar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingMobile extends StatefulWidget {
  const SettingMobile({super.key});

  @override
  State<SettingMobile> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingMobile> {
  String selectedSection = 'Instruments';
  String selectedItem = 'FEED ORP';
  
  final Map<String, List<String>> sections = {
    'General Process': [
      'PRE-CHLORINATION PUMP',
      'DECHLORINATION PUMP',
      'ANTISCALANT PUMP',
      'POST-PH PUMP',
      'POST-CHLORINATION PUMP',
      'BLENDING',
      'DIVERT',
      'FLUSH',
    ],
    'Instruments': [
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
    ],
  };

  Widget buildInstrumentSettings() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildReadingSection(),
            const SizedBox(height: 20),
            buildCalibrationSection(),
            const SizedBox(height: 20),
            buildLimitSection(),
          ],
        ),
      ),
    );
  }

  Widget buildReadingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reading(mv)',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: const Text(
            '+289.3',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget buildCalibrationSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '@ 4mA (mv)',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: const Text(''),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '@ 20mA (mv)',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: const Text(''),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLimitSection() {
    return Column(
      children: [
        buildLimitRow(
          'Low Limit\nMonitoring',
          'High Limit\nMonitoring',
          'OFF',
          'OFF',
        ),
        const SizedBox(height: 16),
        buildLimitRow(
          'Low Limit\nAlarm',
          'High Limit\nAlarm',
          'OFF',
          'OFF',
        ),
        const SizedBox(height: 16),
        buildLimitRow(
          'Low Limit\n(gpm)',
          'High Limit\n(gpm)',
          '+0.0',
          '+240.0',
        ),
      ],
    );
  }

  Widget buildLimitRow(String leftLabel, String rightLabel, String leftValue, String rightValue) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leftLabel,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Text(leftValue),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rightLabel,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Text(rightValue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFlushSettings() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0267FF).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildToggleRow('Flush'),
            const SizedBox(height: 16),
            buildSettingRow('Flush on start-up:'),
            buildSettingRow('Flush on shutdown:'),
            buildSettingRow('Standby interval flush:'),
            buildSettingRow('Running interval flush:'),
            buildSettingRow('Product conductivity flush:'),
            buildSettingRow('Flush duration(seconds):'),
            buildSettingRow('Standby interval(hours):'),
            buildSettingRow('Running interval(hours):'),
            buildSettingRow('Product conductivity limit(µS/cm or ppm):'),
            buildSettingRow('Product conductivity delay (minutes):'),
            buildSettingRow('Flush source:'),
            const SizedBox(height: 16),
            buildToggleRow('High pressure pump:'),
          ],
        ),
      ),
    );
  }

  Widget buildToggleRow(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Switch(
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget buildSettingRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: const Text(''),
            ),
          ),
        ],
      ),
    );
  }
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
      appBar: QAppBar(
        
        menuIcon: Iconsax.menu_1,
       onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        notificationIcon: Iconsax.notification,
        userIcon: Iconsax.user,
        title: 'Settings',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section selection
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: sections.keys.map((section) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedSection = section;
                          selectedItem = sections[section]![0];
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            selectedSection == section
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right,
                          ),
                          Text(
                            section,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: selectedSection == section
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // List of items for the selected section
            if (selectedSection.isNotEmpty)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF0267FF).withOpacity(0.2),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sections[selectedSection]!.length,
                  itemBuilder: (context, index) {
                    final item = sections[selectedSection]![index];
                    return ListTile(
                      dense: true,
                      title: Text(
                        item,
                        style: TextStyle(
                          color: selectedItem == item ? Colors.blue : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedItem = item;
                        });
                      },
                    );
                  },
                ),
              ),
            // Settings content
            selectedItem == 'PERMEATE FLUSH'
                ? buildFlushSettings()
                : buildInstrumentSettings(),
          ],
        ),
      ),
    );
  }
}
