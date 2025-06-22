import 'package:freezed_annotation/freezed_annotation.dart';

part 'sata_dto.freezed.dart';

@freezed
abstract class SataDTO with _$SataDTO {
  const factory SataDTO({
    required String device,
    required String vendor,
    required String model,
    required String pciId,
    required String vendorDeviceId,
    required String groupId,
  }) = _SataDTO;
}