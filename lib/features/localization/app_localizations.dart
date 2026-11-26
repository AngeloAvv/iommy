import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:material_ui/material_ui.dart' show GlobalMaterialLocalizations;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegates.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    ...GlobalMaterialLocalizations.delegates,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Scaffold'**
  String get appName;

  /// No description provided for @actionCollapseAll.
  ///
  /// In en, this message translates to:
  /// **'Collapse All'**
  String get actionCollapseAll;

  /// No description provided for @actionExpandAll.
  ///
  /// In en, this message translates to:
  /// **'Expand All'**
  String get actionExpandAll;

  /// No description provided for @actionSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get actionSettings;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get errorGeneric;

  /// No description provided for @labelIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get labelIdentifier;

  /// No description provided for @labelVendorIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Vendor Identifier'**
  String get labelVendorIdentifier;

  /// No description provided for @labelNetworkInterface.
  ///
  /// In en, this message translates to:
  /// **'Network Interface'**
  String get labelNetworkInterface;

  /// No description provided for @labelMacAddress.
  ///
  /// In en, this message translates to:
  /// **'MAC Address'**
  String get labelMacAddress;

  /// No description provided for @labelDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get labelDeviceName;

  /// No description provided for @labelDeviceModel.
  ///
  /// In en, this message translates to:
  /// **'Device Model'**
  String get labelDeviceModel;

  /// No description provided for @labelDeviceVendor.
  ///
  /// In en, this message translates to:
  /// **'Device Vendor'**
  String get labelDeviceVendor;

  /// No description provided for @labelDeviceSerialNumber.
  ///
  /// In en, this message translates to:
  /// **'Device Serial Number'**
  String get labelDeviceSerialNumber;

  /// Label for the number of devices
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No devices} one {1 device} other {{count} devices}}'**
  String labelDevices(int count);

  /// Label for a group of devices
  ///
  /// In en, this message translates to:
  /// **'Group {id}'**
  String labelGroup(String id);

  /// No description provided for @labelNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get labelNetwork;

  /// No description provided for @labelNetworkDevice.
  ///
  /// In en, this message translates to:
  /// **'Network Device'**
  String get labelNetworkDevice;

  /// No description provided for @labelNvme.
  ///
  /// In en, this message translates to:
  /// **'NVMe'**
  String get labelNvme;

  /// No description provided for @labelNvmeDevice.
  ///
  /// In en, this message translates to:
  /// **'NVMe Device'**
  String get labelNvmeDevice;

  /// No description provided for @labelPci.
  ///
  /// In en, this message translates to:
  /// **'PCI'**
  String get labelPci;

  /// No description provided for @labelPciDevice.
  ///
  /// In en, this message translates to:
  /// **'PCI Device'**
  String get labelPciDevice;

  /// No description provided for @labelSata.
  ///
  /// In en, this message translates to:
  /// **'SATA'**
  String get labelSata;

  /// No description provided for @labelSataDevice.
  ///
  /// In en, this message translates to:
  /// **'SATA Device'**
  String get labelSataDevice;

  /// No description provided for @labelUsb.
  ///
  /// In en, this message translates to:
  /// **'USB'**
  String get labelUsb;

  /// No description provided for @labelUsbDevice.
  ///
  /// In en, this message translates to:
  /// **'USB Device'**
  String get labelUsbDevice;

  /// No description provided for @labelPciClass.
  ///
  /// In en, this message translates to:
  /// **'PCI Class'**
  String get labelPciClass;

  /// No description provided for @labelResetCapable.
  ///
  /// In en, this message translates to:
  /// **'Reset Capable'**
  String get labelResetCapable;

  /// No description provided for @labelYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get labelYes;

  /// No description provided for @labelNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get labelNo;

  /// No description provided for @labelOops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get labelOops;

  /// No description provided for @labelEmptyGroups.
  ///
  /// In en, this message translates to:
  /// **'No groups found.'**
  String get labelEmptyGroups;

  /// No description provided for @labelErrorGroups.
  ///
  /// In en, this message translates to:
  /// **'Error fetching groups. Please try again.'**
  String get labelErrorGroups;

  /// No description provided for @settingsApp.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get settingsApp;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @titleSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get titleSettings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
