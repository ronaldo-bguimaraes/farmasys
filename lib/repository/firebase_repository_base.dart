import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/mapper/interface/i_mapper_base.dart';
import 'package:farmasys/repository/interface/i_repository_base.dart';

abstract class FirebaseRepositoryBase<T extends IEntity> implements IRepositoryBase<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Map<String, dynamic>> collecion;
  final IMapper<T> mapper;

  FirebaseRepositoryBase(String collecionName, this.mapper) {
    collecion = _firestore.collection(collecionName);
  }

  @override
  Future<void> add(T entity) async {
    final map = mapper.toMap(entity);
    map.remove('id');
    final ref = await collecion.add(map);
    entity.id = ref.id;
  }

  @override
  Future<List<T>> all() async {
    final query = await collecion.get();
    return query.docs.map((snapshot) {
      final map = snapshot.data();
      map.addAll({
        'id': snapshot.id,
      });
      return mapper.fromMap(map);
    }).toList();
  }

  @override
  Future<void> remove(T entity) async {
    await collecion.doc(entity.id).delete();
  }

  @override
  Future<T?> getById(String id) async {
    final snapshot = await collecion.doc(id).get();
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
  Stream<List<T>> streamAll() {
    return collecion.snapshots().map((query) {
      return query.docs.map((snapshot) {
        final map = snapshot.data();
        map['id'] = snapshot.id;
        return mapper.fromMap(map);
      }).toList();
    });
  }

  @override
  Future<void> update(T entity) async {
    final map = mapper.toMap(entity);
    map.remove('id');
    await collecion.doc(entity.id).update(map);
  }
}
