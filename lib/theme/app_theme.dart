import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.lightGreen,
      brightness: Brightness.light,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.lightGreen.shade200,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.lightGreen.shade50,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade50,
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 3,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.withOpacity(0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    dividerTheme: const DividerThemeData(
      thickness: 0.5,
      color: Colors.black12,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.green.shade900,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade900,
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 3,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.withOpacity(0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    dividerTheme: const DividerThemeData(
      thickness: 0.5,
      color: Colors.white12,
    ),
  );
}
