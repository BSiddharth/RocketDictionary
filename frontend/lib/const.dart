import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Colors
const kDarkModeMainBlack = Color(0xff131313);
const kDarkModeSupportBlackishGrey = Color(0xff272727);
const kAntiFlashWhite = Color(0xffDBDBDB);
const kDarkModeGreen = Color(0xff36EA8E);
const kDeepSkyBlue = Color(0xff3EAFEE);
const kCerulean = Color(0xff1C76A5);
const kCornFlowerBlue = Color(0xff7588E6);
const kPrussianBlue = Color(0xff2F3952);

// Light mode theme
ThemeData lightThemeData = ThemeData(
  unselectedWidgetColor: kPrussianBlue,
  scaffoldBackgroundColor: kAntiFlashWhite,
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    selectedItemColor: kCerulean,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kAntiFlashWhite,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: kAntiFlashWhite, // For both Android + iOS

      // Status bar brightness
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)

      systemNavigationBarColor: kDarkModeSupportBlackishGrey,
    ),
  ),
  iconTheme: const IconThemeData(
    size: 28,
    color: kPrussianBlue,
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
  ),
);

// Dark Mode theme
ThemeData darkThemeData = ThemeData(
    scaffoldBackgroundColor: kDarkModeMainBlack,
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
    appBarTheme: const AppBarTheme(
      backgroundColor: kDarkModeMainBlack,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: kDarkModeMainBlack, // For both Android + iOS

          // Status bar brightness
          statusBarIconBrightness: Brightness.light, // For Android
          statusBarBrightness: Brightness.dark, // For iOS

          systemNavigationBarColor: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kDarkModeSupportBlackishGrey,
      elevation: 0,
      selectedItemColor: kDeepSkyBlue,
      unselectedItemColor: kAntiFlashWhite,
    ),
    iconTheme: const IconThemeData(size: 28, color: kAntiFlashWhite),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(kAntiFlashWhite),
    ));
