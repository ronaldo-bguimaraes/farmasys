import 'dart:async';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/substancia.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/repository/interface/i_repository_substancia.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceMedicamento<T extends Medicamento, U extends Substancia> extends ServiceEntityBase<T> implements IServiceMedicamento<T> {
  // ignore: unused_field
  final IRepositoryMedicamento<T> _repositoryMedicamento;

  final IRepositorySubstancia<U> _repositorySubstancia;

  ServiceMedicamento(this._repositoryMedicamento, this._repositorySubstancia) : super(_repositoryMedicamento);

  @override
  Future<List<T>> all() async {
    final medicamentos = await super.all();
    return await Future.wait(
      medicamentos.map((medicamento) async {
        medicamento.principioAtivo = await _repositorySubstancia.getById(medicamento.principioAtivoId!);
        return medicamento;
      }),
    );
  }

  @override
  Future<T?> getById(String id) async {
    final medicamento = await super.getById(id);
    if (medicamento != null) {
      medicamento.principioAtivo = await _repositorySubstancia.getById(medicamento.principioAtivoId!);
    }
    return medicamento;
  }

    @override
  // ignore: avoid_renaming_method_parameters
  Future<void> save(T medicamento) {
    if (medicamento.principioAtivoId == null) {
      throw Exception('A propriedade principioAtivoId não pode ser nula!');
    }
    return super.save(medicamento);
  }

  @override
  Stream<List<T>> streamAll() {
    return super.streamAll().asyncMap((medicamentos) async {
      return await Future.wait(
        medicamentos.map((medicamento) async {
          medicamento.principioAtivo = await _repositorySubstancia.getById(medicamento.principioAtivoId!);
          return medicamento;
        }),
      );
    });
  }
}
