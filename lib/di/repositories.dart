part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<ConfigurationRepository>(
    create: (context) => ConfigurationRepositoryImpl(
      configurationService: context.read(),
      logger: context.read(),
    ),
  ),
  RepositoryProvider<IommuRepository>(
    create: (context) => IommuRepositoryImpl(
      iommuService: context.read(),
      usbService: context.read(),
      netService: context.read(),
      sataService: context.read(),
      nvmeService: context.read(),
      pciService: context.read(),
      usbMapper: const UsbMapperImpl(),
      netMapper: const NetMapperImpl(),
      sataMapper: const SataMapperImpl(),
      nvmeMapper: const NvmeMapperImpl(),
      pciMapper: const PciMapperImpl(),
      logger: context.read(),
    ),
  ),
  RepositoryProvider<PciRepository>(
    create: (context) => PciRepositoryImpl(
      pciService: context.read(),
      identifierMapper: const IdentifierMapperImpl(),
      logger: context.read(),
    ),
  ),
];
