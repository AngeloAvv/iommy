import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:iommy/models/net/net.dart';

extension NetFixture on Net {
  static NetFixtureFactory factory() => NetFixtureFactory();
}

class NetFixtureFactory extends FixtureFactory<Net> {
  @override
  FixtureDefinition<Net> definition() => define(
        (faker, [int index = 0]) => Net(
            interface: faker.lorem.word(),
            mac: faker.internet.macAddress(),
            pciId: faker.guid.guid(),
            vendorDeviceId: faker.guid.guid()),
      );
}
