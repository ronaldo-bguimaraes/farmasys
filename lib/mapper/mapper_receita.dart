import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_receita.dart';

class MapperReceita implements IMapperReceita {
  @override
  Map<String, dynamic> toMap(Receita receita) {
    return {
      'id': receita.id,
      'tipoReceitaId': receita.tipoReceitaId,
      'dataEmissao': receita.dataEmissao?.toIso8601String(),
    };
  }

  @override
  Receita fromMap(Map<String, dynamic> map) {
    return Receita(
      id: map['id'],
      tipoReceitaId: map['tipoReceitaId'],
      dataEmissao: DateTime.parse(map['dataEmissao']),
    );
  }
}
