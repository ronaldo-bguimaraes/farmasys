import 'package:farmasys/dto/inteface/i_entity.dart';

class TipoReceita implements IEntity {
  @override
  String? id;
  String nome;

  TipoReceita({
    this.id,
    this.nome = '',
  });
}
