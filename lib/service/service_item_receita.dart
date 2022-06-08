import 'dart:async';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/item_receita.dart';
import 'package:farmasys/repository/interface/i_repository_item_receita.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/service/interface/i_service_item_receita.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceItemReceita extends ServiceEntityBase<ItemReceita> implements IServiceItemReceita {
  // ignore: unused_field
  final IRepositoryItemReceita _repositoryItemReceita;

  final IRepositoryMedicamento _repositoryMedicamento;

  ServiceItemReceita(
    this._repositoryItemReceita,
    this._repositoryMedicamento,
  ) : super(_repositoryItemReceita);

  @override
  Future<List<ItemReceita>> getAll([IEntity? relatedEntity]) async {
    final itensReceita = await super.getAll();
    return await Future.wait(
      itensReceita.map((itemReceita) async {
        itemReceita.medicamento = await _repositoryMedicamento.getById(itemReceita.medicamentoId, relatedEntity);
        return itemReceita;
      }),
    );
  }

  @override
  Future<ItemReceita?> getById(String? id, [IEntity? relatedEntity]) async {
    final itemReceita = await super.getById(id);
    if (itemReceita != null) {
      itemReceita.medicamento = await _repositoryMedicamento.getById(itemReceita.medicamentoId, relatedEntity);
    }
    return itemReceita;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<ItemReceita> save(ItemReceita itemReceita, [IEntity? relatedEntity]) {
    if (itemReceita.medicamentoId == null) {
      throw Exception('A propriedade medicamentoId não pode ser nula.');
    }
    return super.save(itemReceita, relatedEntity);
  }

  @override
  Stream<List<ItemReceita>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().asyncMap((itensReceita) async {
      return await Future.wait(
        itensReceita.map((itemReceita) async {
          itemReceita.medicamento = await _repositoryMedicamento.getById(itemReceita.medicamentoId);
          return itemReceita;
        }),
      );
    });
  }
}
