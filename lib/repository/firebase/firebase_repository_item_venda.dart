import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/item_venda.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_venda.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_item_venda.dart';

class FirebaseRepositoryItemVenda extends FirebaseRepositoryBase<ItemVenda> implements IRepositoryItemVenda {
  // ignore: unused_field
  final IMapperItemVenda _mapper;

  FirebaseRepositoryItemVenda(this._mapper) : super('itensVenda', _mapper);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<ItemVenda> add(ItemVenda itemVenda, [IEntity? relatedEntity]) async {
    final map = mapper.toMap(itemVenda);
    map.remove('id');
    final ref = await firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).add(map);
    itemVenda.id = ref.id;
    return itemVenda;
  }

  @override
  Future<List<ItemVenda>> getAll([IEntity? relatedEntity]) async {
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
  Future<void> remove(ItemVenda itemVenda, [IEntity? relatedEntity]) async {
    await firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).doc(itemVenda.id).delete();
  }

  @override
  Future<ItemVenda?> getById(String? id, [IEntity? relatedEntity]) async {
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
  Stream<List<ItemVenda>> streamAll([IEntity? relatedEntity]) {
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
  Future<ItemVenda> set(ItemVenda itemVenda, [IEntity? relatedEntity]) async {
    final map = mapper.toMap(itemVenda);
    map.remove('id');
    await firestore.collection('vendas').doc(relatedEntity?.id).collection(tableName).doc(itemVenda.id).set(map);
    return itemVenda;
  }
}
