import 'dart:io';

import 'package:collection/collection.dart';
import 'package:iommy/services/dto/nvme/nvme_dto.dart';
import 'package:iommy/services/service.dart';

abstract interface class NvmeService {
  Future<List<NvmeDTO>> scan();
}

class NvmeServiceImpl extends Service implements NvmeService {
  static const _nvmeClassPath = '/sys/class/nvme';
  static const _hexPrefix = '0x';
  static const _emptyChar = '';
  static const _padChar = '0';

  const NvmeServiceImpl({required super.logger});

  @override
  Future<List<NvmeDTO>> scan() async {
    final nvmeDir = Directory(_nvmeClassPath);
    if (!nvmeDir.existsSync()) {
      logger.info('[$NvmeService] $_nvmeClassPath directory not found');
      return [];
    }

    final nvmeDevices = nvmeDir
        .listSync()
        .whereType<Directory>()
        .sortedBy((directory) => directory.path);

    final nvmeFutures = nvmeDevices.map((deviceDir) async {
      final deviceName = deviceDir.path.split(Platform.pathSeparator).last;

      final devicePath = Directory('${deviceDir.path}/device');
      final modelFile = File('${devicePath.path}/model');
      final serialFile = File('${devicePath.path}/serial');
      final vendorFile = File('${devicePath.path}/vendor');
      final deviceFile = File('${devicePath.path}/device');
      final iommuGroupLink = Link('${devicePath.path}/iommu_group');

      if (!devicePath.existsSync() ||
          !modelFile.existsSync() ||
          !serialFile.existsSync() ||
          !vendorFile.existsSync() ||
          !deviceFile.existsSync() ||
          !iommuGroupLink.existsSync()) {
        logger.info(
            '[$NvmeService] Missing devicePath/model/serial/vendor/device/iommu files for NVMe device $deviceName');
        return null;
      }

      final model = (await modelFile.readAsString()).trim();
      final serial = (await serialFile.readAsString()).trim();
      final groupId =
          iommuGroupLink.targetSync().split(Platform.pathSeparator).last;
      final pciDeviceLink = Link('${deviceDir.path}/device');
      final pciDevicePath =
          pciDeviceLink.existsSync() ? pciDeviceLink.targetSync() : _emptyChar;
      final pciId = pciDevicePath.isNotEmpty
          ? pciDevicePath.split(Platform.pathSeparator).last
          : _emptyChar;

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

      return NvmeDTO(
        device: deviceName,
        model: model,
        serial: serial,
        pciId: pciId,
        vendorDeviceId: vendorDeviceId,
        groupId: groupId,
      );
    });

    final results = await Future.wait(nvmeFutures);
    return results.whereType<NvmeDTO>().toList(growable: false);
  }
}
