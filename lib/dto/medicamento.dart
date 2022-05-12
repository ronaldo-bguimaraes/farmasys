import 'package:farmasys/dto/inteface/entity_base.dart';

class Medicamento extends EntityBase {
  String nome;
  String principioAtivo;
  double miligramas;
  double preco;
  int quantidade;
  bool controlado;

  Medicamento({
    required this.nome,
    required this.principioAtivo,
    required this.miligramas,
    required this.preco,
    required this.quantidade,
    required this.controlado,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'principioAtivo': principioAtivo,
      'miligramas': miligramas.toDouble(),
      'preco': preco.toDouble(),
      'quantidade': quantidade.toInt(),
      'controlado': controlado,
    };
  }

  Medicamento.fromMap(Map<String, dynamic> map)
      : nome = map['nome'],
        principioAtivo = map['principioAtivo'],
        miligramas = map['miligramas'].toDouble(),
        preco = map['preco'].toDouble(),
        quantidade = map['quantidade'].toInt(),
        controlado = map['controlado'];
}
