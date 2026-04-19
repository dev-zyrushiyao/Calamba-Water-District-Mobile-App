import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignSystem {
  //Color Palette FIGMA
  ColorScheme cwdThemeColor() {
    return ColorScheme.fromSeed(
      //Deep Sea Theme - 2E3092
      seedColor: Color(0xFF2E3092),
    ).copyWith(
      primary: Color(0xFF2E3092), // Deep Sea
      onPrimary: Color(0xFF242424), //Orca - Text Primary
      onPrimaryFixedVariant: Color(0xFF616161), //Placeholder Text and Border
      onSecondary: Color(0xFFE6D7D7), //Pearl Horizon - Text Secondary
      surface: Color(0xFFF8F9FA), //Cloud White
      tertiary: Color(0xFFFFC107), //Sunny Yellow
      primaryContainer: Color(0xFF80D8FF), //Ocean Pulse - CTA Primary
      secondaryContainer: Color(0xFF1A5B79), //Tidal Slate - Secondary CTA
      outlineVariant: Color(0xFF2E3092), //Azure Tide - text Link
    );
  }

  //TYPOGRAPHY FIGMA
  TextStyle primaryFont = GoogleFonts.montserrat();
  TextStyle secondaryFont = GoogleFonts.openSans();

  double letterSpacingConverter(double fontSize, double percentage) =>
      fontSize * (percentage / 100);
  double lineHeightConverter(double fontSize, double percentage) =>
      percentage / fontSize;

  //Design System - Typography FIGMA
  TextTheme cwdTypography(TextStyle primaryFont, TextStyle secondaryFont) {
    var semiBold = FontWeight.w600;
    //figma conversion to flutter letter spacing

    return TextTheme(
      //PrimaryFont (H1 , H2 , H3 , Headline , Subhead , Caption)
      headlineLarge: TextStyle(
        fontFamily: primaryFont.fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.0,
        color: cwdThemeColor().onPrimary,
      ), //H1
      headlineMedium: TextStyle(
        fontFamily: primaryFont.fontFamily,
        fontSize: 22,
        fontWeight: semiBold,
        letterSpacing: 0.0,
        color: cwdThemeColor().onPrimary,
      ), //H2
      headlineSmall: TextStyle(
        fontFamily: primaryFont.fontFamily,
        fontSize: 20,
        fontWeight: semiBold,
        letterSpacing: letterSpacingConverter(20.00, 1.5),
        color: cwdThemeColor().onPrimary,
      ), //H3
      titleLarge: TextStyle(
        fontFamily: primaryFont.fontFamily,
        fontSize: 17,
        fontWeight: semiBold,
        letterSpacing: letterSpacingConverter(17.00, 1.5),
        color: cwdThemeColor().onPrimary,
      ), //Headline
      titleMedium: TextStyle(
        fontFamily: primaryFont.fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.normal,
        letterSpacing: letterSpacingConverter(15.00, 1.5),
        color: cwdThemeColor().onPrimary,
      ), //Subhead
      labelSmall: TextStyle(
        fontFamily: primaryFont.fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.normal,
        letterSpacing: letterSpacingConverter(13.00, 1.5),
        height: lineHeightConverter(13.00, 20.00),
        color: cwdThemeColor().onPrimary,
      ), //Caption
      //SecondaryFont (Body , Link , CTA)
      bodyLarge: TextStyle(
        fontFamily: secondaryFont.fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.normal,
        letterSpacing: letterSpacingConverter(17, 5.0),
        height: lineHeightConverter(17.00, 25.00),
        color: cwdThemeColor().onPrimary,
      ), //Body
      bodySmall: TextStyle(
        fontFamily: primaryFont.fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.0,
        color: cwdThemeColor().onPrimary,
      ), //Link
      labelLarge: TextStyle(
        fontFamily: primaryFont.fontFamily,
        fontSize: 17,
        fontWeight: semiBold,
        letterSpacing: 0.0,
        color: cwdThemeColor().onPrimary,
      ), //Call-to-Action
    );
  }
}
