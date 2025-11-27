import 'package:e_commerce_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: BasicChipTheme.lightChipTheme,
    appBarTheme: BasicAppBarTheme.lightAppBarTheme,
    checkboxTheme: BasicCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: BasicBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: BasicOutlinedButtonTheme.lishtOutLinedButtonTheme,
    inputDecorationTheme: BasicTextFieldTheme.lightTextFieldTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: BasicChipTheme.darkChipTheme,
    appBarTheme: BasicAppBarTheme.darkAppBarTheme,
    checkboxTheme: BasicCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: BasicBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: BasicOutlinedButtonTheme.darkOutLinedButtonTheme,
    inputDecorationTheme: BasicTextFieldTheme.darkTextFieldTheme,
  );
}
