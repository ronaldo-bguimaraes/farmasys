import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/medico.dart';
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

  @override
  Future<List<Medico>> getAll([IEntity? relatedEntity]) async {
    final medicos = await super.getAll();
    medicos.sort((a, b) => a.nome.compareTo(b.nome));
    return await Future.wait(
      medicos.map((medico) async {
        medico.especialidade = await _repositoryEspecialidade.getById(medico.especialidadeId!);
        return medico;
      }),
    );
  }

  @override
  Future<Medico?> getById(String? id, [IEntity? relatedEntity]) async {
    final medico = await super.getById(id);
    if (medico != null) {
      medico.especialidade = await _repositoryEspecialidade.getById(medico.especialidadeId!);
    }
    return medico;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Medico> save(Medico medico, [IEntity? relatedEntity]) {
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
          medico.especialidade = await _repositoryEspecialidade.getById(medico.especialidadeId!);
          return medico;
        }),
      );
    });
  }
}
