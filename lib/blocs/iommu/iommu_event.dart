part of 'iommu_bloc.dart';

@freezed
sealed class IommuEvent with _$IommuEvent {
  
  const factory IommuEvent.scan() = ScanIommuEvent;
  
}
