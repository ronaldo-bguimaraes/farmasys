import 'package:farmasys/dto/inteface/i_entity.dart';

class TipoReceita implements IEntity {
  @override
  String? id;
  String descricao;
  int validade;

  TipoReceita({
    this.id,
    required this.descricao,
    required this.validade,
  });
}
