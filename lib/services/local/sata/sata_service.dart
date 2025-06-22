import 'dart:io';

import 'package:collection/collection.dart';
import 'package:iommy/services/dto/sata/sata_dto.dart';
import 'package:iommy/services/service.dart';
import 'package:path/path.dart' as path;

abstract interface class SataService {
  Future<List<SataDTO>> scan();
}

class SataServiceImpl extends Service implements SataService {
  static const _sataClassPath = '/sys/block';
  static const _hexPrefix = '0x';
  static const _emptyChar = '';
  static const _padChar = '0';

  const SataServiceImpl({required super.logger});

  @override
  Future<List<SataDTO>> scan() async {
    final blockDir = Directory(_sataClassPath);
    if (!blockDir.existsSync()) {
      logger.info('[$SataService] $_sataClassPath directory not found');
      return [];
    }

    final blockDevices = blockDir
        .listSync()
        .whereType<Directory>()
        .sortedBy((directory) => directory.path);

    final sataFutures = blockDevices.map((deviceDir) async {
      final deviceName = deviceDir.path.split(Platform.pathSeparator).last;

      final devicePath = Directory('${deviceDir.path}/device');
      final vendorFile = File('${devicePath.path}/vendor');
      final deviceFile = File('${deviceDir.path}/device');
      final modelFile = File('${devicePath.path}/model');
      final pciLink = Link('${devicePath.path}/device');
      final iommuGroupLink = Link('${devicePath.path}/iommu_group');

      if (!devicePath.existsSync() ||
          !vendorFile.existsSync() ||
          !deviceFile.existsSync() ||
          !modelFile.existsSync() ||
          !pciLink.existsSync() ||
          !iommuGroupLink.existsSync()) {
        logger.info(
            '[$SataService] Missing devicePath/vendor/device/model/pciLink/iommu files for SATA device $deviceName');
        return null;
      }

      final vendorHex = (await vendorFile.readAsString()).trim();
      final model = (await modelFile.readAsString()).trim();

      final groupId =
          iommuGroupLink.targetSync().split(Platform.pathSeparator).last;
      final pciId = path.basename(pciLink.targetSync());

      final deviceHex = await deviceFile.readAsString();

      final vendorId = vendorHex
          .trim()
          .replaceFirst(_hexPrefix, _emptyChar)
          .padLeft(4, _padChar)
          .toLowerCase();
      final deviceId = deviceHex
          .trim()
          .replaceFirst(_hexPrefix, _emptyChar)
          .padLeft(4, _padChar)
          .toLowerCase();

      final vendorDeviceId = '$vendorId:$deviceId';

      return SataDTO(
        device: deviceName,
        vendor: vendorHex,
        model: model,
        pciId: pciId,
        vendorDeviceId: vendorDeviceId,
        groupId: groupId,
      );
    });

    final results = await Future.wait(sataFutures);
    return results.whereType<SataDTO>().toList(growable: false);
  }
}
