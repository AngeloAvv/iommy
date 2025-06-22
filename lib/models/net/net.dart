import 'package:freezed_annotation/freezed_annotation.dart';

part 'net.freezed.dart';

@freezed
abstract class Net with _$Net {
  const factory Net({
    required String interface,
    required String mac,
    required String pciId,
    required String vendorDeviceId,
  }) = _Net;

  @override
  String toString() => 'Net(interface: $interface, mac: $mac, pciId: $pciId, vendorDeviceId: $vendorDeviceId)';
}