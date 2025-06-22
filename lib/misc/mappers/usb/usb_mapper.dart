import 'package:dart_mapper/dart_mapper.dart';
import 'package:iommy/models/usb/usb.dart';
import 'package:iommy/services/dto/usb/usb_dto.dart';

part 'usb_mapper.g.dart';

@Mapper()
abstract class UsbMapper {
  const UsbMapper();

  Usb fromDTO(UsbDTO dto);

  List<Usb> fromManyDTO(List<UsbDTO> dtos) =>
      dtos.map(fromDTO).toList(growable: false);
}
