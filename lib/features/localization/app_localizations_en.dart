// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Scaffold';

  @override
  String get actionCollapseAll => 'Collapse All';

  @override
  String get actionExpandAll => 'Expand All';

  @override
  String get actionSettings => 'Settings';

  @override
  String get actionRetry => 'Retry';

  @override
  String get errorGeneric => 'Something went wrong!';

  @override
  String get labelIdentifier => 'Identifier';

  @override
  String get labelVendorIdentifier => 'Vendor Identifier';

  @override
  String get labelNetworkInterface => 'Network Interface';

  @override
  String get labelMacAddress => 'MAC Address';

  @override
  String get labelDeviceName => 'Device Name';

  @override
  String get labelDeviceModel => 'Device Model';

  @override
  String get labelDeviceVendor => 'Device Vendor';

  @override
  String get labelDeviceSerialNumber => 'Device Serial Number';

  @override
  String labelDevices(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count devices',
      one: '1 device',
      zero: 'No devices',
    );
    return '$_temp0';
  }

  @override
  String labelGroup(String id) {
    return 'Group $id';
  }

  @override
  String get labelNetwork => 'Network';

  @override
  String get labelNetworkDevice => 'Network Device';

  @override
  String get labelNvme => 'NVMe';

  @override
  String get labelNvmeDevice => 'NVMe Device';

  @override
  String get labelPci => 'PCI';

  @override
  String get labelPciDevice => 'PCI Device';

  @override
  String get labelSata => 'SATA';

  @override
  String get labelSataDevice => 'SATA Device';

  @override
  String get labelUsb => 'USB';

  @override
  String get labelUsbDevice => 'USB Device';

  @override
  String get labelPciClass => 'PCI Class';

  @override
  String get labelResetCapable => 'Reset Capable';

  @override
  String get labelYes => 'Yes';

  @override
  String get labelNo => 'No';

  @override
  String get labelOops => 'Oops!';

  @override
  String get labelEmptyGroups => 'No groups found.';

  @override
  String get labelErrorGroups => 'Error fetching groups. Please try again.';

  @override
  String get settingsApp => 'App';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get titleSettings => 'Settings';
}
