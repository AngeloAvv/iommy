import 'package:freezed_annotation/freezed_annotation.dart';

part 'identifier.freezed.dart';

@freezed
abstract class Identifier with _$Identifier {
  const Identifier._();

  const factory Identifier({
    required String vendorId,
    required String deviceId,
    required String vendorName,
    required String deviceName,
  }) = _Identifier;

  String get vendorDeviceId => '$vendorId:$deviceId';
}
