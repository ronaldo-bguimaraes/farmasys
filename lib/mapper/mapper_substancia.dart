import 'package:farmasys/dto/substancia.dart';
import 'package:farmasys/mapper/interface/i_mapper_substancia.dart';

class MapperSubstancia implements IMapperSubstancia {
  @override
  Map<String, dynamic> toMap(Substancia substancia) {
    return {
      'id': substancia.id,
      'nome': substancia.nome.trim(),
      'listaControleId': substancia.listaControleId,
    };
  }

  @override
  Substancia fromMap(Map<String, dynamic> map) {
    return Substancia(
      id: map['id'],
      nome: map['nome'],
      listaControleId: map['listaControleId'],
    );
  }
}
