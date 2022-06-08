import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';

class ListaControle implements IEntity {
  @override
  String? id;
  String nome;
  int duracaoTratamento;
  int prazo;
  String? tipoReceitaId;
  TipoReceita tipoReceita;
  String? tipoNotificacaoId;
  TipoNotificacao? tipoNotificacao;

  ListaControle({
    this.id,
    this.nome = '',
    this.duracaoTratamento = 0,
    this.prazo = 0,
    this.tipoReceitaId,
    TipoReceita? tipoReceita,
    this.tipoNotificacaoId,
    this.tipoNotificacao,
  }) : tipoReceita = tipoReceita ?? TipoReceita();
}
