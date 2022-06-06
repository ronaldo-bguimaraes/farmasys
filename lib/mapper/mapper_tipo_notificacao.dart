import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_notificacao.dart';

class MapperTipoNotificacao implements IMapperTipoNotificacao {
  @override
  Map<String, dynamic> toMap(TipoNotificacao tipoNotificacao) {
    return {
      'id': tipoNotificacao.id,
      'descricao': tipoNotificacao.descricao,
      'validade': tipoNotificacao.validade.toInt(),
    };
  }

  @override
  TipoNotificacao fromMap(Map<String, dynamic> map) {
    return TipoNotificacao(
      id: map['id'],
      descricao: map['descricao'],
      validade: map['validade'].toInt(),
    );
  }
}
