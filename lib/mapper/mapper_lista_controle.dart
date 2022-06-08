import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/mapper/interface/i_mapper_lista_controle.dart';

class MapperListaControle implements IMapperListaControle {
  @override
  Map<String, dynamic> toMap(ListaControle listaControle) {
    return {
      'id': listaControle.id,
      'nome': listaControle.nome.trim(),
      'prazo': listaControle.prazo.toInt(),
      'duracaoTratamento': listaControle.duracaoTratamento.toInt(),
      'tipoReceitaId': listaControle.tipoReceitaId,
      'tipoNotificacaoId': listaControle.tipoNotificacaoId,
    };
  }

  @override
  ListaControle fromMap(Map<String, dynamic> map) {
    return ListaControle(
      id: map['id'],
      nome: map['nome'],
      prazo: map['prazo'].toInt(),
      duracaoTratamento: map['duracaoTratamento'].toInt(),
      tipoReceitaId: map['tipoReceitaId'],
      tipoNotificacaoId: map['tipoNotificacaoId'],
    );
  }
}
