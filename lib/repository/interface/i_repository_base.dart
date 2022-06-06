import 'package:farmasys/dto/inteface/i_entity.dart';

abstract class IRepositoryBase<T extends IEntity> {
  Future<void> add(T entity);
  Future<List<T>> all();
  Future<void> remove(T entity);
  Future<T?> getById(String id);
  Stream<List<T>> streamAll();
  Future<void> update(T entity);
}
