import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:iommy/models/identifier/identifier.dart';

extension IdentifierFixture on Identifier {
  static IdentifierFixtureFactory factory() => IdentifierFixtureFactory();
}

class IdentifierFixtureFactory extends FixtureFactory<Identifier> {
  @override
  FixtureDefinition<Identifier> definition() => define(
        (faker, [int index = 0]) => Identifier(
          vendorId: faker.guid.guid(),
          deviceId: faker.guid.guid(),
          vendorName: faker.company.name(),
          deviceName: faker.lorem.word(),
        ),
      );
}
