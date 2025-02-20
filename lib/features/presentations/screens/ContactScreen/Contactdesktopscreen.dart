import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/sideMenu.dart';
import '../../../../utils/constants/colors.dart';


class Contactdesktopscreen extends StatefulWidget {
  const Contactdesktopscreen({super.key});

  @override
  State<Contactdesktopscreen> createState() => _ContactdesktopscreenState();
}

class _ContactdesktopscreenState extends State<Contactdesktopscreen> {
  String? selectedValue;
  final List<String> dropdownOptions = ["PURIFIER 1001", "PURIFIER 1002", "PURIFIER 1003"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double buttonWidth = screenWidth * 0.21; // Adjust the ratio as needed

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
      body: SafeArea( // Add SafeArea here to avoid overlap
        child: Row(
          children: [
            Container(
              width: 250,
              child: sideMenu(),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/sample.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
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