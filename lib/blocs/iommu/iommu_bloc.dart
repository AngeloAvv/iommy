import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iommy/errors/generic_error.dart';
import 'package:iommy/models/iommu/iommu.dart';
import 'package:iommy/repositories/iommu_repository.dart';

part 'iommu_event.dart';

part 'iommu_state.dart';

part 'iommu_bloc.freezed.dart';

/// The IommuBloc
class IommuBloc extends Bloc<IommuEvent, IommuState> {
  final IommuRepository iommuRepository;

  /// Create a new instance of [IommuBloc].
  IommuBloc({
    required this.iommuRepository,
}) : super(const IommuState.initial()) {
    on<ScanIommuEvent>(_onScan);
    
  }
  
  /// Method used to add the [ScanIommuEvent] event
  void scan() => add(const IommuEvent.scan());
  
  
  FutureOr<void> _onScan(
    ScanIommuEvent event,
    Emitter<IommuState> emit,
  ) async {
    emit(const IommuState.scanning());

    try {
      final groups = await iommuRepository.scan();
      if (groups.isEmpty) {
        emit(const IommuState.empty());
      } else {
        emit(IommuState.scanned(groups));
      }
    } on LocalizedError catch(error) {
      emit(IommuState.errorScanning(error));
    } catch (error) {
      emit(IommuState.errorScanning(GenericError()));
    }
  }
  
}

extension IommuBlocExtension on BuildContext {
  /// Extension method used to get the [IommuBloc] instance
  IommuBloc get iommuBloc => read<IommuBloc>();

  /// Extension method used to watch the [IommuBloc] instance
  IommuBloc get watchIommuBloc => watch<IommuBloc>();
}