part of 'identifiers_bloc.dart';

@freezed
sealed class IdentifiersState with _$IdentifiersState {
  const factory IdentifiersState.initial() = InitialIdentifiersState;

  const factory IdentifiersState.fetching() = FetchingIdentifiersState;

  const factory IdentifiersState.fetched(List<Identifier> identifiers) =
      FetchedIdentifiersState;

  const factory IdentifiersState.empty() = EmptyIdentifiersState;

  const factory IdentifiersState.errorFetching(LocalizedError error) =
      ErrorFetchingIdentifiersState;
}
