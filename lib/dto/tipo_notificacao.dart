import 'package:farmasys/dto/inteface/i_entity.dart';

class TipoNotificacao implements IEntity {
  @override
  String? id;
  String descricao;
  int validade;

  TipoNotificacao({
    this.id,
    required this.descricao,
    required this.validade,
  });
}
