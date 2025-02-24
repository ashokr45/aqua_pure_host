import 'package:aqua_pure/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'OverylaySample.dart';
import 'screens/authentication/LoginPage/loginPage.dart';
import 'screens/presentations/screens/AlarmScreen/Alarmdesktopscreen.dart';
import 'screens/presentations/screens/RealData/RealTimeDesktop.dart';
import 'screens/presentations/screens/StartScreen/StartPage.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: MediaQuery.of(context).size.width < 600
          ? LoginPage()
          : LoginPage(),
      // home: Alarmdesktopscreen(),
    );
  }
}