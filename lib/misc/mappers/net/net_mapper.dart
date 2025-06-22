import 'package:dart_mapper/dart_mapper.dart';
import 'package:iommy/models/net/net.dart';
import 'package:iommy/services/dto/net/net_dto.dart';

part 'net_mapper.g.dart';

@Mapper()
abstract class NetMapper {
  const NetMapper();

  Net fromDTO(NetDTO dto);

  List<Net> fromManyDTO(List<NetDTO> dtos) =>
      dtos.map(fromDTO).toList(growable: false);
}
