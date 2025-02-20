import 'package:aqua_pure/common/QAppBar.dart';
import 'package:aqua_pure/common/sideMenu.dart';
import 'package:aqua_pure/features/presentations/screens/purifier_manager/PurifyManager.dart';
import 'package:aqua_pure/features/presentations/screens/purifier_manager/Purify_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class MainInterfaceScreen extends StatefulWidget {
  const MainInterfaceScreen({super.key});

  @override
  State<MainInterfaceScreen> createState() => _MainInterfaceScreenState();
}

class _MainInterfaceScreenState extends State<MainInterfaceScreen> {
  // Declare the GlobalKey as a member variable.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.22; // Adjust the ratio as needed
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      key: _scaffoldKey,
      appBar: QAppBar(
        menuIcon: Iconsax.menu_1,
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        notificationIcon: Iconsax.notification,
        userIcon: Iconsax.user,
        title: 'Main interface',
      ),
      drawer: sideMenu(),
      body: Stack(
        children: [
          // Background image occupies the entire screen.
          Positioned.fill(
            child: Image.asset(
              "assets/HMIR.png",
              fit: BoxFit.contain,
            ),
          ),
          // Additional content widgets can be added here if needed.
        ],
      ),
      // Fix the buttons at the bottom using bottomNavigationBar.
      bottomNavigationBar: Container(
        // You can set a background color here if you need to create contrast.
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
              context,
              buttonWidth,
              'STOP',
              Colors.white,
              Colors.red,
              () {
                showAlertDialog(
                  context,
                  'Confirm',
                  'Are you sure you want to stop the system?',
                );
              },
            ),
            buildButton(
              context,
              buttonWidth,
              'RUN',
              Colors.white,
              Colors.green,
              () {
                showAlertDialog(
                  context,
                  'Confirm',
                  'Are you sure you want to run the system?',
                );
              },
            ),
            buildButton(
              context,
              buttonWidth,
              'ALARM SILENCE',
              Colors.white,
              Colors.orange,
              () {
                showAlertDialog(
                  context,
                  'Confirm',
                  'Are you sure you want to silence the system?',
                );
              },
            ),
            buildButton(
              context,
              buttonWidth,
              'MENU',
              Colors.white,
              Colors.blueAccent,
              () {
                Get.to(() => purifyManager());
              },
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
          side: const BorderSide(width: 2.0, color: Colors.white),
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
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
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
        title: Text(title),
        content: Text(body),
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
            style: ElevatedButton.styleFrom(backgroundColor: TColors.grey),
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
