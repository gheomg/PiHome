import 'package:flutter/material.dart';
import 'package:pihole_manager/globals.dart';
import 'package:pihole_manager/servers/server_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.lightGreen.shade200),
          ),
        ),
        useMaterial3: true,
      ),
      scaffoldMessengerKey: snackBarKey,
      debugShowCheckedModeBanner: false,
      home: const ServerList(),
    );
  }
}
