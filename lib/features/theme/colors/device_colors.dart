import 'package:flutter/material.dart';

sealed class DeviceColors {
  const DeviceColors._();

  static const networkColor = Colors.red;
  static const nvmeColor = Colors.purple;
  static const pciColor = Colors.green;
  static const sataColor = Colors.orange;
  static const usbColor = Colors.blue;
}