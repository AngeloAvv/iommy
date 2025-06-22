import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:iommy/models/iommu/iommu.dart';

import 'net_fixture_factory.dart';
import 'nvme_fixture_factory.dart';
import 'pci_fixture_factory.dart';
import 'sata_fixture_factory.dart';
import 'usb_fixture_factory.dart';

extension IommuFixture on Iommu {
  static IommuFixtureFactory factory() => IommuFixtureFactory();
}

class IommuFixtureFactory extends FixtureFactory<Iommu> {
  @override
  FixtureDefinition<Iommu> definition() => define(
        (faker, [int index = 0]) => Iommu(
          id: faker.guid.guid(),
          netDevices: NetFixture.factory().makeMany(3),
          pciDevices: PciFixture.factory().makeMany(3),
          usbDevices: UsbFixture.factory().makeMany(3),
          nvmeDevices: NvmeFixture.factory().makeMany(3),
          sataDevices: SataFixture.factory().makeMany(3),
        ),
      );
}
