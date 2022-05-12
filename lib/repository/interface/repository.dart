import 'package:farmasys/dto/inteface/entity_base.dart';

abstract class IRepository<T extends EntityBase> {
  Future<void> add(T dto);
  Stream<List<T>> all();
  Future<void> update(T dto);
  Future<void> delete(T dto);
  Future<T?> get(String id);
}
