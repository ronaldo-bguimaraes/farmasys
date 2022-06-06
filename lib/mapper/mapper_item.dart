import 'package:farmasys/dto/item.dart';
import 'package:farmasys/mapper/interface/i_mapper_item.dart';

class MapperItem implements IMapperItem {
  @override
  Map<String, dynamic> toMap(Item item) {
    return {
      'id': item.id,
      'preco': item.preco.toDouble(),
      'quantidade': item.quantidade.toInt(),
      'medicamentoId': item.medicamentoId,
    };
  }

  @override
  Item fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      preco: map['preco'].toDouble(),
      quantidade: map['quantidade'].toInt(),
      medicamentoId: map['medicamentoId'],
    );
  }
}