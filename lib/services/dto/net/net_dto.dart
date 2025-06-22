import 'package:freezed_annotation/freezed_annotation.dart';

part 'net_dto.freezed.dart';

@freezed
abstract class NetDTO with _$NetDTO {
  const factory NetDTO({
    required String interface,
    required String mac,
    required String pciId,
    required String vendorDeviceId,
    required String groupId,
  }) = _NetDTO;
}