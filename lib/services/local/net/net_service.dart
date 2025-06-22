import 'dart:io';

import 'package:collection/collection.dart';
import 'package:iommy/services/dto/net/net_dto.dart';
import 'package:iommy/services/service.dart';
import 'package:path/path.dart' as path;

abstract interface class NetService {
  Future<List<NetDTO>> scan();
}

class NetServiceImpl extends Service implements NetService {
  static const _netClassPath = '/sys/class/net';
  static const _hexPrefix = '0x';
  static const _emptyChar = '';
  static const _padChar = '0';

  const NetServiceImpl({required super.logger});

  @override
  Future<List<NetDTO>> scan() async {
    final netClassDir = Directory(_netClassPath);

    if (!netClassDir.existsSync()) {
      logger.info('[$NetService] $_netClassPath directory not found');
      return [];
    }

    final ifaceDirs = netClassDir
        .listSync()
        .whereType<Directory>()
        .sortedBy((directory) => directory.path);

    final futures = ifaceDirs.map((ifaceDir) async {
      final ifaceName = path.basename(ifaceDir.path);

      final deviceLink = Link('${ifaceDir.path}/device');
      final macFile = File('${ifaceDir.path}/address');
      final vendorFile = File('${deviceLink.path}/vendor');
      final deviceFile = File('${deviceLink.path}/device');
      final iommuGroupLink = Link('${deviceLink.path}/iommu_group');

      if (!deviceLink.existsSync() ||
          !macFile.existsSync() ||
          !vendorFile.existsSync() ||
          !deviceFile.existsSync() ||
          !iommuGroupLink.existsSync()) {
        logger.info(
            '[$NetService] Missing deviceLink/address/vendor/device/iommu files for interface $ifaceName');
        return null;
      }

      final targetPath = deviceLink.targetSync();
      final pciId = path.basename(targetPath);
      final target = iommuGroupLink.targetSync();
      final groupId = path.basename(target);
      final mac = (await macFile.readAsString()).trim();

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

      return NetDTO(
        interface: ifaceName,
        mac: mac,
        pciId: pciId,
        vendorDeviceId: vendorDeviceId,
        groupId: groupId,
      );
    });

    final results = await Future.wait(futures);
    return results.whereType<NetDTO>().toList(growable: false);
  }
}
