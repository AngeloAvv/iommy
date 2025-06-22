import 'package:dart_mapper/dart_mapper.dart';
import 'package:iommy/models/identifier/identifier.dart';
import 'package:iommy/services/dto/identifier/identifier_dto.dart';

part 'identifier_mapper.g.dart';

@Mapper()
abstract class IdentifierMapper {
  const IdentifierMapper();

  Identifier fromDTO(IdentifierDTO dto);

  List<Identifier> fromManyDTO(List<IdentifierDTO> dtos) =>
      dtos.map(fromDTO).toList(growable: false);
}
