import 'package:freezed_annotation/freezed_annotation.dart';

part 'pci_dto.freezed.dart';

@freezed
abstract class PciDTO with _$PciDTO {
  const factory PciDTO({
    required String id,
    required String vendorDeviceId,
    required String description,
    required String pciClass,
    required bool resetCapable,
    required String groupId,
  }) = _PciDTO;
}
