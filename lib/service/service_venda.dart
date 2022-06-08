import 'dart:async';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/venda.dart';
import 'package:farmasys/repository/interface/i_repository_venda.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';
import 'package:farmasys/service/interface/i_service_venda.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceVenda extends ServiceEntityBase<Venda> implements IServiceVenda {
  // ignore: unused_field
  final IRepositoryVenda _repositoryVenda;

  final IRepositoryReceita _repositoryReceita;

  ServiceVenda(this._repositoryVenda, this._repositoryReceita) : super(_repositoryVenda);

  @override
  Future<List<Venda>> getAll([IEntity? relatedEntity]) async {
    final vendas = await super.getAll();
    return await Future.wait(
      vendas.map((venda) async {
        venda.receita = await _repositoryReceita.getById(venda.receitaId);
        return venda;
      })
    );
  }

  @override
  Future<Venda?> getById(String? id, [IEntity? relatedEntity]) async {
    final venda = await super.getById(id);
    if (venda != null) {
      venda.receita = await _repositoryReceita.getById(venda.receitaId);
    }
    return venda;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Venda> save(Venda venda, [IEntity? relatedEntity]) {
    if (venda.receita == null) {
      throw Exception('A propriedade receita não pode ser nula.');
    }
    return super.save(venda);
  }

  @override
  Stream<List<Venda>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().asyncMap((vendas) async {
      return await Future.wait(
        vendas.map((venda) async {
          venda.receita = await _repositoryReceita.getById(venda.receitaId);
          return venda;
        }),
      );
    });
  }
}
