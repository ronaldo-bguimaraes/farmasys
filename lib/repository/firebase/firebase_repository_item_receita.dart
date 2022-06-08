import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/item_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_receita.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_item_receita.dart';

class FirebaseRepositoryItemReceita extends FirebaseRepositoryBase<ItemReceita> implements IRepositoryItemReceita {
  // ignore: unused_field
  final IMapperItemReceita _mapper;

  FirebaseRepositoryItemReceita(this._mapper) : super('itensReceita', _mapper);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<ItemReceita> add(ItemReceita itemReceita, [IEntity? relatedEntity]) async {
    final map = mapper.toMap(itemReceita);
    map.remove('id');
    final ref = await firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).add(map);
    itemReceita.id = ref.id;
    return itemReceita;
  }

  @override
  Future<List<ItemReceita>> getAll([IEntity? relatedEntity]) async {
    final query = await firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).get();
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
  Future<void> remove(ItemReceita itemReceita, [IEntity? relatedEntity]) async {
    await firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).doc(itemReceita.id).delete();
  }

  @override
  Future<ItemReceita?> getById(String? id, [IEntity? relatedEntity]) async {
    final snapshot = await firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).doc(id).get();
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
  Stream<List<ItemReceita>> streamAll([IEntity? relatedEntity]) {
    return firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).snapshots().map((query) {
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
  Future<ItemReceita> set(ItemReceita itemReceita, [IEntity? relatedEntity]) async {
    final map = mapper.toMap(itemReceita);
    map.remove('id');
    await firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).doc(itemReceita.id).set(map);
    return itemReceita;
  }
}
