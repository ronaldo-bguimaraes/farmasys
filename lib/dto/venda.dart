import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/receita.dart';

class Venda implements IEntity {
  @override
  String? id;
  double valorTotal;
  String? receitaId;
  Receita? receita;

  Venda({
    this.id,
    this.valorTotal = 0,
    this.receitaId,
    this.receita,
  });
}
