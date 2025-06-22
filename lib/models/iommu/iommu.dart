import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iommy/models/net/net.dart';
import 'package:iommy/models/nvme/nvme.dart';
import 'package:iommy/models/pci/pci.dart';
import 'package:iommy/models/sata/sata.dart';
import 'package:iommy/models/usb/usb.dart';

part 'iommu.freezed.dart';

@freezed
abstract class Iommu with _$Iommu {
  const Iommu._();

  const factory Iommu({
    required String id,
    required List<Net> netDevices,
    required List<Pci> pciDevices,
    required List<Usb> usbDevices,
    required List<Nvme> nvmeDevices,
    required List<Sata> sataDevices,
  }) = _Iommu;

  int get length => netDevices.length +
      pciDevices.length +
      usbDevices.length +
      nvmeDevices.length +
      sataDevices.length;

  @override
  String toString() =>
      'Iommu(id: $id, netDevices: $netDevices, pciDevices: $pciDevices, usbDevices: $usbDevices, nvmeDevices: $nvmeDevices, sataDevices: $sataDevices)';
}
