import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color _iconColor = Colors.white;



  // Backgrounds
  static const Color _lightPrimaryBackgrounds = Colors.white;
  static const Color _lightSecondaryBackgrounds = Colors.blue;
  static const Color _lightOnPrimaryBackgroundsColor = Colors.blue;
  static const Color _lightOnSecondaryBackgroundsColor = Colors.white;
  static const Color _lightCardBackgroundsColor = Colors.white70;

  static const Color _darkPrimaryBackgrounds = Colors.black;
  static const Color _darkSecondaryBackgrounds = Colors.white24;
  static const Color _darkOnPrimaryBackgroundsColor = Colors.blue;
  static const Color _darkOnSecondaryBackgroundsColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryBackgrounds,
    appBarTheme: AppBarTheme(
      color: _lightSecondaryBackgrounds,
      iconTheme: IconThemeData(color: _lightOnSecondaryBackgroundsColor),
    ),
//    colorScheme: ColorScheme.light(
//      primary: _lightPrimaryColor,
//      primaryVariant: _lightPrimaryVariantColor,
//      secondary: _lightSecondaryColor,
//      secondaryVariant: _lightSecondaryVariantColor,
//      onPrimary: _lightOnPrimaryColor,
//      onSecondary: _lightOnSecondaryColor,
//      onSurface: _lightOnSecondaryColor,
//      onBackground: _lightOnSecondaryColor
//
//    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _lightSecondaryBackgrounds,
        foregroundColor: _lightOnSecondaryBackgroundsColor,
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: _lightSecondaryBackgrounds,
    ),
    cardTheme: CardTheme(
      color: _lightCardBackgroundsColor,
      elevation: 5
    ),
    textTheme: _lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
//    bottomNavigationBarTheme: BottomNavigationBarThemeData(
//      selectedItemColor: Colors.blue
//    ),
    scaffoldBackgroundColor: _darkPrimaryBackgrounds,
    appBarTheme: AppBarTheme(
      color: _darkSecondaryBackgrounds,
      iconTheme: IconThemeData(color: _darkOnSecondaryBackgroundsColor),
    ),
    colorScheme: ColorScheme.dark(
    ),
    iconTheme: IconThemeData(
      color: _darkOnSecondaryBackgroundsColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _darkSecondaryBackgrounds,
        foregroundColor: _darkOnSecondaryBackgroundsColor
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _darkSecondaryBackgrounds,
    ),
    cardTheme: CardTheme(
        elevation: 5
    ),
    textTheme: _darkTextTheme,
  );

  static final TextTheme _lightTextTheme = TextTheme(
    headline5: _lightScreenHeadingTextStyle,
    bodyText2: _lightScreenTaskNameTextStyle,
    bodyText1: _lightScreenTaskDurationTextStyle,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline5: _darkScreenHeadingTextStyle,
    bodyText2: _darkScreenTaskNameTextStyle,
    bodyText1: _darkScreenTaskDurationTextStyle,
  );

  static final TextStyle _lightScreenHeadingTextStyle = TextStyle(fontSize: 30.0, color: _lightOnPrimaryBackgroundsColor);
  static final TextStyle _lightScreenTaskNameTextStyle = TextStyle(fontSize: 20.0, color: _lightOnPrimaryBackgroundsColor);
  static final TextStyle _lightScreenTaskDurationTextStyle = TextStyle(fontSize: 15.0, color: Colors.black);

  static final TextStyle _darkScreenHeadingTextStyle = _lightScreenHeadingTextStyle.copyWith(color: _darkOnSecondaryBackgroundsColor);
  static final TextStyle _darkScreenTaskNameTextStyle = _lightScreenTaskNameTextStyle.copyWith(color: _darkOnSecondaryBackgroundsColor);
  static final TextStyle _darkScreenTaskDurationTextStyle = TextStyle(fontSize: 15.0, color: Colors.white);
}