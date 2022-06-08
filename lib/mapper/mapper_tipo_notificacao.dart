import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/enum/cor.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_notificacao.dart';

class MapperTipoNotificacao implements IMapperTipoNotificacao {
  @override
  Map<String, dynamic> toMap(TipoNotificacao tipoNotificacao) {
    return {
      'id': tipoNotificacao.id,
      'nome': tipoNotificacao.nome,
      'cor': tipoNotificacao.cor.name,
    };
  }

  @override
  TipoNotificacao fromMap(Map<String, dynamic> map) {
    return TipoNotificacao(
      id: map['id'],
      nome: map['nome'],
      cor: Cor.getByName(map['cor']),
    );
  }
}
