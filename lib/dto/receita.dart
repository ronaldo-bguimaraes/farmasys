import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/item.dart';
import 'package:farmasys/dto/tipo_receita.dart';

class Receita implements IEntity {
  @override
  String? id;
  String? tipoReceitaId;
  TipoReceita? tipoReceita;
  String? itemId;
  Item? item;

  Receita({
    this.id,
    this.tipoReceitaId,
    this.tipoReceita,
    this.itemId,
    this.item,
  });
}
