import 'package:iommy/misc/mappers/identifier/identifier_mapper.dart';
import 'package:iommy/models/identifier/identifier.dart';
import 'package:iommy/repositories/repository.dart';
import 'package:iommy/services/local/pci/pci_service.dart';

abstract interface class PciRepository {
  Future<List<Identifier>> identifiers();
}

class PciRepositoryImpl extends Repository implements PciRepository {
  final PciService pciService;
  final IdentifierMapper identifierMapper;

  const PciRepositoryImpl({
    required this.pciService,
    required this.identifierMapper,
    required super.logger,
  });

  @override
  Future<List<Identifier>> identifiers() => safeCode(() async {
        try {
          logger.info('[$PciRepository] Getting pci identifiers...');
          final dtos = await pciService.identifiers();
          logger.info(
            '[$PciRepository] Found ${dtos.length} PCI identifiers',
          );

          final identifiers = identifierMapper.fromManyDTO(dtos);

          logger.info(
            '[$PciRepository] Mapped ${identifiers.length} identifiers',
          );

          return identifiers;
        } catch (error, stackTrace) {
          logger.error(
            '[$PciRepository] Failed to get PCI identifiers',
            error,
            stackTrace,
          );

          rethrow;
        }
      });
}
