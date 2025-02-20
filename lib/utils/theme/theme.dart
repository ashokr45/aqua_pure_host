import 'package:aqua_pure/utils/theme/text_theme.dart';
import 'package:aqua_pure/utils/theme/textfield_theme.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: TColors.textWhite,
    textTheme: TTextTheme.lightTextTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,

  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.DarkTextTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,


  );
}
