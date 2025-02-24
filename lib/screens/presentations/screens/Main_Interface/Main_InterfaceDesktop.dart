import 'package:aqua_pure/screens/presentations/screens/purifier_manager/PurifyManager.dart';
import 'package:aqua_pure/screens/presentations/screens/purifier_manager/Purify_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';




class MainInterfaceScreenDesktop extends StatefulWidget {
  const MainInterfaceScreenDesktop({super.key});

  @override
  State<MainInterfaceScreenDesktop> createState() =>
      _MainInterfaceScreenDesktopState();
}

class _MainInterfaceScreenDesktopState extends State<MainInterfaceScreenDesktop> {
  String? selectedValue = 'PURIFIER 1001' ;
  final List<String> dropdownOptions = ["PURIFIER 1001", "PURIFIER 1002", "PURIFIER 1003"];

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
                    child: Stack(
                      children: [
                        if (selectedValue == null)
                          Center(
                            child: Text(
                              "Please select a purifier from the dropdown",
                              style: TextStyle(fontSize: 20, color: TColors.textBlack),
                            ),
                          )
                        else if (selectedValue == "PURIFIER 1001")
                          Image.asset(
                            "assets/HMIR.png",
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                          )
                        else if (selectedValue == "PURIFIER 1002")
                            Image.asset(
                              "assets/HMIR2.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height,
                            )
                          else if (selectedValue == "PURIFIER 1003")
                              Image.asset(
                                "assets/HMIR3.png",
                                fit: BoxFit.fill,
                                width: double.infinity,
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

  // Function to build a dynamic button widget
  Widget buildButton(
      BuildContext context,
      double buttonWidth,
      String title,
      Color startColor,
      Color endColor,
      VoidCallback onPressed,
      ) {
    return Container(
      height: 70,
      width: buttonWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            startColor, // Top color (dynamic)
            endColor, // Bottom color (dynamic)
          ],
        ),
        borderRadius: BorderRadius.circular(5), // Rounded corners for gradient
      ),
      child: OutlinedButton(
        onPressed: onPressed, // Dynamic onPressed functionality
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 2.0, color: Colors.white), // White border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          foregroundColor: Colors.white, // Text color
        ),
        child: Text(
          title, // Dynamic title
          style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold), // White text color
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
              Navigator.of(context).pop(); // Close the dialog
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
              )),
        ],
      );
    },
  );
}
