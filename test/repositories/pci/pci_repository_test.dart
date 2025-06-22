import 'package:flutter_test/flutter_test.dart';
import 'package:iommy/errors/repository_error.dart';
import 'package:iommy/misc/mappers/identifier/identifier_mapper.dart';
import 'package:iommy/models/identifier/identifier.dart';
import 'package:iommy/repositories/pci_repository.dart';
import 'package:iommy/services/dto/identifier/identifier_dto.dart';
import 'package:iommy/services/local/pci/pci_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talker/talker.dart';

import '../../fixtures/dtos/identifier_dto_fixture_factory.dart';
import '../../fixtures/models/identifier_fixture_factory.dart';
import 'pci_repository_test.mocks.dart';

/// Test case for the class PciRepositoryImpl
@GenerateMocks([
  PciService,
  IdentifierMapper,
], customMocks: [
  MockSpec<Talker>(unsupportedMembers: {#configure}),
])
void main() {
  late PciRepository repository;
  late MockPciService pciService;
  late MockIdentifierMapper identifierMapper;
  late MockTalker logger;

  setUp(() {
    pciService = MockPciService();
    identifierMapper = MockIdentifierMapper();
    logger = MockTalker();

    repository = PciRepositoryImpl(
      pciService: pciService,
      identifierMapper: identifierMapper,
      logger: logger,
    );
  });

  group('identifiers()', () {
    late List<IdentifierDTO> dtos;
    late List<Identifier> identifiers;

    setUp(() {
      identifiers = IdentifierFixture.factory().makeMany(3);
      dtos = IdentifierDTOFixture.factory().makeMany(3);
    });

    test('test fetch identifiers successfully', () async {
      when(pciService.identifiers()).thenAnswer((_) async => dtos);
      when(identifierMapper.fromManyDTO(dtos)).thenReturn(identifiers);

      final actual = await repository.identifiers();
      expect(actual, identifiers);

      verify(pciService.identifiers());
      verify(identifierMapper.fromManyDTO(dtos));
    });

    test('test fetch pcis with service error', () async {
      when(pciService.identifiers()).thenThrow(Error());

      try {
        await repository.identifiers();
      } catch (e) {
        expect(e, isA<RepositoryError>());
      }

      verify(pciService.identifiers());
      verifyNever(identifierMapper.fromManyDTO(any));
    });

    test('test fetch pcis with mapper error', () async {
      when(pciService.identifiers()).thenAnswer((_) async => dtos);
      when(identifierMapper.fromManyDTO(dtos)).thenThrow((Error()));

      try {
        await repository.identifiers();
      } catch (e) {
        expect(e, isA<RepositoryError>());
      }

      verify(pciService.identifiers());
      verify(identifierMapper.fromManyDTO(dtos));
    });
  });
}
