import 'package:flutter/material.dart';

import '../../../../common/Responsive.dart';
import 'RealDataMobile.dart';
import 'RealTimeDesktop.dart';

class RealTimeData extends StatelessWidget {
  const RealTimeData({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: RealDataMobile(),
      desktop: RealDataDesktop(),
    );
  }
}
