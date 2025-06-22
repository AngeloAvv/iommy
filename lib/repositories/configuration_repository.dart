import 'package:iommy/repositories/repository.dart';
import 'package:iommy/services/configuration_service.dart';
import 'package:flutter/material.dart' hide Route;

/// Abstract class of ConfigurationRepository
abstract interface class ConfigurationRepository {

  Future<ThemeMode> get theme;

  Future<void> setTheme(ThemeMode theme);
}

/// Implementation of the base interface ConfigurationRepository
class ConfigurationRepositoryImpl extends Repository
    implements ConfigurationRepository {
  final ConfigurationService configurationService;

  const ConfigurationRepositoryImpl({
    required this.configurationService,
    required super.logger,
  });

  @override
  Future<ThemeMode> get theme => safeCode(
        () async {
          try {
            logger.info('[$ConfigurationRepository] Getting theme');
            final value = await configurationService.theme;
            logger.info('[$ConfigurationRepository] Got theme: $value');
            return value;
          } catch (error, stackTrace) {
            logger.error(
              '[$ConfigurationRepository] Error getting theme',
              error,
              stackTrace,
            );

            rethrow;
          }
        },
      );

  @override
  Future<void> setTheme(ThemeMode theme) => safeCode(
        () async {
          try {
            logger.info('[$ConfigurationRepository] Setting theme to $theme');
            await configurationService.setTheme(theme);
            logger.info('[$ConfigurationRepository] Theme set to $theme');
          } catch (error, stackTrace) {
            logger.error(
              '[$ConfigurationRepository] Error setting theme',
              error,
              stackTrace,
            );

            rethrow;
          }
        },
      );
}
