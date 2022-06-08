import 'package:farmasys/dto/inteface/i_dto.dart';
import 'package:farmasys/dto/medicamento.dart';

class ItemReceita implements IDto {
  double preco;
  int quantidade;
  String? medicamentoId;
  Medicamento medicamento;

  ItemReceita({
    this.preco = 0,
    this.quantidade = 0,
    this.medicamentoId,
    Medicamento? medicamento,
  }) : medicamento = medicamento ?? Medicamento();
}
