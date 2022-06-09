import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/dto/farmaceutico.dart';
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
  String? clienteId;
  Cliente cliente;
  String? farmaceuticoId;
  Farmaceutico farmaceutico;
  String? tipoReceitaId;
  TipoReceita tipoReceita;
  Notificacao? notificacao;
  DateTime? dataEmissao;
  DateTime? dataDispensacao;
  ItemReceita item;
  int frequencia;

  Receita({
    this.id,
    this.medicoId,
    Medico? medico,
    this.clienteId,
    Cliente? cliente,
    this.farmaceuticoId,
    Farmaceutico? farmaceutico,
    this.tipoReceitaId,
    TipoReceita? tipoReceita,
    this.notificacao,
    ItemReceita? item,
    this.dataEmissao,
    this.dataDispensacao,
    this.frequencia = 0,
  })  : medico = medico ?? Medico(),
        cliente = cliente ?? Cliente(),
        farmaceutico = farmaceutico ?? Farmaceutico(),
        tipoReceita = tipoReceita ?? TipoReceita(),
        item = item ?? ItemReceita();
}
