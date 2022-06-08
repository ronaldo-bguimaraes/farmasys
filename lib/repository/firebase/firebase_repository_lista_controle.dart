import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_lista_controle.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';

class FirebaseRepositoryListaControle extends FirebaseRepositoryBase<ListaControle> implements IRepositoryListaControle {
  final IMapperListaControle _mapper;

  FirebaseRepositoryListaControle(this._mapper) : super('listasControle', _mapper);

  @override
  Future<ListaControle?> getByTipoNotificacao(TipoNotificacao tipoNotificacao) async {
    final query = await firestore.collection(tableName).where('tipoNotificacaoId', isEqualTo: tipoNotificacao.id).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return _mapper.fromMap(map);
  }

  @override
  Future<ListaControle?> getByTipoReceita(TipoReceita tipoReceita) async {
    final query = await firestore.collection(tableName).where('tipoReceitaId', isEqualTo: tipoReceita.id).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return _mapper.fromMap(map);
  }
}
