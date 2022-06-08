import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_notificacao.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_notificacao.dart';

class FirebaseRepositoryNotificacao extends FirebaseRepositoryBase<Notificacao> implements IRepositoryNotificacao {
  // ignore: unused_field
  final IMapperNotificacao _mapper;

  FirebaseRepositoryNotificacao(this._mapper) : super('notificacoes', _mapper);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Notificacao> add(Notificacao notificacao, [IEntity? relatedEntity]) async {
    final map = mapper.toMap(notificacao);
    map.remove('id');
    final ref = await firestore.collection('receitas').doc(relatedEntity?.id).collection(tableName).add(map);
    notificacao.id = ref.id;
    return notificacao;
  }

  @override
  Future<List<Notificacao>> getAll([IEntity? relatedEntity]) async {
    final query = await firestore.collection('receitas').doc(relatedEntity?.id).collection(tableName).get();
    return query.docs.map((snapshot) {
      final map = snapshot.data();
      map.addAll({
        'id': snapshot.id,
      });
      return mapper.fromMap(map);
    }).toList();
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> remove(Notificacao notificacao, [IEntity? relatedEntity]) async {
    await firestore.collection('receitas').doc(relatedEntity?.id).collection(tableName).doc(notificacao.id).delete();
  }

  @override
  Future<Notificacao?> getById(String? id, [IEntity? relatedEntity]) async {
    final snapshot = await firestore.collection('receitas').doc(relatedEntity?.id).collection(tableName).doc(id).get();
    final map = snapshot.data();
    if (map != null) {
      map.addAll({
        'id': snapshot.id,
      });
      return mapper.fromMap(map);
    }
    return null;
  }

  @override
  Stream<List<Notificacao>> streamAll([IEntity? relatedEntity]) {
    return firestore.collection('receitas').doc(relatedEntity?.id).collection(tableName).snapshots().map((query) {
      return query.docs.map((snapshot) {
        final map = snapshot.data();
        map.addAll({
          'id': snapshot.id,
        });
        return mapper.fromMap(map);
      }).toList();
    });
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Notificacao> set(Notificacao notificacao, [IEntity? relatedEntity]) async {
    final map = mapper.toMap(notificacao);
    map.remove('id');
    await firestore.collection('receitas').doc(relatedEntity?.id).collection(tableName).doc(notificacao.id).set(map);
    return notificacao;
  }
}
