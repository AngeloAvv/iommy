import 'package:flutter/material.dart';
import 'package:iommy/features/theme/extensions/device_extension.dart';

class LightTheme {
  static get make => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: const IconThemeData(
            size: 48.0,
          ),
          toolbarHeight: 80,
          titleSpacing: 24.0,
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.grey.shade100,
        ),
        extensions: [
          DeviceExtension(),
        ],
      );
}

class DarkTheme {
  static get make => ThemeData(
        primaryColor: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: const IconThemeData(
            size: 48.0,
          ),
          toolbarHeight: 80,
          titleSpacing: 24.0,
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.grey.shade900,
        ),
        extensions: [
          DeviceExtension(),
        ],
      );
}
