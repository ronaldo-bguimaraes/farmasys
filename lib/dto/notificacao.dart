import 'package:farmasys/dto/codigo.dart';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';

class Notificacao implements IEntity {
  @override
  String? id;
  Codigo codigo;
  String? tipoNotificacaoId;
  TipoNotificacao? tipoNotificacao;

  Notificacao({
    this.id,
    codigo,
    this.tipoNotificacaoId,
    this.tipoNotificacao,
  }) : codigo = codigo ?? Codigo();
}
