import 'dart:io';

import 'package:collection/collection.dart';
import 'package:iommy/services/dto/usb/usb_dto.dart';
import 'package:iommy/services/service.dart';

abstract interface class UsbService {
  Future<List<UsbDTO>> scan();
}

class UsbServiceImpl extends Service implements UsbService {
  static const _usbClassPath = '/sys/bus/usb/devices';
  static const _pciRegex = r'^[0-9a-f]{4}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9]$';

  const UsbServiceImpl({required super.logger});

  @override
  Future<List<UsbDTO>> scan() async {
    final usbDevicesDir = Directory(_usbClassPath);

    if (!usbDevicesDir.existsSync()) {
      logger.info('[$UsbService] $_usbClassPath directory not found');
      return [];
    }

    final entries = usbDevicesDir
        .listSync()
        .whereType<Directory>()
        .sortedBy((directory) => directory.path);

    final futures = entries.map((entry) async {
      final deviceName = entry.path.split(Platform.pathSeparator).last;

      if (deviceName.contains(':')) return null;

      final vendorFile = File('${entry.path}/idVendor');
      final productFile = File('${entry.path}/idProduct');
      final productNameFile = File('${entry.path}/product');

      if (!vendorFile.existsSync() || !productFile.existsSync()) {
        logger.info(
            '[$UsbService] Missing vendor/product files for USB device $deviceName');
        return null;
      }

      final vendorId = (await vendorFile.readAsString()).trim().toLowerCase();
      final productId = (await productFile.readAsString()).trim().toLowerCase();
      final vendorDeviceId = '$vendorId:$productId';

      final name = productNameFile.existsSync()
          ? (await productNameFile.readAsString()).trim()
          : deviceName;

      String? pciId;
      String? groupId;

      try {
        final resolvedPath = entry.resolveSymbolicLinksSync();

        String? currentPath = resolvedPath;
        while (
            currentPath != Platform.pathSeparator && currentPath!.isNotEmpty) {
          final pciDevice = Directory(currentPath).absolute;
          final pciDeviceName =
              pciDevice.path.split(Platform.pathSeparator).last;

          if (RegExp(_pciRegex).hasMatch(pciDeviceName)) {
            pciId = pciDeviceName;
            final iommuLink = Link('$currentPath/iommu_group');
            if (iommuLink.existsSync()) {
              groupId =
                  iommuLink.targetSync().split(Platform.pathSeparator).last;
            }
            break;
          }

          currentPath = Directory(currentPath).parent.path;
        }
      } catch (error, stackTrace) {
        logger.info(
          '[$UsbService] Error resolving PCI/IOMMU for $deviceName',
          error,
          stackTrace,
        );
      }

      if (pciId == null || groupId == null) {
        logger.info(
          '[$UsbService] No PCI ID or IOMMU group found for USB device $deviceName',
        );
        return null;
      }

      return UsbDTO(
        name: name,
        pciId: pciId,
        vendorDeviceId: vendorDeviceId,
        groupId: groupId,
      );
    });

    final results = await Future.wait(futures);
    return results.whereType<UsbDTO>().toList(growable: false);
  }
}
