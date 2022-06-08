import 'package:farmasys/dto/codigo.dart';
import 'package:farmasys/dto/inteface/i_dto.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';

class Notificacao implements IDto {
  Codigo codigo;
  String? tipoNotificacaoId;
  TipoNotificacao tipoNotificacao;

  Notificacao({
    codigo,
    this.tipoNotificacaoId,
    TipoNotificacao? tipoNotificacao,
  })  : codigo = codigo ?? Codigo(),
        tipoNotificacao = tipoNotificacao ?? TipoNotificacao();
}
