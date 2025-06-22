import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iommy/blocs/identifiers/identifiers_bloc.dart';
import 'package:iommy/errors/generic_error.dart';
import 'package:iommy/errors/repository_error.dart';
import 'package:iommy/models/identifier/identifier.dart';
import 'package:iommy/repositories/pci_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/models/identifier_fixture_factory.dart';
import 'identifiers_bloc_test.mocks.dart';

@GenerateMocks([PciRepository])
void main() {
  late MockPciRepository pciRepository;
  late IdentifiersBloc bloc;

  setUp(() {
    pciRepository = MockPciRepository();
    bloc = IdentifiersBloc(
      pciRepository: pciRepository,
    );
  });

  /// Testing the event [FetchIdentifiersEvent]
  group('when the event FetchIdentifiersEvent is added to the BLoC', () {
    late List<Identifier> identifiers;

    setUp(() {
      identifiers = IdentifierFixture.factory().makeMany(3);
    });

    blocTest<IdentifiersBloc, IdentifiersState>(
      'test that IdentifiersBloc emits IdentifiersState.fetched when fetch is called',
      setUp: () {
        when(pciRepository.identifiers()).thenAnswer((_) async => identifiers);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <IdentifiersState>[
        IdentifiersState.fetching(),
        IdentifiersState.fetched(identifiers),
      ],
      verify: (_) {
        verify(pciRepository.identifiers());
      },
    );

    blocTest<IdentifiersBloc, IdentifiersState>(
      'test that IdentifiersBloc emits IdentifiersState.empty when an error occurs',
      setUp: () {
        when(pciRepository.identifiers()).thenAnswer((_) async => []);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <IdentifiersState>[
        IdentifiersState.fetching(),
        IdentifiersState.empty(),
      ],
      verify: (_) {
        verify(pciRepository.identifiers());
      },
    );

    blocTest<IdentifiersBloc, IdentifiersState>(
      'test that IdentifiersBloc emits IdentifiersState.errorFetching when an error occurs',
      setUp: () {
        when(pciRepository.identifiers())
            .thenThrow(RepositoryError(Exception()));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <IdentifiersState>[
        IdentifiersState.fetching(),
        IdentifiersState.errorFetching(RepositoryError(Exception())),
      ],
      verify: (_) {
        verify(pciRepository.identifiers());
      },
    );

    blocTest<IdentifiersBloc, IdentifiersState>(
      'test that IdentifiersBloc emits IdentifiersState.errorFetching(GenericError) when an error occurs',
      setUp: () {
        when(pciRepository.identifiers()).thenThrow(Exception());
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <IdentifiersState>[
        IdentifiersState.fetching(),
        IdentifiersState.errorFetching(GenericError()),
      ],
      verify: (_) {
        verify(pciRepository.identifiers());
      },
    );
  });
}
