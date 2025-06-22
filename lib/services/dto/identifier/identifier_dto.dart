import 'package:freezed_annotation/freezed_annotation.dart';

part 'identifier_dto.freezed.dart';

@freezed
abstract class IdentifierDTO with _$IdentifierDTO {
  const IdentifierDTO._();

  const factory IdentifierDTO({
    required String vendorId,
    required String deviceId,
    required String vendorName,
    required String deviceName,
  }) = _IdentifierDTO;

  String get vendorDeviceId => '$vendorId:$deviceId';
}
