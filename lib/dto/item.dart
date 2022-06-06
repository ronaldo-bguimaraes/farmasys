import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/medicamento.dart';

class Item implements IEntity {
  @override
  String? id;
  double preco;
  int quantidade;
  String? medicamentoId;
  Medicamento? medicamento;

  Item({
    this.id,
    required this.preco,
    required this.quantidade,
    this.medicamentoId,
    this.medicamento,
  });
}
