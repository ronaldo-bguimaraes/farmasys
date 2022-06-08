import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_receita.dart';

class MapperTipoReceita implements IMapperTipoReceita {
  @override
  Map<String, dynamic> toMap(TipoReceita tipoReceita) {
    return {
      'id': tipoReceita.id,
      'nome': tipoReceita.nome,
    };
  }

  @override
  TipoReceita fromMap(Map<String, dynamic> map) {
    return TipoReceita(
      id: map['id'],
      nome: map['nome'],
    );
  }
}

