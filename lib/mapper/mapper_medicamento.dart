import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/mapper/interface/i_mapper_medicamento.dart';

class MapperMedicamento implements IMapperMedicamento {
  @override
  Map<String, dynamic> toMap(Medicamento medicamento) {
    return {
      'id': medicamento.id,
      'nome': medicamento.nome.trim(),
      'principioAtivoId': medicamento.principioAtivoId,
      'miligramas': medicamento.miligramas.toDouble(),
      'preco': medicamento.preco.toDouble(),
      'quantidade': medicamento.quantidade.toInt(),
      'comprimidos': medicamento.comprimidos.toInt(),
    };
  }

  @override
  Medicamento fromMap(Map<String, dynamic> map) {
    return Medicamento(
      id: map['id'],
      nome: map['nome'],
      principioAtivoId: map['principioAtivoId'],
      miligramas: map['miligramas'].toDouble(),
      preco: map['preco'].toDouble(),
      quantidade: map['quantidade'].toInt(),
      comprimidos: map['comprimidos'].toInt(),
    );
  }
}
