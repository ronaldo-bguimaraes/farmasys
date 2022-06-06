import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/repository/interface/i_repository_base.dart';
import 'package:farmasys/service/interface/i_service_entity.dart';

abstract class ServiceEntityBase<T extends IEntity> implements IServiceEntity<T> {
  final IRepositoryBase<T> _repositoryEntity;

  ServiceEntityBase(this._repositoryEntity);

  @override
  Future<List<T>> all() async {
    return await _repositoryEntity.all();
  }

  @override
  Future<void> remove(T entity) async {
    _repositoryEntity.remove(entity);
  }

  @override
  Future<T?> getById(String id) async {
    return _repositoryEntity.getById(id);
  }

  @override
  Future<void> save(T entity) async {
    if (entity.id == null) {
      return _repositoryEntity.add(entity);
    }
    return _repositoryEntity.update(entity);
  }

  @override
  Stream<List<T>> streamAll() {
    return _repositoryEntity.streamAll();
  }
}
