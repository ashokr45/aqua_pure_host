import 'package:aqua_pure/getx_controllers/purifier_controller.dart';

import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:aqua_pure/screens/presentations/screens/Dashboard/Dashboard_desktop.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class MainInterfaceScreenDesktop extends StatefulWidget {
  const MainInterfaceScreenDesktop({super.key});

  @override
  State<MainInterfaceScreenDesktop> createState() =>
      _MainInterfaceScreenDesktopState();
}

class _MainInterfaceScreenDesktopState extends State<MainInterfaceScreenDesktop> {
  // Remove local purifier state. We now use global controllers.
  
  // Global controllers.
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
              "MAIN INTERFACE",
              style: GoogleFonts.inknutAntiqua().copyWith(
                color: TColors.textBlack,
                fontSize: 25,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 650.0, top: 30),
              child: Obx(() {
                // Get current selection from global purifier selection controller.
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
                        value: purifier.salesOrderNumber.toString(),
                        child: Text(
                          "PURIFIER ${purifier.salesOrderNumber}",
                          style: TextStyle(
                              color: TColors.textBlack, fontSize: 18),
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
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    child: Obx(() {
                      // Read the selected purifier from the global controller.
                      String selectedValue =
                          purifierSelectionController.selectedPurifierId.value;
                      if (selectedValue.isEmpty) {
                        return Center(
                          child: Text(
                            "Please select a purifier from the dropdown",
                            style: TextStyle(
                                fontSize: 20, color: TColors.textBlack),
                          ),
                        );
                      } else if (selectedValue == "1001" ||
                          selectedValue == "PURIFIER 1001") {
                        return Image.asset(
                          "assets/HMIR.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                        );
                      } else if (selectedValue == "1002" ||
                          selectedValue == "PURIFIER 1002") {
                        return Image.asset(
                          "assets/HMIR2.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                        );
                      } else if (selectedValue == "1003" ||
                          selectedValue == "PURIFIER 1003") {
                        return Image.asset(
                          "assets/HMIR3.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a dynamic button widget.
  Widget buildButton(
      BuildContext context,
      double buttonWidth,
      String title,
      Color startColor,
      Color endColor,
      VoidCallback onPressed) {
    return Container(
      height: 70,
      width: buttonWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            startColor, // Top color.
            endColor,   // Bottom color.
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 2.0, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          foregroundColor: Colors.white,
        ),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String title, String body) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$title'),
        content: Text('$body'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: TColors.button),
            child: Text(
              'OK',
              style: TextStyle(color: TColors.textWhite),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog.
            },
          ),
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: TColors.textBlack),
            ),
          ),
        ],
      );
    },
  );
}
