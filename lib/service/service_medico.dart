import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceMedico extends ServiceEntityBase<Medico> implements IServiceMedico {
  // ignore: unused_field
  final IRepositoryMedico _repositoryMedico;

  final IRepositoryEspecialidade _repositoryEspecialidade;

  ServiceMedico(
    this._repositoryMedico,
    this._repositoryEspecialidade,
  ) : super(_repositoryMedico);

  Future<Medico> _getRelatedData(Medico medico) async {
    final especialidade = await _repositoryEspecialidade.getById(medico.especialidadeId);
    if (especialidade != null) {
      medico.especialidade = especialidade;
    }
    //
    else {
      throw ExceptionMessage(
        code: 'erro-get-data',
        message: 'Erro ao buscar especialidade do médico.',
      );
    }
    return medico;
  }

  @override
  Future<List<Medico>> getAll([IEntity? relatedEntity]) async {
    final medicos = await super.getAll();
    medicos.sort((a, b) => a.nome.compareTo(b.nome));
    return await Future.wait(
      medicos.map((medico) async {
        return await _getRelatedData(medico);
      }),
    );
  }

  @override
  Future<Medico?> getById(String? id) async {
    final medico = await super.getById(id);
    if (medico != null) {
      return await _getRelatedData(medico);
    }
    return medico;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Medico> save(Medico medico) {
    if (medico.especialidadeId == null) {
      throw Exception('A propriedade especialidadeId não pode ser nula.');
    }
    return super.save(medico);
  }

  @override
  Stream<List<Medico>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().asyncMap((medicos) async {
      medicos.sort((a, b) => a.nome.compareTo(b.nome));
      return await Future.wait(
        medicos.map((medico) async {
          return await _getRelatedData(medico);
        }),
      );
    });
  }
}
