import 'package:flutter/material.dart';
import 'package:whollet/global/constant/color.dart';

class AppTheme {
  static ThemeData getOnboardingTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.extremeLightGreyColor,
      appBarTheme: _appBarTheme(),
      textTheme: _textTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData getHomeTheme(){
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkBlueColor,
      appBarTheme: _appBarTheme(),
      textTheme: _textTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme();
  }

  static AppBarTheme _appBarTheme() {
    return AppBarTheme();
  }

  static TextTheme _textTheme(){
    return TextTheme();
  }
}
