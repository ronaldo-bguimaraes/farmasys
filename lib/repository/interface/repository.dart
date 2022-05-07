import 'package:farmasys/dto/inteface/dto.dart';

abstract class IRepository<T extends Dto> {
  Future<void> add(T dto);
  Future<List<T>> list();
  Future<void> update(T dto);
  Future<void> delete(T dto);
  Future<T?> get(String id);
}
