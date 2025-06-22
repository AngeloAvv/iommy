import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:iommy/models/pci/pci.dart';

extension PciFixture on Pci {
  static PciFixtureFactory factory() => PciFixtureFactory();
}

class PciFixtureFactory extends FixtureFactory<Pci> {
  @override
  FixtureDefinition<Pci> definition() => define(
        (faker, [int index = 0]) => Pci(
            id: faker.guid.guid(),
            vendorDeviceId: faker.guid.guid(),
            description: faker.lorem.sentence(),
            pciClass: faker.lorem.word(),
            resetCapable: faker.randomGenerator.boolean()),
      );
}
