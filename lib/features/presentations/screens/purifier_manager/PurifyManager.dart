import 'package:aqua_pure/common/Responsive.dart';
import 'package:aqua_pure/features/presentations/screens/purifier_manager/purifier_desktop.dart';
import 'package:flutter/material.dart';

import 'Purify_manager.dart';


class purifyManager extends StatelessWidget {
  const purifyManager({super.key});


  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: PurifierMobile(), desktop: PurifierDesktop());
  }
}
