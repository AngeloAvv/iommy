import 'package:freezed_annotation/freezed_annotation.dart';

part 'nvme.freezed.dart';

@freezed
abstract class Nvme with _$Nvme {
  const factory Nvme({
    required String device,
    String? model,
    String? serial,
    required String pciId,
    required String vendorDeviceId,
  }) = _Nvme;

  @override
  String toString() =>
      'Nvme(device: $device, model: $model, pcidId: $pciId, serial: $serial, vendorDeviceId: $vendorDeviceId)';
}
