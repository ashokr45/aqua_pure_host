import 'package:aqua_pure/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'OverylaySample.dart';
import 'features/authentication/LoginPage/loginPage.dart';
import 'features/presentations/screens/AlarmScreen/Alarmdesktopscreen.dart';
import 'features/presentations/screens/RealData/RealTimeDesktop.dart';
import 'features/presentations/screens/StartScreen/StartPage.dart';



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