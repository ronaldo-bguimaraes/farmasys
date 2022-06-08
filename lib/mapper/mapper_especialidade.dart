import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/mapper/interface/i_mapper_especialidade.dart';

class MapperEspecialidade implements IMapperEspecialidade {
  @override
  Map<String, dynamic> toMap(Especialidade especialidade) {
    return {
      'id': especialidade.id,
      'nome': especialidade.nome.trim(),
    };
  }

  @override
  Especialidade fromMap(Map<String, dynamic> map) {
    return Especialidade(
      id: map['id'],
      nome: map['nome'],
    );
  }
}