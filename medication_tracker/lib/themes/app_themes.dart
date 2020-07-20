import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color _iconColor = Colors.white;



  // Backgrounds
  static const Color _lightPrimaryColor = Colors.white;
  // Cards
  static const Color _lightPrimaryVariantColor = Colors.white;
  // Buttons
  static const Color _lightSecondaryColor = Colors.blue;
  static const Color _lightSecondaryVariantColor = Colors.white;
  // Text on background
  static const Color _lightOnPrimaryColor = Colors.blue;
  // Text on cards/ buttons
  static const Color _lightOnSecondaryColor = Colors.white;

  static const Color _darkPrimaryColor = Colors.black;
  static const Color _darkPrimaryVariantColor = Colors.white24;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkSecondaryVariantColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkOnSecondaryColor = Colors.blue;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: AppBarTheme(
      color: _lightSecondaryColor,
      iconTheme: IconThemeData(color: _lightOnSecondaryColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      secondaryVariant: _lightSecondaryVariantColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondary: _lightOnSecondaryColor,
    ),
    iconTheme: IconThemeData(
      color: Colors.blue,
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.blue
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _lightSecondaryColor,
        foregroundColor: _lightOnSecondaryColor
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: _lightSecondaryColor
    ),
    cardTheme: CardTheme(
      color: Colors.white70,
      elevation: 5
    ),
    textTheme: _lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
//    bottomNavigationBarTheme: BottomNavigationBarThemeData(
//      selectedItemColor: Colors.blue
//    ),
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(
      color: _darkPrimaryVariantColor,
      iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    ),
    colorScheme: ColorScheme.dark(
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _darkPrimaryVariantColor,
        foregroundColor: _darkOnPrimaryColor
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _darkPrimaryVariantColor
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

  static final TextStyle _lightScreenHeadingTextStyle = TextStyle(fontSize: 30.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskNameTextStyle = TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskDurationTextStyle = TextStyle(fontSize: 15.0, color: Colors.black);

  static final TextStyle _darkScreenHeadingTextStyle = _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);
  static final TextStyle _darkScreenTaskNameTextStyle = _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);
  static final TextStyle _darkScreenTaskDurationTextStyle = TextStyle(fontSize: 15.0, color: Colors.white);
}