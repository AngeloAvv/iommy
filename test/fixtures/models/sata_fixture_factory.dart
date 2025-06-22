import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:iommy/models/sata/sata.dart';

extension SataFixture on Sata {
  static SataFixtureFactory factory() => SataFixtureFactory();
}

class SataFixtureFactory extends FixtureFactory<Sata> {
  @override
  FixtureDefinition<Sata> definition() => define(
        (faker, [int index = 0]) => Sata(
            device: faker.lorem.word(),
            vendor: faker.company.name(),
            model: faker.vehicle.model(),
            pciId: faker.guid.guid(),
            vendorDeviceId: faker.guid.guid()),
      );
}
