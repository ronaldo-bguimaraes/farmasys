import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_notificacao.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';

class FirebaseRepositoryTipoNotificacao extends FirebaseRepositoryBase<TipoNotificacao> implements IRepositoryTipoNotificacao {
  // ignore: unused_field
  final IMapperTipoNotificacao _mapper;

  FirebaseRepositoryTipoNotificacao(this._mapper) : super('tiposNotificacao', _mapper);

    @override
  Future<TipoNotificacao?> getByNome(String nome) async {
    final query = await firestore.collection(tableName).where('nome', isEqualTo: nome).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }
}
