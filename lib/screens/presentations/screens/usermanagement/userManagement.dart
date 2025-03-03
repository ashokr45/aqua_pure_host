import 'package:aqua_pure/common/Responsive.dart';
import 'package:aqua_pure/screens/presentations/screens/purifier_manager/purifier_desktop.dart';
import 'package:aqua_pure/screens/presentations/screens/usermanagement/UsermanagementDesktop.dart';
import 'package:aqua_pure/screens/presentations/screens/usermanagement/userManagementMobile.dart';
import 'package:flutter/material.dart';




class Usermanagement extends StatelessWidget {
  const Usermanagement({super.key});


  @override
  Widget build(BuildContext context) {
    return const Responsive(mobile: UserManagementMobileScreen(), desktop: UserManagementDesktop());
  }
}
