import 'package:farmasys/dto/venda.dart';
import 'package:farmasys/mapper/interface/i_mapper_venda.dart';

class MapperVenda implements IMapperVenda {
  @override
  Map<String, dynamic> toMap(Venda venda) {
    return {
      'id': venda.id,
    };
  }

  @override
  Venda fromMap(Map<String, dynamic> map) {
    return Venda(
      id: map['id'],
    );
  }
}
