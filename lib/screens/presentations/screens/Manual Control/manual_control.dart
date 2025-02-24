import 'package:aqua_pure/common/Responsive.dart';
import 'package:flutter/material.dart';

import 'ManualConrolDesktop.dart';
import 'ManualControlMobile.dart';

class ManualControl extends StatelessWidget {
  const ManualControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: ManualControlMobile(), desktop: ManualControlDesktop());
  }
}
