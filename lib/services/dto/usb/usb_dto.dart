import 'package:freezed_annotation/freezed_annotation.dart';

part 'usb_dto.freezed.dart';

@freezed
abstract class UsbDTO with _$UsbDTO {
  const factory UsbDTO({
    required String name,
    required String pciId,
    required String vendorDeviceId,
    required String groupId,
  }) = _UsbDTO;
}
