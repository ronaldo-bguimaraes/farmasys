import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/mapper/interface/i_mapper_base.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class FirebaseRepositoryBase<T extends IEntity> implements IRepository<T> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  final String tableName;
  @override
  final IMapper<T> mapper;

  FirebaseRepositoryBase(this.tableName, this.mapper);

  @override
  Future<T> add(T entity, [IEntity? relatedEntity]) async {
    final map = mapper.toMap(entity);
    map.remove('id');
    final ref = await firestore.collection(tableName).add(map);
    entity.id = ref.id;
    return entity;
  }

  @override
  Future<List<T>> getAll([IEntity? relatedEntity]) async {
    final query = await firestore.collection(tableName).get();
    return query.docs.map((snapshot) {
      final map = snapshot.data();
      map.addAll({
        'id': snapshot.id,
      });
      return mapper.fromMap(map);
    }).toList();
  }

  @override
  Future<void> remove(T entity, [IEntity? relatedEntity]) async {
    await firestore.collection(tableName).doc(entity.id).delete();
  }

  @override
  Future<T?> getById(String? id, [IEntity? relatedEntity]) async {
    final snapshot = await firestore.collection(tableName).doc(id).get();
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
  Stream<List<T>> streamAll([IEntity? relatedEntity]) {
    return firestore.collection(tableName).snapshots().map((query) {
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
  Future<T> set(T entity, [IEntity? relatedEntity]) async {
    final map = mapper.toMap(entity);
    map.remove('id');
    await firestore.collection(tableName).doc(entity.id).set(map);
    return entity;
  }
}
