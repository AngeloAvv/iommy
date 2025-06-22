import 'package:flutter_essentials_kit/extensions/iterable.dart';
import 'package:iommy/misc/mappers/net/net_mapper.dart';
import 'package:iommy/misc/mappers/nvme/nvme_mapper.dart';
import 'package:iommy/misc/mappers/pci/pci_mapper.dart';
import 'package:iommy/misc/mappers/sata/sata_mapper.dart';
import 'package:iommy/misc/mappers/usb/usb_mapper.dart';
import 'package:iommy/models/iommu/iommu.dart';
import 'package:iommy/repositories/repository.dart';
import 'package:iommy/services/dto/net/net_dto.dart';
import 'package:iommy/services/dto/nvme/nvme_dto.dart';
import 'package:iommy/services/dto/pci/pci_dto.dart';
import 'package:iommy/services/dto/sata/sata_dto.dart';
import 'package:iommy/services/dto/usb/usb_dto.dart';
import 'package:iommy/services/local/iommu/iommu_service.dart';
import 'package:iommy/services/local/net/net_service.dart';
import 'package:iommy/services/local/nvme/nvme_service.dart';
import 'package:iommy/services/local/pci/pci_service.dart';
import 'package:iommy/services/local/sata/sata_service.dart';
import 'package:iommy/services/local/usb/usb_service.dart';

abstract interface class IommuRepository {
  Future<List<Iommu>> scan();
}

class IommuRepositoryImpl extends Repository implements IommuRepository {
  final IommuService iommuService;
  final UsbService usbService;
  final NetService netService;
  final SataService sataService;
  final NvmeService nvmeService;
  final PciService pciService;
  final UsbMapper usbMapper;
  final NetMapper netMapper;
  final SataMapper sataMapper;
  final NvmeMapper nvmeMapper;
  final PciMapper pciMapper;

  const IommuRepositoryImpl({
    required this.iommuService,
    required this.usbService,
    required this.netService,
    required this.sataService,
    required this.nvmeService,
    required this.pciService,
    required this.usbMapper,
    required this.netMapper,
    required this.sataMapper,
    required this.nvmeMapper,
    required this.pciMapper,
    required super.logger,
  });

  @override
  Future<List<Iommu>> scan() => safeCode(() async {
        try {
          logger.info('[$IommuRepository] Scanning IOMMU groups...');
          final groupIds = await iommuService.scan();
          logger.info(
            '[$IommuRepository] Found ${groupIds.length} IOMMU groups',
          );

          if (groupIds.isEmpty) {
            logger.info('[$IommuRepository] No IOMMU groups found');
            return [];
          }

          logger.info(
            '[$IommuRepository] Scanning devices for ${groupIds.length} groups...',
          );

          final [
            usbDTOs as List<UsbDTO>,
            netDTOs as List<NetDTO>,
            sataDTOs as List<SataDTO>,
            nvmeDTOs as List<NvmeDTO>,
            pciDTOs as List<PciDTO>,
          ] = await Future.wait([
            usbService.scan(),
            netService.scan(),
            sataService.scan(),
            nvmeService.scan(),
            pciService.scan(),
          ]);

          logger.info(
            '[$IommuRepository] Scanned devices for ${groupIds.length} groups',
          );

          final pciIds = {
            ...usbDTOs.map((usb) => usb.pciId),
            ...netDTOs.map((net) => net.pciId),
            ...sataDTOs.map((sata) => sata.pciId),
            ...nvmeDTOs.map((nvme) => nvme.pciId),
          };

          final usbByGroup = usbDTOs.groupBy((usb) => usb.groupId);
          final netByGroup = netDTOs.groupBy((net) => net.groupId);
          final sataByGroup = sataDTOs.groupBy((sata) => sata.groupId);
          final nvmeByGroup = nvmeDTOs.groupBy((nvme) => nvme.groupId);
          final pciByGroup = pciDTOs
              .where((pci) => !pciIds.contains(pci.id))
              .groupBy((pci) => pci.groupId);

          return groupIds.map((groupId) {
            final usbs = usbByGroup[groupId] ?? [];
            final nets = netByGroup[groupId] ?? [];
            final satas = sataByGroup[groupId] ?? [];
            final nvmes = nvmeByGroup[groupId] ?? [];
            final pcis = pciByGroup[groupId] ?? [];

            return Iommu(
              id: groupId,
              usbDevices: usbMapper.fromManyDTO(usbs),
              netDevices: netMapper.fromManyDTO(nets),
              sataDevices: sataMapper.fromManyDTO(satas),
              nvmeDevices: nvmeMapper.fromManyDTO(nvmes),
              pciDevices: pciMapper.fromManyDTO(pcis),
            );
          }).toList(growable: false);
        } catch (error, stackTrace) {
          logger.error(
            '[$IommuRepository] Error scanning IOMMU groups',
            error,
            stackTrace,
          );

          rethrow;
        }
      });
}
