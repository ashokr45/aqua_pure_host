import 'package:aqua_pure/screens/presentations/screens/Main_Interface/select_purifier.dart';
import 'package:aqua_pure/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/QAppBar.dart';
import '../../../../common/QContainerSquare.dart';
import '../../../../common/sideMenu.dart';
import '../Main_Interface/main_interfaceResponsive.dart';
import 'Graph.dart';

class DashBoardMobile extends StatefulWidget {
  const DashBoardMobile({super.key});

  @override
  State<DashBoardMobile> createState() => _DashBoardMobileState();
}

class _DashBoardMobileState extends State<DashBoardMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double containerWidth = screenSize.width * 0.45;
    final double containerHeight = screenSize.height * 0.21;

    return Scaffold(
      key: _scaffoldKey,
      appBar: QAppBar(
        menuIcon: Iconsax.menu_1,
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        notificationIcon: Iconsax.notification,
        userIcon: Iconsax.user,
        title: 'Dashboard'
      ),
      drawer: sideMenu(),
      body: SingleChildScrollView(  // Make the column scrollable
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Home / Dashboard"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QContainer(
                  titleText: "05\nPurifiers",
                  activeText: "03 Active",
                  inactiveText: "02 Inactive",
                  moreInfoText: "More info",
                  titleIcon: Iconsax.box,
                  moreInfoIcon: Iconsax.direct_right,
                  startColor: const Color(0xFF0D4456),
                  endColor: const Color(0xFF1D95BC),
                  dividerColor: Colors.white,
                  width: containerWidth,
                  height: containerHeight,
                ),
                SizedBox(width: screenSize.width * 0.02),
                GestureDetector(
                  onTap: (){
                    Get.to(() => MainInterFaceSelectPurifier());
                  },
                  child: QContainer(
                    titleText: "Main\nInterface",
                    activeText: "",
                    inactiveText: "",
                    moreInfoText: "More info",
                    titleIcon: Iconsax.menu_board4,
                    moreInfoIcon: Iconsax.direct_right,
                    startColor: const Color(0xFF4B1D0A),
                    endColor: const Color(0xFFC75829),
                    dividerColor: Colors.white,
                    width: containerWidth,
                    height: containerHeight,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QContainer(
                  titleText: "34\nNotification",
                  activeText: "",
                  inactiveText: "",
                  moreInfoText: "More info",
                  titleIcon: Iconsax.notification,
                  moreInfoIcon: Iconsax.direct_right,
                  startColor: const Color(0xFF354C10),
                  endColor: const Color(0xFF7CB224),
                  dividerColor: Colors.white,
                  width: containerWidth,
                  height: containerHeight,
                ),
                SizedBox(width: screenSize.width * 0.02),
                QContainer(
                  titleText: "10\nAlarm",
                  activeText: "",
                  inactiveText: "",
                  moreInfoText: "More info",
                  titleIcon: Iconsax.alarm,
                  moreInfoIcon: Iconsax.direct_right,
                  startColor: const Color(0xFF70470A),
                  endColor: const Color(0xFFD68814),
                  dividerColor: Colors.white,
                  width: containerWidth,
                  height: containerHeight,
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.02),
            // Wrapping the chart inside an Expanded widget
            Container(
              height: 300,  // Set a specific height to avoid infinite height error
              child: QGraph(),
            ),
            SizedBox(height: 20),
            Container(
              height: 300,  // Set a specific height to avoid infinite height error
              child: QGraph(),
            ),
          ],
        ),
      ),
    );
  }
}
