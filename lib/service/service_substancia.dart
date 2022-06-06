import 'dart:async';
import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/substancia.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_substancia.dart';
import 'package:farmasys/service/interface/i_service_substancia.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceSubstancia<T extends Substancia, U extends ListaControle> extends ServiceEntityBase<T> implements IServiceSubstancia<T> {
  // ignore: unused_field
  final IRepositorySubstancia<T> _repositorySubstancia;

  final IRepositoryListaControle<U> _repositoryListaControle;

  ServiceSubstancia(this._repositorySubstancia, this._repositoryListaControle) : super(_repositorySubstancia);

  @override
  Future<List<T>> all() async {
    final substancias = await super.all();
    return await Future.wait(
      substancias.map((substancia) async {
        substancia.listaControle = await _repositoryListaControle.getById(substancia.listaControleId!);
        return substancia;
      }),
    );
  }

  @override
  Future<T?> getById(String id) async {
    final substancia = await super.getById(id);
    if (substancia != null) {
      substancia.listaControle = await _repositoryListaControle.getById(substancia.listaControleId!);
    }
    return substancia;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> save(T substancia) {
    if (substancia.listaControleId == null) {
      throw Exception('A propriedade listaControleId não pode ser nula!');
    }
    return super.save(substancia);
  }

  @override
  Stream<List<T>> streamAll() {
    return super.streamAll().asyncMap((substancias) async {
      return await Future.wait(
        substancias.map((substancia) async {
          substancia.listaControle = await _repositoryListaControle.getById(substancia.listaControleId!);
          return substancia;
        }),
      );
    });
  }
}
