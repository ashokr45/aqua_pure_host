import 'dart:math';

import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:aqua_pure/screens/presentations/screens/Manual%20Control/ManualControlMobile.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';



// -------------------------------------------------------------------------
// MANUAL CONTROL MODEL
// -------------------------------------------------------------------------
class ManualControlModel {
  final int id;
  bool feedPump;
  bool preChlorinationDosing;
  bool dechlorinationDosing;
  bool antiscalantDosing;
  bool inletValve;
  bool permeateFlushValve;
  bool blendingValve;
  bool roHighPressurePump;
  bool postPhDosing;
  bool postChlorinationDosing;
  bool uv;
  bool flushValve;
  bool divertValve;
  final int purifier; // Used when updating the record

  ManualControlModel({
    required this.id,
    required this.feedPump,
    required this.preChlorinationDosing,
    required this.dechlorinationDosing,
    required this.antiscalantDosing,
    required this.inletValve,
    required this.permeateFlushValve,
    required this.blendingValve,
    required this.roHighPressurePump,
    required this.postPhDosing,
    required this.postChlorinationDosing,
    required this.uv,
    required this.flushValve,
    required this.divertValve,
    required this.purifier,
  });

  factory ManualControlModel.fromJson(Map<String, dynamic> json) {
    return ManualControlModel(
      id: json['id'],
      feedPump: json['feed_pump'] ?? false,
      preChlorinationDosing: json['pre_chlorination_dosing'] ?? false,
      dechlorinationDosing: json['dechlorination_dosing'] ?? false,
      antiscalantDosing: json['antiscalant_dosing'] ?? false,
      inletValve: json['inlet_valve'] ?? false,
      permeateFlushValve: json['permeate_flush_valve'] ?? false,
      blendingValve: json['blending_valve'] ?? false,
      roHighPressurePump: json['ro_high_pressure_pump'] ?? false,
      postPhDosing: json['post_ph_dosing'] ?? false,
      postChlorinationDosing: json['post_chlorination_dosing'] ?? false,
      uv: json['uv'] ?? false,
      flushValve: json['flush_valve'] ?? false,
      divertValve: json['divert_valve'] ?? false,
      purifier: json['purifier'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "purifier_id": purifier,
      "feed_pump": feedPump,
      "pre_chlorination_dosing": preChlorinationDosing,
      "dechlorination_dosing": dechlorinationDosing,
      "antiscalant_dosing": antiscalantDosing,
      "inlet_valve": inletValve,
      "permeate_flush_valve": permeateFlushValve,
      "blending_valve": blendingValve,
      "ro_high_pressure_pump": roHighPressurePump,
      "post_ph_dosing": postPhDosing,
      "post_chlorination_dosing": postChlorinationDosing,
      "uv": uv,
      "flush_valve": flushValve,
      "divert_valve": divertValve,
    };
  }
}

// -------------------------------------------------------------------------
// MANUAL CONTROL CONTROLLER
// -------------------------------------------------------------------------
class ManualControlController extends GetxController {
  var isLoading = false.obs;
  // Initialize with default values; these will be updated via API.
  var manualControl = ManualControlModel(
    id: 0,
    feedPump: false,
    preChlorinationDosing: false,
    dechlorinationDosing: false,
    antiscalantDosing: false,
    inletValve: false,
    permeateFlushValve: false,
    blendingValve: false,
    roHighPressurePump: false,
    postPhDosing: false,
    postChlorinationDosing: false,
    uv: false,
    flushValve: false,
    divertValve: false,
    purifier: 0,
  ).obs;

  final GetConnect _getConnect = GetConnect();

  Future<void> fetchData(String purifierId) async {
    try {
      isLoading.value = true;
      final response = await _getConnect.get("http://3.82.225.92:8000/manual_control/$purifierId/");
      if (response.statusCode == 200) {
        manualControl.value = ManualControlModel.fromJson(response.body);
      } else {
        Get.snackbar("Error", "Failed to load manual control data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateData() async {
    try {
      isLoading.value = true;
      final response = await _getConnect.patch(
        "http://3.82.225.92:8000/manual_control/",
        manualControl.value.toJson(),
         headers: {"Content-Type": "application/json"},
      );
      debugPrint(manualControl.value.toJson().toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        manualControl.value = ManualControlModel.fromJson(response.body);
        Get.snackbar("Success", "Manual control updated successfully");
      } else {
        debugPrint(response.body.toString());
        debugPrint(response.statusCode.toString());
        Get.snackbar("Error", "Failed to update manual control data");
      }

     
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

// -------------------------------------------------------------------------
// UPDATED MANUAL CONTROL DESKTOP UI
// -------------------------------------------------------------------------
class ManualControlDesktop extends StatefulWidget {
  const ManualControlDesktop({Key? key}) : super(key: key);

  @override
  State<ManualControlDesktop> createState() => _ManualControlDesktopState();
}

class _ManualControlDesktopState extends State<ManualControlDesktop> {
  final PurifierController purifierController = Get.put(PurifierController());
  final PurifierSelectionController purifierSelectionController =
      Get.put(PurifierSelectionController());
  final ManualControlController manualControlController =
      Get.put(ManualControlController());

  @override
  void initState() {
    super.initState();
    // If a purifier is already selected, fetch its manual control data.
    if (purifierSelectionController.selectedPurifierId.value.isNotEmpty) {
      manualControlController.fetchData(purifierSelectionController.selectedPurifierId.value);
    }
    // Listen for purifier selection changes.
    ever(purifierSelectionController.selectedPurifierId, (String id) {
      if (id.isNotEmpty) {
        manualControlController.fetchData(id);
      }
    });
  }

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
                        String currentSelection =
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
                            value: currentSelection.isEmpty ? null : currentSelection,
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
                    child: Obx(() {
                      if (manualControlController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final data = manualControlController.manualControl.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QManualContainer2(
                            title: 'Feed Pump',
                            value: data.feedPump,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.feedPump = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Pre chlorination dosing',
                            value: data.preChlorinationDosing,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.preChlorinationDosing = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Dechlorination dosing',
                            value: data.dechlorinationDosing,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.dechlorinationDosing = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Antiscalant dosing',
                            value: data.antiscalantDosing,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.antiscalantDosing = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Inlet valve',
                            value: data.inletValve,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.inletValve = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Permeate flush valve',
                            value: data.permeateFlushValve,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.permeateFlushValve = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Blending valve',
                            value: data.blendingValve,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.blendingValve = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'RO high pressure pump',
                            value: data.roHighPressurePump,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.roHighPressurePump = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Post pH dosing',
                            value: data.postPhDosing,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.postPhDosing = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Post chlorination dosing',
                            value: data.postChlorinationDosing,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.postChlorinationDosing = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'UV',
                            value: data.uv,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.uv = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Flush Valve',
                            value: data.flushValve,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.flushValve = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          QManualContainer2(
                            title: 'Divert Valve',
                            value: data.divertValve,
                            onToggle: (val) {
                              manualControlController.manualControl.update((manual) {
                                manual?.divertValve = val;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // Save/Update button
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                manualControlController.updateData();
                       
                              },
                              child: const Text("Save"),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),);

  }}

class QManualContainer2 extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onToggle;

  const QManualContainer2({
    Key? key,
    required this.title,
    required this.value,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        color: Colors.blue.withOpacity(0.3), // Replace with your TColors.appBarColor
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(title),
            const Spacer(),
            FlutterSwitch(
              height: 25.0,
              width: 50.0,
              padding: 4.0,
              toggleSize: 18.0,
              borderRadius: 10.0,
              activeColor: Colors.green,
              inactiveColor: Colors.red,
              value: value,
              onToggle: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}
