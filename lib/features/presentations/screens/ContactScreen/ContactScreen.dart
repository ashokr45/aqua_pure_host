import 'package:aqua_pure/common/Responsive.dart';
import 'package:aqua_pure/features/presentations/screens/ContactScreen/ContactMobileScreen.dart';
import 'package:aqua_pure/features/presentations/screens/ContactScreen/Contactdesktopscreen.dart';
import 'package:flutter/material.dart';

class Contactscreen extends StatelessWidget {
  const Contactscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: Contactmobilescreen(), desktop: Contactdesktopscreen());
  }
}
