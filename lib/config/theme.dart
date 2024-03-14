import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  // Primary color
  primaryColor: const Color(0xFF4BAEFB),

  // Text themes
  primaryTextTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF000000), fontSize: 20.0, fontWeight: FontWeight.normal, fontFamily: 'Roboto'), // Body Large
    bodyMedium: TextStyle(color: Color(0xFF000000), fontSize: 18.0, fontWeight: FontWeight.normal, fontFamily: 'Roboto'), // Body Medium
    bodySmall: TextStyle(color: Color(0xFF000000), fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Roboto'), // Body Small
    headlineLarge: TextStyle(color: Color(0xFF57636C), fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Roboto Condensed'), // Label Large
    headlineMedium: TextStyle(color: Color(0xFF57636C), fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Roboto Condensed'), // Label Medium
    headlineSmall: TextStyle(color: Color(0xFF57636C), fontSize: 12.0, fontWeight: FontWeight.normal, fontFamily: 'Roboto Condensed'), // Label Small
  ),

  // Background colors
  scaffoldBackgroundColor: AppColors.white,
  indicatorColor: const Color(0xFFF9CF58), // Can be used for warnings
  // Success and Info colors can be used in specific widgets
  useMaterial3: true,
);

class AppColors {
  static Color primary = const Color(0xFF4BAEFB);
  static Color secondary = const Color(0xFFEE62C0);
  static Color tertiary = const Color(0xFFF7E03E);
  static Color alternate = const Color(0xFF6DC73C);
  static Color primaryText = const Color(0xFF14181B);
  static Color secondaryText = const Color(0xFF57636C);
  static Color primaryBackground = const Color(0xFFF0F0F0);
  static Color secondaryBackground = const Color(0xFFFFFFFF);
  static Color accent1 = const Color(0x7F4BAEFB);
  static Color accent2 = const Color(0x81EE62C0);
  static Color accent3 = const Color(0xFFBEBEBE);
  static Color accent4 = const Color(0xFFF8F8F8);
  static Color success = const Color(0xFF249689);
  static Color warning = const Color(0xFFF9CF58);
  static Color error = const Color(0xFFFF5963);
  static Color info = const Color(0xFF197DDF);

  static Color customColor1 = const Color(0xFF007AFF);
  static Color customColor2 = const Color(0x99F80D0D);
  static Color customColor3 = const Color(0x9903FB59);
  static Color customColor4 = const Color(0xFFFACD02);

  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);

  static LinearGradient gradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

SizedBox width8 = const SizedBox(width: 8.0);
SizedBox width16 = const SizedBox(width: 16.0);
SizedBox width24 = const SizedBox(width: 24.0);

SizedBox height8 = const SizedBox(height: 8.0);
SizedBox height12 = const SizedBox(height: 12.0);
SizedBox height16 = const SizedBox(height: 16.0);
SizedBox height20 = const SizedBox(height: 20.0);
SizedBox height24 = const SizedBox(height: 24.0);
SizedBox height32 = const SizedBox(height: 32.0);
SizedBox height48 = const SizedBox(height: 48.0);
SizedBox height54 = const SizedBox(height: 54.0);
SizedBox height64 = const SizedBox(height: 64.0);
SizedBox height80 = const SizedBox(height: 80.0);
