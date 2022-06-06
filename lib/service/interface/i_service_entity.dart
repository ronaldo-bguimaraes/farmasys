import 'package:farmasys/dto/inteface/i_entity.dart';

abstract class IServiceEntity<T extends IEntity> {
  Future<void> save(T entity);
  Future<List<T>> all();
  Future<void> remove(T entity);
  Future<T?> getById(String id);
  Stream<List<T>> streamAll();
}
