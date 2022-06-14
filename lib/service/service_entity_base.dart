import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository.dart';
import 'package:farmasys/service/interface/i_service_entity.dart';

abstract class ServiceEntityBase<T extends IEntity> implements IServiceEntity<T> {
  final IRepository<T> _repositoryEntity;

  ServiceEntityBase(this._repositoryEntity);

  @override
  Future<List<T>> getAll([IEntity? relatedEntity]) async {
    return await _repositoryEntity.getAll(relatedEntity);
  }

  @override
  Future<void> remove(T entity) async {
    final entityId = entity.id;
    if (entityId == null) {
      throw ExceptionMessage(
        code: 'id-nulo',
        message: 'O id não pode ser nulo.',
      );
    }
    return await _repositoryEntity.remove(entity);
  }

  @override
  Future<T?> getById(String? id) async {
    return _repositoryEntity.getById(id);
  }

  @override
  Future<T> save(T entity) async {
    if (entity.id == null) {
      return await _repositoryEntity.add(entity);
    }
    //
    return await _repositoryEntity.set(entity);
  }

  @override
  Stream<List<T>> streamAll([IEntity? relatedEntity]) {
    return _repositoryEntity.streamAll(relatedEntity);
  }
}
