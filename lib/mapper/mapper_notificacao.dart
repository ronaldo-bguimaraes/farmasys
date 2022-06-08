import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_codigo.dart';
import 'package:farmasys/mapper/interface/i_mapper_notificacao.dart';

class MapperNotificacao implements IMapperNotificacao {
  final IMapperCodigo _mapperCodigo;
  
  MapperNotificacao(this._mapperCodigo);
  @override
  Map<String, dynamic> toMap(Notificacao notificacao) {
    return {
      'codigo': _mapperCodigo.toMap(notificacao.codigo),
      'tipoNotificacaoId': notificacao.tipoNotificacaoId,
    };
  }

  @override
  Notificacao fromMap(Map<String, dynamic> map) {
    return Notificacao(
      codigo: _mapperCodigo.fromMap(map['codigo']),
      tipoNotificacaoId: map['tipoNotificacaoId'],
    );
  }
}
