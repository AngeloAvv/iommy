import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iommy/blocs/iommu/iommu_bloc.dart';
import 'package:iommy/errors/generic_error.dart';
import 'package:iommy/errors/repository_error.dart';
import 'package:iommy/models/iommu/iommu.dart';
import 'package:iommy/repositories/iommu_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/models/iommu_fixture_factory.dart';
import 'iommu_bloc_test.mocks.dart';

@GenerateMocks([IommuRepository])
void main() {
  late IommuRepository iommuRepository;
  late IommuBloc bloc;

  setUp(() {
    iommuRepository = MockIommuRepository();
    bloc = IommuBloc(
      iommuRepository: iommuRepository,
    );
  });

  /// Testing the event [FetchIommuEvent]
  group('when the event FetchIommuEvent is added to the BLoC', () {
    late List<Iommu> groups;

    setUp(() {
      groups = IommuFixture.factory().makeMany(3);
    });

    blocTest<IommuBloc, IommuState>(
      'test that IommuBloc emits IommuState.scanned when scan is called',
      setUp: () {
        when(iommuRepository.scan()).thenAnswer((_) async => groups);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.scan();
      },
      expect: () => <IommuState>[
        IommuState.scanning(),
        IommuState.scanned(groups),
      ],
      verify: (_) {
        verify(iommuRepository.scan());
      },
    );

    blocTest<IommuBloc, IommuState>(
      'test that IommuBloc emits IommuState.empty when an error occurs',
      setUp: () {
        when(iommuRepository.scan()).thenAnswer((_) async => []);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.scan();
      },
      expect: () => <IommuState>[
        IommuState.scanning(),
        IommuState.empty(),
      ],
      verify: (_) {
        verify(iommuRepository.scan());
      },
    );

    blocTest<IommuBloc, IommuState>(
      'test that IommuBloc emits IommuState.errorScanning when an error occurs',
      setUp: () {
        when(iommuRepository.scan()).thenThrow(RepositoryError(Exception()));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.scan();
      },
      expect: () => <IommuState>[
        IommuState.scanning(),
        IommuState.errorScanning(RepositoryError(Exception())),
      ],
      verify: (_) {
        verify(iommuRepository.scan());
      },
    );

    blocTest<IommuBloc, IommuState>(
      'test that IommuBloc emits IommuState.errorScanning(GenericError) when an error occurs',
      setUp: () {
        when(iommuRepository.scan()).thenThrow(Exception());
      },
      build: () => bloc,
      act: (bloc) {
        bloc.scan();
      },
      expect: () => <IommuState>[
        IommuState.scanning(),
        IommuState.errorScanning(GenericError()),
      ],
      verify: (_) {
        verify(iommuRepository.scan());
      },
    );
  });
}
