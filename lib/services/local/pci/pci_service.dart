import 'dart:io';

import 'package:collection/collection.dart';
import 'package:iommy/services/dto/identifier/identifier_dto.dart';
import 'package:iommy/services/dto/pci/pci_dto.dart';
import 'package:iommy/services/service.dart';

abstract interface class PciService {
  Future<List<IdentifierDTO>> identifiers();

  Future<List<PciDTO>> scan();
}

class PciServiceImpl extends Service implements PciService {
  static const _pciIdsPath = '/usr/share/misc/pci.ids';
  static const _pciDevicesPath = '/sys/bus/pci/devices';
  static const _hexPrefix = '0x';
  static const _emptyChar = '';
  static const _padChar = '0';

  const PciServiceImpl({required super.logger});

  @override
  Future<List<IdentifierDTO>> identifiers() async {
    final file = File(_pciIdsPath);

    if (!file.existsSync()) {
      logger.info('[$PciService] PCI identifiers file not found');
      return [];
    }

    final lines = await file.readAsLines();

    final List<IdentifierDTO> identifiers = [];
    String? currentVendorId;
    String? currentVendorName;

    for (final line in lines) {
      final trimmed = line.trimRight();

      if (trimmed.isNotEmpty && !trimmed.startsWith('#')) {
        if (!line.startsWith('\t')) {
          final parts = trimmed.split(RegExp(r'\s+'));
          if (parts.length >= 2) {
            currentVendorId = parts[0].toLowerCase().padLeft(4, '0');
            currentVendorName = parts.sublist(1).join(' ');
          } else {
            currentVendorId = null;
            currentVendorName = null;
          }
        } else if (line.startsWith('\t') &&
            currentVendorId != null &&
            currentVendorName != null) {
          final deviceLine = trimmed.trimLeft();
          final parts = deviceLine.split(RegExp(r'\s+'));
          if (parts.length >= 2) {
            final deviceId = parts[0].toLowerCase().padLeft(4, '0');
            final deviceName = parts.sublist(1).join(' ');

            identifiers.add(IdentifierDTO(
              vendorId: currentVendorId,
              deviceId: deviceId,
              vendorName: currentVendorName,
              deviceName: deviceName,
            ));
          }
        }
      }
    }

    return identifiers;
  }

  @override
  Future<List<PciDTO>> scan() async {
    final pciRoot = Directory(_pciDevicesPath);

    if (!pciRoot.existsSync()) {
      logger.info('[$PciService] PCI devices directory not found');
      return [];
    }

    final pciDevices = pciRoot
        .listSync()
        .whereType<Directory>()
        .toList(growable: false)
        .sortedBy((directory) => directory.path);

    final pciFutures = pciDevices.map((deviceDir) async {
      final pciId = deviceDir.path.split(Platform.pathSeparator).last;

      final vendorFile = File('${deviceDir.path}/vendor');
      final deviceFile = File('${deviceDir.path}/device');
      final classFile = File('${deviceDir.path}/class');
      final resetFile = File('${deviceDir.path}/reset');
      final modaliasFile = File('${deviceDir.path}/modalias');
      final iommuGroupLink = Link('${deviceDir.path}/iommu_group');

      if (!vendorFile.existsSync() ||
          !deviceFile.existsSync() ||
          !classFile.existsSync() ||
          !iommuGroupLink.existsSync()) {
        logger.info(
            '[$PciService] Missing vendor/device/class/iommu files for PCI device $pciId');
        return null;
      }

      final vendorHex = (await vendorFile.readAsString())
          .trim()
          .replaceFirst(_hexPrefix, _emptyChar)
          .padLeft(4, _padChar)
          .toLowerCase();
      final deviceHex = (await deviceFile.readAsString())
          .trim()
          .replaceFirst(_hexPrefix, _emptyChar)
          .padLeft(4, _padChar)
          .toLowerCase();
      final vendorDeviceId = '$vendorHex:$deviceHex';

      final pciClass = (await classFile.readAsString()).trim();

      final resetCapable = resetFile.existsSync();

      String description = pciId;
      if (modaliasFile.existsSync()) {
        description = (await modaliasFile.readAsString()).trim();
      }

      final groupId =
          iommuGroupLink.targetSync().split(Platform.pathSeparator).last;

      return PciDTO(
        id: pciId,
        vendorDeviceId: vendorDeviceId,
        description: description,
        pciClass: pciClass,
        resetCapable: resetCapable,
        groupId: groupId,
      );
    });

    final results = await Future.wait(pciFutures);
    return results.whereType<PciDTO>().toList(growable: false);
  }
}
