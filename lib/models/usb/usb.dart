import 'package:freezed_annotation/freezed_annotation.dart';

part 'usb.freezed.dart';

@freezed
abstract class Usb with _$Usb {
  const factory Usb({
    required String name,
    required String pciId,
    required String vendorDeviceId,
  }) = _Usb;

  @override
  String toString() => 'Usb(name: $name, pciId: $pciId, vendorDeviceId: $vendorDeviceId)';
}
