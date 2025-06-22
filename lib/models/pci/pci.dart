import 'package:freezed_annotation/freezed_annotation.dart';

part 'pci.freezed.dart';

@freezed
abstract class Pci with _$Pci {
  const factory Pci({
    required String id,
    required String vendorDeviceId,
    required String description,
    required String pciClass,
    required bool resetCapable,
  }) = _Pci;

  @override
  String toString() => 'Pci(pciId: $id, vendorDeviceId: $vendorDeviceId, description: $description, pciClass: $pciClass, resetCapable: $resetCapable)';
}
