import 'package:aqua_pure/common/Responsive.dart';
import 'package:flutter/material.dart';
import 'AlarmMobileScreen.dart';
import 'Alarmdesktopscreen.dart';

class Alarmscreen extends StatelessWidget {
  const Alarmscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: Alarmmobilescreen(), desktop: Alarmdesktopscreen());
  }
}
