import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/substancia.dart';

class Medicamento implements IEntity {
  @override
  String? id;
  String nome;
  double miligramas;
  double preco;
  int quantidade;
  String? principioAtivoId;
  Substancia? principioAtivo;

  Medicamento({
    String? id,
    required this.nome,
    required this.miligramas,
    required this.preco,
    required this.quantidade,
    this.principioAtivoId,
    this.principioAtivo,
  });
}
