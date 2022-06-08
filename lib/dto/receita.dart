import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/item_receita.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';

class Receita implements IEntity {
  @override
  String? id;
  String? medicoId;
  Medico medico;
  String? tipoReceitaId;
  TipoReceita tipoReceita;
  String? notificacaoId;
  Notificacao? notificacao;
  DateTime? dataEmissao;
  DateTime? dataDispensacao;
  ItemReceita item;
  int frequencia;

  Receita({
    this.id,
    this.medicoId,
    Medico? medico,
    this.tipoReceitaId,
    TipoReceita? tipoReceita,
    this.notificacaoId,
    this.notificacao,
    ItemReceita? item,
    this.dataEmissao,
    this.frequencia = 0,
  })  : medico = medico ?? Medico(),
        tipoReceita = tipoReceita ?? TipoReceita(),
        item = item ?? ItemReceita();
}
