import 'dart:async';
import 'package:farmasys/dto/item.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/repository/interface/i_repository_item.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/service/interface/i_service_item.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceItem<T extends Item, U extends Medicamento> extends ServiceEntityBase<T> implements IServiceItem<T> {
  // ignore: unused_field
  final IRepositoryItem<T> _repositoryItem;

  final IRepositoryMedicamento<U> _repositoryMedicamento;

  ServiceItem(this._repositoryItem, this._repositoryMedicamento) : super(_repositoryItem);

  @override
  Future<List<T>> all() async {
    final itens = await super.all();
    return await Future.wait(
      itens.map((item) async {
        item.medicamento = await _repositoryMedicamento.getById(item.medicamentoId!);
        return item;
      }),
    );
  }

  @override
  Future<T?> getById(String id) async {
    final item = await super.getById(id);
    if (item != null) {
      item.medicamento = await _repositoryMedicamento.getById(item.medicamentoId!);
    }
    return item;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> save(T item) {
    if (item.medicamentoId == null) {
      throw Exception('A propriedade medicamentoId não pode ser nula!');
    }
    return super.save(item);
  }

  @override
  Stream<List<T>> streamAll() {
    return super.streamAll().asyncMap((itens) async {
      return await Future.wait(
        itens.map((item) async {
          item.medicamento = await _repositoryMedicamento.getById(item.medicamentoId!);
          return item;
        }),
      );
    });
  }
}
