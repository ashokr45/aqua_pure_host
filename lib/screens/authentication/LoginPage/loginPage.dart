import 'package:aqua_pure/common/Responsive.dart';
import 'package:flutter/material.dart';

import 'LoginDesktop.dart';
import 'LoginMobile.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: LoginMobile(), desktop: LoginDesktop());
  }
}
