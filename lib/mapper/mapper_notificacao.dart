import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_notificacao.dart';

class MapperNotificacao implements IMapperNotificacao {
  @override
  Map<String, dynamic> toMap(Notificacao notificacao) {
    return {
      'id': notificacao.id,
      'tipoNotificacaoId': notificacao.tipoNotificacaoId,
    };
  }

  @override
  Notificacao fromMap(Map<String, dynamic> map) {
    return Notificacao(
      id: map['id'],
      tipoNotificacaoId: map['tipoNotificacaoId'],
    );
  }
}
