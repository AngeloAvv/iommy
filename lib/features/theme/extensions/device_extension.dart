import 'package:flutter/material.dart';
import 'package:iommy/features/theme/colors/device_colors.dart';

extension ColorDeviceBuildContextExtension on ThemeData {
  DeviceExtension? get deviceTheme =>
      extensions[DeviceExtension] as DeviceExtension?;
}

class DeviceExtension extends ThemeExtension<DeviceExtension> {
  final Color? networkColor;
  final Color? nvmeColor;
  final Color? pciColor;
  final Color? sataColor;
  final Color? usbColor;

  const DeviceExtension({
    this.networkColor = DeviceColors.networkColor,
    this.nvmeColor = DeviceColors.nvmeColor,
    this.pciColor = DeviceColors.pciColor,
    this.sataColor = DeviceColors.sataColor,
    this.usbColor = DeviceColors.usbColor,
  });

  @override
  ThemeExtension<DeviceExtension> copyWith() => DeviceExtension(
        networkColor: networkColor,
        nvmeColor: nvmeColor,
        pciColor: pciColor,
        sataColor: sataColor,
        usbColor: usbColor,
      );

  @override
  ThemeExtension<DeviceExtension> lerp(
    covariant ThemeExtension<DeviceExtension>? other,
    double t,
  ) {
    if (other is! DeviceExtension) {
      return this;
    }

    return DeviceExtension(
      networkColor: Color.lerp(networkColor, other.networkColor, t),
      nvmeColor: Color.lerp(nvmeColor, other.nvmeColor, t),
      pciColor: Color.lerp(pciColor, other.pciColor, t),
      sataColor: Color.lerp(sataColor, other.sataColor, t),
      usbColor: Color.lerp(usbColor, other.usbColor, t),
    );
  }
}
