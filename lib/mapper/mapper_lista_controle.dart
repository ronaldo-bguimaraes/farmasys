import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/mapper/interface/i_mapper_lista_controle.dart';

class MapperListaControle implements IMapperListaControle {
  @override
  Map<String, dynamic> toMap(ListaControle listaControle) {
    return {
      'id': listaControle.id,
      'descricao': listaControle.descricao.trim(),
      'dispensacaoMaxima': listaControle.dispensacaoMaxima.toInt(),
    };
  }

  @override
  ListaControle fromMap(Map<String, dynamic> map) {
    return ListaControle(
      id: map['id'],
      descricao: map['descricao'],
      dispensacaoMaxima: map['dispensacaoMaxima'].toInt(),
    );
  }
}
