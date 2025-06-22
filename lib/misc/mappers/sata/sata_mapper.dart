import 'package:dart_mapper/dart_mapper.dart';
import 'package:iommy/models/sata/sata.dart';
import 'package:iommy/services/dto/sata/sata_dto.dart';

part 'sata_mapper.g.dart';

@Mapper()
abstract class SataMapper {
  const SataMapper();

  Sata fromDTO(SataDTO dto);

  List<Sata> fromManyDTO(List<SataDTO> dtos) =>
      dtos.map(fromDTO).toList(growable: false);
}
