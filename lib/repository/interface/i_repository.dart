import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/mapper/interface/i_mapper_base.dart';

abstract class IRepository<T extends IEntity> {
  abstract final String tableName;
  abstract final IMapper<T> mapper;

  Future<T> add(T entity, [IEntity? relatedEntity]);
  Future<List<T>> getAll([IEntity? relatedEntity]);
  Future<void> remove(T entity, [IEntity? relatedEntity]);
  Future<T?> getById(String? id, [IEntity? relatedEntity]);
  Stream<List<T>> streamAll([IEntity? relatedEntity]);
  Future<T> set(T entity, [IEntity? relatedEntity]);
}
