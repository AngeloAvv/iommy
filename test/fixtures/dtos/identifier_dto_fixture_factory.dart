import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:iommy/services/dto/identifier/identifier_dto.dart';

extension IdentifierDTOFixture on IdentifierDTO {
  static IdentifierDTOFixtureFactory factory() => IdentifierDTOFixtureFactory();
}

class IdentifierDTOFixtureFactory extends FixtureFactory<IdentifierDTO> {
  @override
  FixtureDefinition<IdentifierDTO> definition() => define(
        (faker, [int index = 0]) => IdentifierDTO(
          vendorId: faker.guid.guid(),
          deviceId: faker.guid.guid(),
          vendorName: faker.company.name(),
          deviceName: faker.lorem.word(),
        ),
      );
}
