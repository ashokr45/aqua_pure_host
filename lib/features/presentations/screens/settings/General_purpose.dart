import 'package:aqua_pure/common/Responsive.dart';
import 'package:flutter/material.dart';

import 'SettingDesktop.dart';
import 'SettingMobile.dart';

class GeneralPurpose extends StatelessWidget {
  const GeneralPurpose({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: SettingMobile(),
      desktop: SettingDesktop(),
    );
  }
}
