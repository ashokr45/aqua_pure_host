import 'package:flutter/material.dart';
import '../../../../common/Responsive.dart';
import 'Main_InterfaceDesktop.dart';
import 'main_interface.dart';



class Interfaceresponsive extends StatelessWidget {
  const Interfaceresponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: MainInterfaceScreen(),
      desktop:  MainInterfaceScreenDesktop(),
    );
  }
}
