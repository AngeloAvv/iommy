import 'package:dart_mapper/dart_mapper.dart';
import 'package:iommy/models/pci/pci.dart';
import 'package:iommy/services/dto/pci/pci_dto.dart';

part 'pci_mapper.g.dart';

@Mapper()
abstract class PciMapper {
  const PciMapper();

  Pci fromDTO(PciDTO dto);

  List<Pci> fromManyDTO(List<PciDTO> dtos) =>
      dtos.map(fromDTO).toList(growable: false);
}
