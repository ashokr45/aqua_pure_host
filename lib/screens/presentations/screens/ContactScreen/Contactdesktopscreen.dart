import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/getx_controllers/purifier_controller.dart';
import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';

import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Contactdesktopscreen extends StatefulWidget {
  const Contactdesktopscreen({super.key});

  @override
  State<Contactdesktopscreen> createState() => _ContactdesktopscreenState();
}

class _ContactdesktopscreenState extends State<Contactdesktopscreen> {
  // Remove local state for purifier selection.
  // Use the global controllers instead.
  final PurifierController purifierController = Get.put(PurifierController());
  final PurifierSelectionController purifierSelectionController =
      Get.put(PurifierSelectionController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Custom AppBar height
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: TColors.textBlack),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "CONTACT",
              style: GoogleFonts.inknutAntiqua().copyWith(
                color: TColors.textBlack,
                fontSize: 25,
              ),
            ),
          ),
          actions: [
            // Global dropdown using centralized data.
            Padding(
              padding: const EdgeInsets.only(right: 650.0, top: 30),
              child: Obx(() {
                String currentPurifier = purifierSelectionController.selectedPurifierId.value;
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
                        .map<DropdownMenuItem<String>>((purifier) {
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
          ],
          backgroundColor: TColors.textWhite,
          centerTitle: false,
        ),
      ),
      backgroundColor: TColors.button.withOpacity(0.3),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 250,
              child: sideMenu(),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/sample.png",
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
