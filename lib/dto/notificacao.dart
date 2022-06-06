import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';

class Notificacao implements IEntity {
  @override
  String? id;
  double subtotal;
  String? tipoNotificacaoId;
  TipoNotificacao? tipoNotificacao;
  String? medicamentoId;
  Medicamento? medicamento;

  Notificacao({
    this.id,
    required this.subtotal,
    this.tipoNotificacaoId,
    this.tipoNotificacao,
    this.medicamentoId,
    this.medicamento,
  });
}
