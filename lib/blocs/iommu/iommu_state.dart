part of 'iommu_bloc.dart';

@freezed
sealed class IommuState with _$IommuState {
  const factory IommuState.initial() = InitialIommuState;

  const factory IommuState.scanning() = ScanningIommuState;

  const factory IommuState.scanned(List<Iommu> groups) = ScannedIommuState;

  const factory IommuState.empty() = EmptyIommuState;

  const factory IommuState.errorScanning(LocalizedError error) =
      ErrorScanningIommuState;
}
