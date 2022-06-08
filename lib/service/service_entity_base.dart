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
  Future<void> remove(T entity, [IEntity? relatedEntity]) async {
    final entityId = entity.id;
    if (entityId == null) {
      throw ExceptionMessage(
        code: 'id-nulo',
        message: 'O id não pode ser nulo.',
      );
    }
    _repositoryEntity.remove(entity, relatedEntity);
  }

  @override
  Future<T?> getById(String? id, [IEntity? relatedEntity]) async {
    return _repositoryEntity.getById(id, relatedEntity);
  }

  @override
  Future<T> save(T entity, [IEntity? relatedEntity]) async {
    if (entity.id == null) {
      return await _repositoryEntity.add(entity, relatedEntity);
    }
    //
    return await _repositoryEntity.set(entity, relatedEntity);
  }

  @override
  Stream<List<T>> streamAll([IEntity? relatedEntity]) {
    return _repositoryEntity.streamAll(relatedEntity);
  }
}
