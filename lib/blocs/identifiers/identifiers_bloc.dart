import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iommy/errors/generic_error.dart';
import 'package:iommy/models/identifier/identifier.dart';
import 'package:iommy/repositories/pci_repository.dart';

part 'identifiers_bloc.freezed.dart';
part 'identifiers_event.dart';
part 'identifiers_state.dart';

/// The IdentifiersBloc
class IdentifiersBloc extends Bloc<IdentifiersEvent, IdentifiersState> {
  final PciRepository pciRepository;

  /// Create a new instance of [IdentifiersBloc].
  IdentifiersBloc({
    required this.pciRepository,
  }) : super(const IdentifiersState.initial()) {
    on<FetchIdentifiersEvent>(_onFetch);
  }

  /// Method used to add the [FetchIdentifiersEvent] event
  void fetch() => add(const IdentifiersEvent.fetch());

  FutureOr<void> _onFetch(
    FetchIdentifiersEvent event,
    Emitter<IdentifiersState> emit,
  ) async {
    emit(const IdentifiersState.fetching());

    try {
      final identifiers = await pciRepository.identifiers();

      if (identifiers.isEmpty) {
        emit(const IdentifiersState.empty());
      } else {
        emit(IdentifiersState.fetched(identifiers));
      }
    } on LocalizedError catch (error) {
      emit(IdentifiersState.errorFetching(error));
    } catch (_) {
      emit(IdentifiersState.errorFetching(GenericError()));
    }
  }
}

extension IdentifiersBlocExtension on BuildContext {
  /// Extension method used to get the [IdentifiersBloc] instance
  IdentifiersBloc get identifiersBloc => read<IdentifiersBloc>();

  /// Extension method used to watch the [IdentifiersBloc] instance
  IdentifiersBloc get watchIdentifiersBloc => watch<IdentifiersBloc>();
}
