import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1));

  static final lightThemeMode = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Pallete.backgroundColor),
      scaffoldBackgroundColor: Pallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          focusedBorder: _border(Pallete.brownColor),
          enabledBorder: _border(Pallete.borderColor)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Pallete.backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        selectedItemColor: Pallete.brownColor,
        unselectedItemColor: Pallete.brownColor,
      ));
}
