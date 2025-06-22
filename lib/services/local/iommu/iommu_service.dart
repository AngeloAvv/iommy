import 'dart:io';

import 'package:collection/collection.dart';
import 'package:iommy/services/service.dart';

abstract interface class IommuService {
  Future<List<String>> scan();
}

class IommuServiceImpl extends Service implements IommuService {
  static const _iommuGroupsPath = '/sys/kernel/iommu_groups';

  const IommuServiceImpl({required super.logger});

  @override
  Future<List<String>> scan() async {
    final iommuRoot = Directory(_iommuGroupsPath);

    if (!iommuRoot.existsSync()) {
      logger.info('[$IommuService] IOMMU root directory not found');
      return [];
    }

    final groupDirs =
        iommuRoot.listSync().whereType<Directory>().sortedBy((directory) => directory.path);

    final groupIds = groupDirs
        .map((dir) => dir.path.split(Platform.pathSeparator).last)
        .toList(growable: false);

    logger.info('[$IommuService] Found ${groupIds.length} IOMMU groups');

    return groupIds.sorted((a, b) => int.parse(a).compareTo(int.parse(b)));
  }
}
