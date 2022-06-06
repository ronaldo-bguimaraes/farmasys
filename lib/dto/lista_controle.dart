import 'package:farmasys/dto/inteface/i_entity.dart';

class ListaControle implements IEntity {
  @override
  String? id;
  String descricao;
  int dispensacaoMaxima;

  ListaControle({
    this.id,
    required this.descricao,
    required this.dispensacaoMaxima,
  });
}
