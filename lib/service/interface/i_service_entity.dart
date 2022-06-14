import 'package:farmasys/dto/inteface/i_entity.dart';

abstract class IServiceEntity<T extends IEntity> {
  Future<T> save(T entity);
  Future<List<T>> getAll([IEntity? relatedEntity]);
  Future<void> remove(T entity);
  Future<T?> getById(String? id);
  Stream<List<T>> streamAll([IEntity? relatedEntity]);
}
