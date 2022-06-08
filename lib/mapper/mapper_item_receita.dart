import 'package:farmasys/dto/item_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_receita.dart';

class MapperItemReceita implements IMapperItemReceita {
  @override
  Map<String, dynamic> toMap(ItemReceita itemReceita) {
    return {
      'preco': itemReceita.preco.toDouble(),
      'quantidade': itemReceita.quantidade.toInt(),
      'medicamentoId': itemReceita.medicamentoId,
    };
  }

  @override
  ItemReceita fromMap(Map<String, dynamic> map) {
    return ItemReceita(
      preco: map['preco'].toDouble(),
      quantidade: map['quantidade'].toInt(),
      medicamentoId: map['medicamentoId'],
    );
  }
}
