part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<Talker>.value(value: Talker()),
  Provider<ConfigurationService>(
    create: (context) => ConfigurationServiceImpl(
      sharedPreferences: SharedPreferences.getInstance(),
      logger: context.read(),
    ),
  ),
  Provider<IommuService>(
    create: (context) => IommuServiceImpl(
      logger: context.read(),
    ),
  ),
  Provider<NetService>(
    create: (context) => NetServiceImpl(
      logger: context.read(),
    ),
  ),
  Provider<NvmeService>(
    create: (context) => NvmeServiceImpl(
      logger: context.read(),
    ),
  ),
  Provider<PciService>(
    create: (context) => PciServiceImpl(
      logger: context.read(),
    ),
  ),
  Provider<SataService>(
    create: (context) => SataServiceImpl(
      logger: context.read(),
    ),
  ),
  Provider<UsbService>(
    create: (context) => UsbServiceImpl(
      logger: context.read(),
    ),
  ),
];
