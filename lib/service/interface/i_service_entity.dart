import 'package:farmasys/dto/inteface/i_entity.dart';

abstract class IServiceEntity<T extends IEntity> {
  Future<T> save(T entity, [IEntity? relatedEntity]);
  Future<List<T>> getAll([IEntity? relatedEntity]);
  Future<void> remove(T entity, [IEntity? relatedEntity]);
  Future<T?> getById(String? id, [IEntity? relatedEntity]);
  Stream<List<T>> streamAll([IEntity? relatedEntity]);
}
