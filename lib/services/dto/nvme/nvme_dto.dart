import 'package:freezed_annotation/freezed_annotation.dart';

part 'nvme_dto.freezed.dart';

@freezed
abstract class NvmeDTO with _$NvmeDTO {
  const factory NvmeDTO({
    required String device,
    String? model,
    String? serial,
    required String pciId,
    required String vendorDeviceId,
    required String groupId,
  }) = _NvmeDTO;
}