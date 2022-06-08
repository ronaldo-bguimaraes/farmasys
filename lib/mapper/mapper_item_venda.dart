import 'package:farmasys/dto/item_venda.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_venda.dart';

class MapperItemVenda implements IMapperItemVenda {
  @override
  Map<String, dynamic> toMap(ItemVenda itemVenda) {
    return {
      'id': itemVenda.id,
      'preco': itemVenda.preco.toDouble(),
      'quantidade': itemVenda.quantidade.toInt(),
      'medicamentoId': itemVenda.medicamentoId,
    };
  }

  @override
  ItemVenda fromMap(Map<String, dynamic> map) {
    return ItemVenda(
      id: map['id'],
      preco: map['preco'].toDouble(),
      quantidade: map['quantidade'].toInt(),
      medicamentoId: map['medicamentoId'],
    );
  }
}
