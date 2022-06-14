import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/mapper/interface/i_mapper_base.dart';

abstract class IRepository<T extends IEntity> {
  abstract final String tableName;
  abstract final IMapper<T> mapper;

  Future<T> add(T entity);
  Future<List<T>> getAll([IEntity? relatedEntity]);
  Future<void> remove(T entity);
  Future<T?> getById(String? id);
  Stream<List<T>> streamAll([IEntity? relatedEntity]);
  Future<T> set(T entity);
}
