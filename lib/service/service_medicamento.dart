import 'dart:async';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/interface/i_service_principio_ativo.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceMedicamento extends ServiceEntityBase<Medicamento> implements IServiceMedicamento {
  // ignore: unused_field
  final IRepositoryMedicamento _repositoryMedicamento;

  final IServicePrincipioAtivo _repositoryPrincipioAtivo;

  ServiceMedicamento(
    this._repositoryMedicamento,
    this._repositoryPrincipioAtivo,
  ) : super(_repositoryMedicamento);

  Future<Medicamento> _getRelatedData(Medicamento medicamento) async {
    final principioAtivo = await _repositoryPrincipioAtivo.getById(medicamento.principioAtivoId);
    if (principioAtivo == null) {
      throw ExceptionMessage(
        code: 'error-get-data',
        message: 'Erro ao buscar princípio ativo.',
      );
    }
    medicamento.principioAtivo = principioAtivo;
    return medicamento;
  }

  @override
  Future<List<Medicamento>> getAll([IEntity? relatedEntity]) async {
    final medicamentos = await super.getAll();
    medicamentos.sort((a, b) => a.nome.compareTo(b.nome));
    return await Future.wait(
      medicamentos.map((medicamento) async {
        return await _getRelatedData(medicamento);
      }),
    );
  }

  @override
  Future<Medicamento?> getById(String? id) async {
    final medicamento = await super.getById(id);
    if (medicamento != null) {
      return await _getRelatedData(medicamento);
    }
    return medicamento;
  }

  @override
  Future<Medicamento?> getByPrincipioAtivo(PrincipioAtivo principioAtivo) async {
    final medicamento = await _repositoryMedicamento.getByPrincipioAtivo(principioAtivo);
    if (medicamento != null) {
      if (medicamento.principioAtivoId != null) {
        return await _getRelatedData(medicamento);
      }
    }
    return medicamento;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Medicamento> save(Medicamento medicamento) {
    if (medicamento.principioAtivoId == null) {
      throw Exception('A propriedade principioAtivoId não pode ser nula.');
    }
    return super.save(medicamento);
  }

  @override
  Stream<List<Medicamento>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().asyncMap((medicamentos) async {
      medicamentos.sort((a, b) => a.nome.compareTo(b.nome));
      return await Future.wait(
        medicamentos.map((medicamento) async {
          return await _getRelatedData(medicamento);
        }),
      );
    });
  }
}
