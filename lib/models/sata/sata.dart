import 'package:freezed_annotation/freezed_annotation.dart';

part 'sata.freezed.dart';

@freezed
abstract class Sata with _$Sata {
  const factory Sata({
    required String device,
    required String vendor,
    required String model,
    required String pciId,
    required String vendorDeviceId,
  }) = _Sata;

  @override
  String toString() => 'Sata(device: $device, vendor: $vendor, model: $model, pciId: $pciId, vendorDeviceId: $vendorDeviceId)';
}