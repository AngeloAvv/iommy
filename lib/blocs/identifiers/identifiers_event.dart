part of 'identifiers_bloc.dart';

@freezed
sealed class IdentifiersEvent with _$IdentifiersEvent {
  
  const factory IdentifiersEvent.fetch() = FetchIdentifiersEvent;
  
}
