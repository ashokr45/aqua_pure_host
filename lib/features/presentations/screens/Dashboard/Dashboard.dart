import 'package:flutter/material.dart';
import '../../../../common/Responsive.dart';
import 'Dashboard_desktop.dart';
import 'Dashboard_mobile.dart';



class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: DashBoardMobile(),
      desktop: DashboardDesktop(),
    );
  }
}
