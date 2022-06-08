import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/item_receita.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';

class Receita implements IEntity {
  @override
  String? id;
  String? medicoId;
  Medico? medico;
  String? tipoReceitaId;
  TipoReceita? tipoReceita;
  String? notificacaoId;
  Notificacao? notificacao;
  List<ItemReceita>? itens;
  DateTime? dataEmissao;

  Receita({
    this.id,
    this.medicoId,
    this.medico,
    this.tipoReceitaId,
    this.tipoReceita,
    this.notificacaoId,
    this.notificacao,
    List<ItemReceita>? itens,
    this.dataEmissao,
  }) : itens = itens ?? [];
}
