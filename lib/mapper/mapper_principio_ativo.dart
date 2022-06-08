import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/mapper/interface/i_mapper_principio_ativo.dart';

class MapperPrincipioAtivo implements IMapperPrincipioAtivo {
  @override
  Map<String, dynamic> toMap(PrincipioAtivo principioAtivo) {
    return {
      'id': principioAtivo.id,
      'nome': principioAtivo.nome.trim(),
      'listaControleId': principioAtivo.listaControleId,
    };
  }

  @override
  PrincipioAtivo fromMap(Map<String, dynamic> map) {
    return PrincipioAtivo(
      id: map['id'],
      nome: map['nome'],
      listaControleId: map['listaControleId'],
    );
  }
}
