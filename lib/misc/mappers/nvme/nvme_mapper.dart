import 'package:dart_mapper/dart_mapper.dart';
import 'package:iommy/models/nvme/nvme.dart';
import 'package:iommy/services/dto/nvme/nvme_dto.dart';

part 'nvme_mapper.g.dart';

@Mapper()
abstract class NvmeMapper {
  const NvmeMapper();

  Nvme fromDTO(NvmeDTO dto);

  List<Nvme> fromManyDTO(List<NvmeDTO> dtos) =>
      dtos.map(fromDTO).toList(growable: false);
}
