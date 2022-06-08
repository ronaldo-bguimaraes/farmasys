import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/medicamento.dart';

class ItemReceita implements IEntity {
  @override
  String? id;
  double preco;
  int quantidade;
  String? medicamentoId;
  Medicamento? medicamento;

  ItemReceita({
    this.id,
    this.preco = 0,
    this.quantidade = 0,
    this.medicamentoId,
    this.medicamento,
  });
}
