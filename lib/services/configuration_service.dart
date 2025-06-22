import 'dart:async';

import 'package:flutter/material.dart' hide Route;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

/// Abstract class of ConfigurationService
abstract interface class ConfigurationService {
  Future<ThemeMode> get theme;

  Future<void> setTheme(ThemeMode theme);
}

/// Implementation of the base interface ConfigurationService
class ConfigurationServiceImpl implements ConfigurationService {
  static const _themeKey = 'theme';

  final Future<SharedPreferences> sharedPreferences;
  final Talker logger;

  ConfigurationServiceImpl({
    required this.sharedPreferences,
    required this.logger,
  });

  @override
  Future<ThemeMode> get theme async {
    try {
      final prefs = await sharedPreferences;

      logger.info('[$ConfigurationService] Getting theme');
      final value = prefs.getString(_themeKey) ?? ThemeMode.system.name;
      logger.info('[$ConfigurationService] theme: $value');

      return ThemeMode.values.firstWhere((theme) => theme.name == value);
    } catch (error, stackTrace) {
      logger.error(
        '[$ConfigurationService] Error getting theme',
        error,
        stackTrace,
      );

      rethrow;
    }
  }


  @override
  Future<void> setTheme(ThemeMode theme) async {
    try {
      logger.info('[$ConfigurationService] Setting theme: $theme');
      final prefs = await sharedPreferences;
      await prefs.setString(_themeKey, theme.name);
      logger.info('[$ConfigurationService] Theme set to $theme');
    } catch (error, stackTrace) {
      logger.error(
        '[$ConfigurationService] Error setting theme',
        error,
        stackTrace,
      );

      rethrow;
    }
  }
}
