import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:iommy/models/nvme/nvme.dart';

extension NvmeFixture on Nvme {
  static NvmeFixtureFactory factory() => NvmeFixtureFactory();
}

class NvmeFixtureFactory extends FixtureFactory<Nvme> {
  @override
  FixtureDefinition<Nvme> definition() => define(
        (faker, [int index = 0]) => Nvme(
            device: faker.lorem.word(),
            model: faker.vehicle.model(),
            serial: faker.guid.guid(),
            pciId: faker.guid.guid(),
            vendorDeviceId: faker.guid.guid()),
      );
}
