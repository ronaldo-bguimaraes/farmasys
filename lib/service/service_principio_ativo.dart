import 'dart:async';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/repository/interface/i_repository_principio_ativo.dart';
import 'package:farmasys/service/interface/i_service_principio_ativo.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServicePrincipioAtivo extends ServiceEntityBase<PrincipioAtivo> implements IServicePrincipioAtivo {
  // ignore: unused_field
  final IRepositoryPrincipioAtivo _repositoryPrincipioAtivo;

  final IRepositoryListaControle _repositoryListaControle;

  final IRepositoryMedicamento _repositoryMedicamento;

  ServicePrincipioAtivo(this._repositoryPrincipioAtivo, this._repositoryListaControle, this._repositoryMedicamento) : super(_repositoryPrincipioAtivo);

  @override
  Future<List<PrincipioAtivo>> getAll([IEntity? relatedEntity]) async {
    final principiosAtivos = await super.getAll();
    principiosAtivos.sort((a, b) => a.nome.compareTo(b.nome));
    return await Future.wait(
      principiosAtivos.map((principioAtivo) async {
        if (principioAtivo.listaControleId != null) {
          principioAtivo.listaControle = await _repositoryListaControle.getById(principioAtivo.listaControleId);
        }
        return principioAtivo;
      }),
    );
  }

  @override
  Future<PrincipioAtivo?> getById(String? id, [IEntity? relatedEntity]) async {
    final principioAtivo = await super.getById(id);
    if (principioAtivo != null) {
      if (principioAtivo.listaControleId != null) {
        principioAtivo.listaControle = await _repositoryListaControle.getById(principioAtivo.listaControleId);
      }
    }
    return principioAtivo;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> remove(PrincipioAtivo principioAtivo, [IEntity? relatedEntity]) async {
    if (principioAtivo.id == null) {
      throw ExceptionMessage(
        code: 'id-nulo',
        message: 'O id do princípio ativo não pode ser nulo.',
      );
    }
    Medicamento? medicamento = await _repositoryMedicamento.getByPrincipioAtivo(principioAtivo);
    if (medicamento != null) {
      throw ExceptionMessage(
        code: 'em-uso',
        message: 'O princípio ativo está em uso.',
      );
    }
    //
    else {
      await super.remove(principioAtivo);
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<PrincipioAtivo> save(PrincipioAtivo principioAtivo, [IEntity? relatedEntity]) {
    return super.save(principioAtivo);
  }

  @override
  Stream<List<PrincipioAtivo>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().asyncMap((principiosAtivos) async {
      principiosAtivos.sort((a, b) => a.nome.compareTo(b.nome));
      return await Future.wait(
        principiosAtivos.map((principioAtivo) async {
          if (principioAtivo.listaControleId != null) {
            principioAtivo.listaControle = await _repositoryListaControle.getById(principioAtivo.listaControleId);
          }
          return principioAtivo;
        }),
      );
    });
  }
}
