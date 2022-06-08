import 'dart:async';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/item_receita.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';
import 'package:farmasys/service/interface/i_service_item_receita.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceReceita extends ServiceEntityBase<Receita> implements IServiceReceita {
  // ignore: unused_field
  final IRepositoryReceita _repositoryReceita;

  final IServiceItemReceita _serviceItemReceita;

  ServiceReceita(this._repositoryReceita, this._serviceItemReceita) : super(_repositoryReceita);

  @override
  Future<List<Receita>> getAll([IEntity? relatedEntity]) async {
    final receitas = await super.getAll();
    return await Future.wait(
      receitas.map((receita) async {
        receita.itens = await _serviceItemReceita.getAll(receita);
        return receita;
      })
    );
  }

  @override
  Future<Receita?> getById(String? id, [IEntity? relatedEntity]) async {
    final receita = await super.getById(id);
    if (receita != null) {
      receita.itens = await _serviceItemReceita.getAll(receita);
    }
    return receita;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Receita> save(Receita receita, [IEntity? relatedEntity]) {
    if (receita.itens == null) {
      throw Exception('A propriedade itens não pode ser nula.');
    }
    for(ItemReceita item in receita.itens!) {
      _serviceItemReceita.save(item);
    }
    return super.save(receita);
  }

  @override
  Stream<List<Receita>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().asyncMap((receitas) async {
      return await Future.wait(
        receitas.map((receita) async {
          receita.itens = await _serviceItemReceita.getAll(receita);
          return receita;
        }),
      );
    });
  }
}
